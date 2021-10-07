#include <ESP8266WiFi.h>
#include <OneWire.h>
#include <DallasTemperature.h>

// Data wire is connected to GPIO 4
#define ONE_WIRE_BUS 4

// Setup a oneWire instance to communicate with any OneWire devices
OneWire oneWire(ONE_WIRE_BUS);

// Pass our oneWire reference to Dallas Temperature sensor
DallasTemperature sensors(&oneWire);

// Replace with your network credentials
const char* ssid = "EACCESS";
const char* password = "hostelnet";


String sensor_dataC() {
  // Call sensors.requestTemperatures() to issue a global temperature and Requests to all devices on the bus
  sensors.requestTemperatures();
  float tempC = sensors.getTempCByIndex(0);

  if (tempC == -127.00) {
    Serial.println("Unable to read from sensor");
    return "--";
  } else {
    Serial.print("Temp. in Celsius: ");
    Serial.println(tempC);
  }
  Serial.println(tempC);
  return String(tempC);
}
String sensor_dataF() {
  // Call sensors.requestTemperatures() to issue a global temperature and Requests to all devices on the bus
  sensors.requestTemperatures();
  float tempF = sensors.getTempFByIndex(0);

  if (int(tempF) == -196) {
    Serial.println("Unable to read from sensor");
    return "--";
  } else {
    Serial.print("Temp. in Fahrenheit: ");
    Serial.println(tempF);
  }
  Serial.println(tempF);
  return String(tempF);
}



// Replaces placeholder with DHT values
String update_data(const String& var)
{
  //Serial.println(var);
  if (var == "TEMPC") {
    return sensor_dataC();
  }
  else if (var == "TEMPF") {
    return sensor_dataF();
  }
  return String();
}

void setup() {
  // Serial port for debugging purposes
  Serial.begin(115200);
  Serial.println();

  // Start up the DS18B20 library
  sensors.begin();

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  Serial.println("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();

  // Print ESP Local IP Address
  Serial.println(WiFi.localIP());

}

void loop() {
  sensor_dataC();
//sensor_dataF();
}
