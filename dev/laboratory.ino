// C++ code
const int LEDRED    = 13;
const int LEDYELLOW = 12;
const int LEDGREEN  = 10;
const int FAN1      = 9;
int sensor_value;
float temperature;

void setup() {
    pinMode(LEDRED, OUTPUT);
    pinMode(LEDYELLOW, OUTPUT);
    pinMode(LEDGREEN, OUTPUT);
    pinMode(FAN1, OUTPUT);
    Serial.begin(9600);
}

void loop() {
    sensor_value= analogRead(A0);
    Serial.print("Sensor value: ");
    Serial.println(sensor_value);
    delay(2000);
    // Show temperature value
    temperature = (sensor_value * (500.0 / 1023.0)) - 50.0;
    Serial.print("Temperature: ");
    Serial.println(temperature);
    delay(2000);
}