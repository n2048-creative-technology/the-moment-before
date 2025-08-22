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
const long POS_B = 3600;     // second endpoint (steps)  (e.g. 1 rev @ 200*32u)
const float MAX_SPEED = 4000; //8000;     // steps/s (top speed after homing)
const float ACCEL     = 1000; //60000;    // steps/s^2

// --------------- Homing parameters --------------------------
const float HOME_FAST  = 500;    // steps/s during fast seek
const float HOME_SLOW  = 200;     // steps/s during latch approach
const long  HOME_CLEAR = 200;     // steps to move off the switch before final latch
const long  HOME_OFFSET = 0;      // set to a few steps if you want zero a bit off the switch

// ----------------------------------------------------------------
AccelStepper stepper(AccelStepper::DRIVER, PIN_PUL, PIN_DIR);


void homeSequence() {
  Serial.println("initiating homing sequance");

  Serial.println("// Enable driver to move");
  stepper.enableOutputs();

  // Ensure known direction (toward switch = negative)
  stepper.setMinPulseWidth(2);         // HB808C min pulse width ~2 µs
  stepper.setMaxSpeed(HOME_FAST);

  Serial.println("// 1) FAST SEEK toward the switch until it engages (active LOW)");
  stepper.setSpeed(-HOME_FAST);
  while (digitalRead(PIN_LIMIT) == LOW) {
    stepper.runSpeed();
  }
  delay(20); // crude debounce

  Serial.println("// 2) BACK OFF until switch releases");
  stepper.setSpeed(+HOME_FAST);
  while (digitalRead(PIN_LIMIT) == HIGH) {
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
    stepper.runSpeed();
  }
  delay(20); // debounce

  Serial.println("// 4) Set zero, optional offset, and restore normal motion params");
  stepper.setCurrentPosition(0);
  if (HOME_OFFSET != 0) {
    stepper.setAcceleration(ACCEL);
    stepper.move(HOME_OFFSET);
    stepper.runToPosition();
    stepper.setCurrentPosition(0);
  }
  stepper.setMaxSpeed(MAX_SPEED);
  stepper.setAcceleration(ACCEL);
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
  Serial.print("LIMIT: ");
  Serial.print(digitalRead(PIN_LIMIT) );
  Serial.print(", SPEED: ");
  Serial.print(stepper.speed() );
  Serial.print(", POS: ");
  Serial.print(stepper.currentPosition() );
  Serial.print(", TARGET: ");
  Serial.println(stepper.targetPosition() );
  
  if (digitalRead(PIN_LIMIT) == HIGH) {
    Serial.println("Limit triggered");
    homeSequence();
    stepper.moveTo(POS_B);
  }

  // Run the current move
  stepper.run();

  // When we hit the target, flip to the other end
  if (stepper.distanceToGo() == 0) {
    long next = (stepper.targetPosition() == POS_B) ? POS_A : POS_B;
    stepper.moveTo(next);
  }
}
