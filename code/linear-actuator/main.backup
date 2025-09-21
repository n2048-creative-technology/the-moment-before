#include <Arduino.h>
#include <AccelStepper.h>

// ---------------- Pins (classic Arduino Nano) ----------------
constexpr uint8_t PIN_PUL   = 9;   // STEP / PUL+
constexpr uint8_t PIN_DIR   = 8;   // DIR+
constexpr uint8_t PIN_ENA   = 7;   // ENA+ (active HIGH on most drivers)
constexpr uint8_t PIN_ALM   = 2;   // ALARM from driver
constexpr uint8_t PIN_LIMIT = 5;   // Limit switch (HOME), wired to GND (active LOW)
constexpr uint8_t PIN_LED   = 13;  // onboard LED Nano Every

// --------------- Motion profile / travel --------------------
const long POS_A = 0;              // first endpoint (steps)
const long POS_B = 3000; // 3700;           // second endpoint (steps)
float MAX_SPEED = 1800;      // steps/s (top speed after homing)
const float ACCEL     = 5000;      // steps/s^2
const float SPEED_VARIANCE = 500;  // each RUN interval with randomly adjust to a new speed

// --------------- Homing parameters --------------------------
const float HOME_FAST  = 500;      // steps/s during fast seek
const float HOME_SLOW  = 200;      // steps/s during latch approach
const long  HOME_CLEAR = 100;      // steps to move off the switch before final latch
const long  HOME_OFFSET = 0;

// --------------- Pause scheduler ----------------------------
unsigned long RUN_INTERVAL_MS = 2UL * 60UL * 1000UL;  // 30 minutes
unsigned long PAUSE_MS        = 1UL  * 60UL * 1000UL;  // 1 minutes
const unsigned long PAUSE_VARIANCE        = 30UL * 1000UL;  // 30 seconds
const unsigned long RUN_VARIANCE_VARIANCE =  1UL  * 60UL * 1000UL;  // 1 minute

enum RunState : uint8_t { RUNNING, PAUSING, PAUSED };
RunState runState = RUNNING;
unsigned long lastResumeMs = 0;    // when RUNNING started
unsigned long pauseStartMs = 0;    // when PAUSED started

// ----------------------------------------------------------------
AccelStepper stepper(AccelStepper::DRIVER, PIN_PUL, PIN_DIR);

// ---------------- SAFETY (limit/alarm held > threshold) -------
bool safetyFault = false;
bool inHoming    = false;
unsigned long limitHeldSince = 0;    // 0 = not timing
unsigned long alarmHeldSince = 0;    // 0 = not timing
const unsigned long maxSafeTime = 200; // ms (kept as in your code)


// ---------------- LED State Indicator ------------------------
void updateLED() {
  static unsigned long lastToggle = 0;
  static bool ledState = false;
  unsigned long now = millis();

  if (safetyFault) {
    // Blink fast (4Hz ~ toggle every 125ms)
    if (now - lastToggle >= 125) {
      ledState = !ledState;
      digitalWrite(PIN_LED, ledState);
      lastToggle = now;
    }
  } else if (runState == RUNNING) {
    digitalWrite(PIN_LED, HIGH);  // steady ON
  } else if (runState == PAUSED) {
    // Blink slow (1Hz ~ toggle every 1s)
    if (now - lastToggle >= 1000) {
      ledState = !ledState;
      digitalWrite(PIN_LED, ledState);
      lastToggle = now;
    }
  } else if (runState == PAUSING) {
    digitalWrite(PIN_LED, HIGH); // still ON while decelerating
  }
}


inline void latchFault(const __FlashStringHelper* why) {
  if (safetyFault) return;
  safetyFault = true;
  stepper.stop();             // request decel stop
  stepper.disableOutputs();   // disable driver immediately
  Serial.print(F("SAFETY FAULT: "));
  Serial.print(why);
  Serial.println(F(" > threshold. Motor disabled. Reset required."));
}

inline void checkSafety() {
  if (!safetyFault) {
    bool limitActive = (digitalRead(PIN_LIMIT) == HIGH); // kept as in your code
    if (limitActive) {
      if (limitHeldSince == 0) limitHeldSince = millis();
      if (millis() - limitHeldSince >= maxSafeTime) {
        latchFault(F("Limit held"));
      }
    } else {
      limitHeldSince = 0;
    }
  }

  if (!safetyFault) {
    bool alarmActive = (digitalRead(PIN_ALM) == LOW);    // kept as in your code
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

// -------------------- Homing -------------------------------
void homeSequence() {

  inHoming = true;
  digitalWrite(PIN_LED, LOW);

  Serial.println("initiating homing sequence");
  stepper.enableOutputs();

  stepper.setMinPulseWidth(2);
  stepper.setMaxSpeed(HOME_FAST);

  Serial.println("1) FAST SEEK toward the switch until it engages (active LOW)");
  stepper.setSpeed(-HOME_FAST);
  while (digitalRead(PIN_LIMIT) == LOW) {      // kept as in your code
    checkSafety(); if (safetyFault) { inHoming=false; return; }
    stepper.runSpeed();
  }
  delay(20);

  Serial.println("2) BACK OFF until switch releases");
  stepper.setSpeed(+HOME_FAST);
  while (digitalRead(PIN_LIMIT) == HIGH) {
    checkSafety(); if (safetyFault) { inHoming=false; return; }
    stepper.runSpeed();
  }

  stepper.setAcceleration(ACCEL);
  stepper.move(HOME_CLEAR);
  stepper.runToPosition();

  Serial.println("3) SLOW APPROACH for precise latch");
  stepper.setAcceleration(0);
  stepper.setSpeed(-HOME_SLOW);
  while (digitalRead(PIN_LIMIT) == HIGH) {
    checkSafety(); if (safetyFault) { inHoming=false; return; }
    stepper.runSpeed();
  }
  delay(20);

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

// -------------- Pause state machine helpers -----------------
inline void startPausing() {
  runState = PAUSING;
  Serial.println(F("Pause window reached → stopping motion..."));
  stepper.stop();                 // decelerate to stop
}

inline void maybeDisableWhenStopped() {
  // Consider the motor stopped when both are true:
  if (stepper.distanceToGo() == 0 && stepper.speed() == 0.0f) {
    stepper.disableOutputs();     // disable during the pause
    pauseStartMs = millis();
    runState = PAUSED;
    Serial.println(F("Paused: motor disabled. Waiting 5 minutes..."));
  }
}

inline void resumeAfterPause() {
  Serial.println(F("Pause finished → homing and resuming"));
  // Re-home (this function enables outputs internally)
  homeSequence();

  // adjust values for next round: 

  // --------------- Pause scheduler ----------------------------
  RUN_INTERVAL_MS = 2UL * 60UL * 1000UL  + random(RUN_VARIANCE_VARIANCE);
  PAUSE_MS        = 1UL  * 60UL * 1000UL + random(PAUSE_VARIANCE); 
  MAX_SPEED = 1800 + random(SPEED_VARIANCE) - SPEED_VARIANCE/2;

  if (!safetyFault) {
    // Resume ping-pong
    stepper.moveTo(POS_B);
    lastResumeMs = millis();
    runState = RUNNING;
    Serial.println(F("Resumed: ping-pong restarted"));
  }
}

// -------------------- Setup / Loop --------------------------
void setup() {
  Serial.begin(115200);
  Serial.println("setup");

  pinMode(PIN_ALM, INPUT_PULLUP); // HIGH = alarm (kept as-is)
  pinMode(PIN_PUL, OUTPUT); digitalWrite(PIN_PUL, LOW);
  pinMode(PIN_DIR, OUTPUT); digitalWrite(PIN_DIR, LOW);
  pinMode(PIN_LIMIT, INPUT_PULLUP); // active LOW (kept as-is)
  pinMode(PIN_LED, OUTPUT);

  stepper.setPinsInverted(LOW,LOW,HIGH);
  stepper.setEnablePin(PIN_ENA);
  stepper.disableOutputs();

  stepper.setMinPulseWidth(2);
  stepper.setMaxSpeed(MAX_SPEED);
  stepper.setAcceleration(ACCEL);

  delay(300);
  homeSequence();
  if (!safetyFault) {
    stepper.moveTo(POS_B);
    lastResumeMs = millis();
    runState = RUNNING;
  }
}

void loop() {
  checkSafety();
  updateLED();

  if (safetyFault) return;

  // if(!inHoming && digitalRead(PIN_LIMIT) == HIGH)  resumeAfterPause();

  // ---- Pause scheduler ----
  const unsigned long now = millis();

  switch (runState) {
    case RUNNING:
      // trigger pause every RUN_INTERVAL_MS since last resume
      if (!inHoming && (now - lastResumeMs >= RUN_INTERVAL_MS)) {
        delay(1000);
        startPausing();
      }
      break;

    case PAUSING:
      // keep running stepper until it has fully stopped, then disable outputs
      stepper.run();
      maybeDisableWhenStopped();
      break;

    case PAUSED:
      // wait out the pause time with outputs disabled, then home & resume
      if (now - pauseStartMs >= PAUSE_MS) {
        resumeAfterPause();
      }
      break;
  }

  // ---- Normal motion (only when RUNNING) ----
  if (runState == RUNNING) {
    // Optional: re-home if your limit logic declares it
    if (digitalRead(PIN_LIMIT) == HIGH) {          // kept as in your code
      Serial.println("Limit triggered → re-homing");
      homeSequence();
      if (!safetyFault) {
        stepper.moveTo(POS_B);
        lastResumeMs = now; // reset the 30-min window after a re-home
      }
    }

    stepper.run();

    if (stepper.distanceToGo() == 0) {
      long next = (stepper.targetPosition() == POS_B) ? POS_A : POS_B;
      stepper.moveTo(next);
    }
  }
}
