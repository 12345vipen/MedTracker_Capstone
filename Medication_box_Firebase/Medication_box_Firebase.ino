//
// Copyright 2015 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

// FirebaseDemo_ESP8266 is a sample that demo the different functions
// of the FirebaseArduino API.

#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>

// Set these to run example.
#define FIREBASE_HOST "last-b7f0f-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "qhkUtOCY9e2DU9Yc3gNH2OmZx5Tk9R9zxkx8QLR2"
#define WIFI_SSID "EACCESS"
#define WIFI_PASSWORD "hostelnet"
// for kvipen164@gmail.com
#define userId "dDlyoycN2iY67HGgifjtftiYiqy1"

// For IR sensors and the medication logic
int IRSensor = 5; // connect ir sensor to arduino pin 2
int prev = 0;   // for storing previous result as buffer
int count = 31;  // take from firebase 

void setup() {
  Serial.begin(9600);
  pinMode (IRSensor, INPUT); // sensor pin INPUT
  // connect to wifi.
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());
  
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);

  // getting data previous count from Firebase

  // Remove this if code is not working
  count = Firebase.getFloat("dDlyoycN2iY67HGgifjtftiYiqy1/Medicines/vipen 6280345424/dolo/quantity");
  Serial.println(count); 
}

int n = 0;

void loop() {
  // set value
  noOfMedicines();
//  delay(1000);
  Firebase.setFloat("dDlyoycN2iY67HGgifjtftiYiqy1/Medicines/vipen 6280345424/dolo/quantity", count);
  // handle error
  if (Firebase.failed()) {
      Serial.print("setting /number failed:");
      Serial.println(Firebase.error());  
      return;
  }

  // get value 
//  Serial.print("number: ");
//  Serial.println(Firebase.getFloat("number"));
//  delay(1000);

  // remove value
//  Firebase.remove("number");
//  delay(1000);

  // set string value
//  Firebase.setString("message", "hello world");
//  // handle error
//  if (Firebase.failed()) {
//      Serial.print("setting /message failed:");
//      Serial.println(Firebase.error());  
//      return;
//  }
//  delay(1000);
  
  // set bool value
//  Firebase.setBool("truth/academy", false);
//  // handle error
//  if (Firebase.failed()) {
//      Serial.print("setting /truth failed:");
//      Serial.println(Firebase.error());  
//      return;
//  }
//  delay(1000);

  // append a new value to /logs
//  String name = Firebase.pushInt("logs", n++);
//  // handle error
//  if (Firebase.failed()) {
//      Serial.print("pushing /logs failed:");
//      Serial.println(Firebase.error());  
//      return;
//  }
//  Serial.print("pushed: /logs/");
//  Serial.println(name);
//  delay(1000);
}


// Functions for Calculating no of medicines in the box

void noOfMedicines(){
  int statusSensor = digitalRead (IRSensor);
  delay(6);  // i can remove these
  
  if (statusSensor == 1){
    if(prev==0){
      if(count>0){
        count--;
        prev = 1;
      }
    }
    Serial.println("ON");
  }
  
  else
  {
    if(prev==1){
      prev = 0;
      }
    Serial.println("OFF");
  }
  Serial.println(count);
}
