#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <FirebaseArduino.h>
#include <OneWire.h>
#include <DallasTemperature.h>

// Data wire is connected to GPIO 4
#define ONE_WIRE_BUS 4

// Setup a oneWire instance to communicate with any OneWire devices
OneWire oneWire(ONE_WIRE_BUS);

// Pass our oneWire reference to Dallas Temperature sensor
DallasTemperature sensors(&oneWire);
//----------------------------------------

#define ON_Board_LED 2  //--> Defining an On Board LED (GPIO2 = D4), used for indicators when the process of connecting to a wifi router and when there is a client request.

//----------------------------------------SSID and Password of your WiFi router
const char* ssid = "Vipan";  //--> Your wifi name
const char* password = "sunilkumar"; //--> Your wifi password
//----------------------------------------

// Firebase
#define FIREBASE_HOST "last-b7f0f-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "qhkUtOCY9e2DU9Yc3gNH2OmZx5Tk9R9zxkx8QLR2"

// for kvipen164@gmail.com
#define userId "dDlyoycN2iY67HGgifjtftiYiqy1"

unsigned long previousMillisGetHR = 0; //--> will store the last time Millis (to get Heartbeat) was updated.
unsigned long previousMillisHR = 0; //--> will store the last time Millis (to get BPM) was updated.

const long intervalGetHR = 10; //--> Interval for reading heart rate (Heartbeat) = 10ms.
const long intervalHR = 5000; //--> Interval for obtaining the BPM value based on the sample is 10 seconds.

const int PulseSensorHRWire = A0; //--> PulseSensor connected to ANALOG PIN 0 (A0 / ADC 0).
const int LED_D1 = 5; //--> LED to detect when the heart is beating. The LED is connected to PIN D1 (GPIO5) on the NodeMCU ESP12E.
int Threshold = 600; //--> Determine which Signal to "count as a beat" and which to ignore.

int cntHB = 0; //--> Variable for counting the number of heartbeats.
boolean ThresholdStat = true; //--> Variable for triggers in calculating heartbeats.
int BPMval = 0; //--> Variable to hold the result of heartbeats calculation.


//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------void handleHeartRate()
// This subroutine is executed when there is a request from the browser / client.
// This subroutine will send / display the BPM value to the browser.
void handleHeartRate() {
  digitalWrite(ON_Board_LED, LOW); //--> "ON_Board_LED" will be turned on when the request from the browser / client starts.
  String BPMvalSend = String(BPMval); 
  
  // Store here on Firebase value of BPMval
  
  digitalWrite(ON_Board_LED, HIGH); //--> Turn off the LED because the client request / browser has been processed.
}
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------void GetHeartRate()
// This subroutine is for reading the heart rate and calculating it to get the BPM value.
// To get a BPM value based on a heart rate reading for 10 seconds.
void GetHeartRate() {
  //----------------------------------------Process of reading heart rate.
  unsigned long currentMillisGetHR = millis();

  if (currentMillisGetHR - previousMillisGetHR >= intervalGetHR) {
    previousMillisGetHR = currentMillisGetHR;

    int PulseSensorHRVal = analogRead(PulseSensorHRWire);

    if (PulseSensorHRVal > Threshold && ThresholdStat == true) {
      cntHB++;
      ThresholdStat = false;
      digitalWrite(LED_D1,HIGH);
    }

    if (PulseSensorHRVal < Threshold) {
      ThresholdStat = true;
      digitalWrite(LED_D1,LOW);
    }
  }
  //----------------------------------------

  //----------------------------------------The process for getting the BPM value.
  unsigned long currentMillisHR = millis();

  if (currentMillisHR - previousMillisHR >= intervalHR) {
    previousMillisHR = currentMillisHR;

    BPMval = cntHB * 6; //--> The taken heart rate is for 10 seconds. So to get the BPM value, the total heart rate in 10 seconds x 6.
    Serial.print("BPM : ");
    Serial.println(BPMval);
    
    cntHB = 0;
  }
  //----------------------------------------
}
//--------------------------------------------------------------------------------

// Temperature in celcius
int sensor_dataC() {
  // Call sensors.requestTemperatures() to issue a global temperature and Requests to all devices on the bus
  sensors.requestTemperatures();
  int tempC = sensors.getTempCByIndex(0);

  if (tempC == -127.00) {
    Serial.println("Unable to read from sensor");
    return 0;
  } else {
    Serial.print("Temp. in Celsius: ");
    Serial.println(tempC);
  }
  Serial.println(tempC);
  return tempC;
}

//--------------------------------------------------------------------------------void setup()
void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  delay(500);

  // Start up the DS18B20 library
  sensors.begin();
  
  pinMode(ON_Board_LED,OUTPUT); //--> On Board LED port Direction output
  digitalWrite(ON_Board_LED, HIGH); //--> Turn off Led On Board

  pinMode(LED_D1,OUTPUT); //--> Set LED_3 PIN as Output.

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password); //--> Connect to your WiFi router
  Serial.println("");

  //----------------------------------------Wait for connection
  Serial.print("Connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    //----------------------------------------Make the On Board Flashing LED on the process of connecting to the wifi router.
    digitalWrite(ON_Board_LED, LOW);
    delay(250);
    digitalWrite(ON_Board_LED, HIGH);
    delay(250);
    //----------------------------------------
  }
  //----------------------------------------
  digitalWrite(ON_Board_LED, HIGH); //--> Turn off the On Board LED when it is connected to the wifi router.
  //----------------------------------------If successfully connected to the wifi router, the IP Address that will be visited is displayed in the serial monitor
  Serial.println("");
  Serial.print("Successfully connected to : ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  //----------------------------------------


  Serial.println();
  Serial.println("Please wait 10 seconds to get the BPM Value");
    Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------void loop()
void loop() {
  GetHeartRate(); //--> Calling the GetHeartRate() subroutine
  Firebase.setFloat("dDlyoycN2iY67HGgifjtftiYiqy1/userData/vipen/pulseRate", BPMval+68);
  if (Firebase.failed()) {
      Serial.print("setting /number failed:");
      Serial.println(Firebase.error());  
      return;
  }
  int temp_in_c = sensor_dataC();
  Firebase.setFloat("dDlyoycN2iY67HGgifjtftiYiqy1/userData/vipen/temperature", temp_in_c);
  if (Firebase.failed()) {
      Serial.print("setting /number failed:");
      Serial.println(Firebase.error());  
      return;
  }
}
