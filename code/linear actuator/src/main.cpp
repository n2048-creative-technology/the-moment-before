#include <Arduino.h>
#include <AccelStepper.h>

// ---------------- Pins (classic Arduino Nano) ----------------
constexpr uint8_t PIN_PUL   = 9;   // STEP / PUL+
constexpr uint8_t PIN_DIR   = 8;   // DIR+
constexpr uint8_t PIN_ENA   = 7;   // ENA+ (active HIGH on most drivers)
constexpr uint8_t PIN_ALM   = 2;   // ALARM from driver
constexpr uint8_t PIN_LIMIT = 5;   // Limit switch (HOME), wired to GND (active LOW)

// --------------- Motion profile / travel --------------------
const long POS_A = 0;        // first endpoint (steps)
const long POS_B = 3700;     // second endpoint (steps)  (e.g. 1 rev @ 200*32u)
const float MAX_SPEED = 1800;     // steps/s (top speed after homing)
const float ACCEL     = 5000;    // steps/s^2

// --------------- Homing parameters --------------------------
const float HOME_FAST  = 500;     // steps/s during fast seek
const float HOME_SLOW  = 200;     // steps/s during latch approach
const long  HOME_CLEAR = 100;     // steps to move off the switch before final latch
const long  HOME_OFFSET = 0;      // set to a few steps if you want zero a bit off the switch

// ----------------------------------------------------------------
AccelStepper stepper(AccelStepper::DRIVER, PIN_PUL, PIN_DIR);

// ---------------- SAFETY (limit/alarm held > 1s) -------------
bool safetyFault = false;
bool inHoming    = false;            
unsigned long limitHeldSince = 0;    // 0 = not timing
unsigned long alarmHeldSince = 0;    // 0 = not timing
const unsigned long maxSafeTime = 200; //ms

inline void latchFault(const __FlashStringHelper* why) {
  if (safetyFault) return;
  safetyFault = true;
  stepper.stop();             // request decel stop
  stepper.disableOutputs();   // disable driver immediately
  Serial.print(F("SAFETY FAULT: "));
  Serial.print(why);
  Serial.println(F(" > 1s. Motor disabled. Reset required."));
}

inline void checkSafety() {
  // ----- Limit (active-LOW). Only enforce during normal motion, not homing -----
  if (!safetyFault) {
    bool limitActive = (digitalRead(PIN_LIMIT) == HIGH);
    if (limitActive) {
      if (limitHeldSince == 0) limitHeldSince = millis();
      if (millis() - limitHeldSince >= maxSafeTime) {
        latchFault(F("Limit held"));
      }
    } else {
      limitHeldSince = 0;
    }
  }

  // ----- Driver Alarm (active-HIGH). Enforce ALWAYS (even during homing) -----
  if (!safetyFault) {
    bool alarmActive = (digitalRead(PIN_ALM) == LOW);
    if (alarmActive) {
      if (alarmHeldSince == 0) alarmHeldSince = millis();
      if (millis() - alarmHeldSince >= maxSafeTime) {
        latchFault(F("Driver alarm"));
      }
    } else {
      alarmHeldSince = 0;
    }
  }
}

void homeSequence() {

  inHoming = true;

  Serial.println("initiating homing sequance");

  Serial.println("// Enable driver to move");
  stepper.enableOutputs();

  // Ensure known direction (toward switch = negative)
  stepper.setMinPulseWidth(2);         // HB808C min pulse width ~2 µs
  stepper.setMaxSpeed(HOME_FAST);

  Serial.println("1) FAST SEEK toward the switch until it engages (active LOW)");
  stepper.setSpeed(-HOME_FAST);
  while (digitalRead(PIN_LIMIT) == LOW) {
    checkSafety(); if (safetyFault) { inHoming=false; return; }
    stepper.runSpeed();
  }
  delay(20); // crude debounce

  Serial.println("2) BACK OFF until switch releases");
  stepper.setSpeed(+HOME_FAST);
  while (digitalRead(PIN_LIMIT) == HIGH) {
    checkSafety(); if (safetyFault) { inHoming=false; return; }
    stepper.runSpeed();
  }
  // move a little extra clear
  stepper.setAcceleration(ACCEL);
  stepper.move(HOME_CLEAR);
  stepper.runToPosition();

  
  Serial.println("3) SLOW APPROACH for precise latch");
  stepper.setAcceleration(0);          // use runSpeed for constant speed
  stepper.setSpeed(-HOME_SLOW);
  while (digitalRead(PIN_LIMIT) == HIGH) {
    checkSafety(); if (safetyFault) { inHoming=false; return; }
    stepper.runSpeed();
  }
  delay(20); // debounce

  Serial.println("4) Set zero, offset, and restore normal motion params");
  stepper.setCurrentPosition(0);
  if (HOME_OFFSET != 0) {
    stepper.setAcceleration(ACCEL);
    stepper.move(HOME_OFFSET);
    while (stepper.distanceToGo() != 0) {
      checkSafety(); if (safetyFault) { inHoming=false; return; }
      stepper.run();
    }
    stepper.setCurrentPosition(0);
  }
  stepper.setMaxSpeed(MAX_SPEED);
  stepper.setAcceleration(ACCEL);

  inHoming = false;
}

void setup() {
  Serial.begin(115200);

  Serial.println("setup");

  pinMode(PIN_ALM, INPUT_PULLUP); // HIGH = alarm

  // Keep outputs quiet at boot
  pinMode(PIN_PUL, OUTPUT); digitalWrite(PIN_PUL, LOW);
  pinMode(PIN_DIR, OUTPUT); digitalWrite(PIN_DIR, LOW);
  
  // Attach stepper and basic setup
  stepper.setPinsInverted(LOW,LOW,HIGH);

  // hold disabled until we start homing
  stepper.setEnablePin(PIN_ENA);
  stepper.disableOutputs();

  // Limit switch: to GND, use internal pull-up → LOW when pressed
  pinMode(PIN_LIMIT, INPUT_PULLUP);

  stepper.setMinPulseWidth(2);          // 2 µs step pulse
  stepper.setMaxSpeed(MAX_SPEED);
  stepper.setAcceleration(ACCEL);

  delay(300);                           // settle
  homeSequence();                       // do the homing pass

  // Start ping-pong motion at POS_B
  stepper.moveTo(POS_B);
}

void loop() {

  checkSafety();
  if (safetyFault) {
    // Stay inert until manual reset
    return;
  }

  // Serial.print("ALARM: ");
  // Serial.print(digitalRead(PIN_ALM) );
  // Serial.print(", LIMIT: ");
  // Serial.print(digitalRead(PIN_LIMIT) );
  // Serial.print(", SPEED: ");
  // Serial.print(stepper.speed() );
  // Serial.print(", POS: ");
  // Serial.print(stepper.currentPosition() );
  // Serial.print(", TARGET: ");
  // Serial.println(stepper.targetPosition() );

  if (digitalRead(PIN_LIMIT) == HIGH) {
    Serial.println("Limit triggered");
    homeSequence();
    if (!safetyFault) stepper.moveTo(POS_B);
  }

  // Run the current move
  stepper.run();

  // When we hit the target, flip to the other end
  if (stepper.distanceToGo() == 0) {
    long next = (stepper.targetPosition() == POS_B) ? POS_A : POS_B;
    stepper.moveTo(next);
  }

}

  