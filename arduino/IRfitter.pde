

//-- Some constants and arrays:
//---------------------------------------------------------------------------------------------

//-- Arrays containing the distances to be measured and the number of repetitions of each distance:
int dist[] =   { 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,25,30,35,40,50,60,70,80};
int repeat[] = { 5,5,5,5,5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 7, 7, 7, 7};

//-- Number of elements in distance array:
int N  = sizeof(dist)/sizeof(int);

//-- Total number of measurements to be done:
static const int MEASURES = 128; 

//-- Pin connected to the sensor:
static const int analogPin = A2;

//-- Some space to store the measurements:
double values[MEASURES][2];



//-- Setup function
//-- Turns on the serial port

void setup()
{
  Serial.begin(9600); 
  Serial.println("Ok. Start measuring");
}

//-- Loop Function:

void loop()
{
  //-- Collect data
  int index = 0;
  
  for (int i = 0; i < N; i++)
  {
    for(int j = 0; j < repeat[i]; j++)
    { 
        //-- Output the measure that we are performing currently:
        Serial.print( "Measure: ");
        Serial.print( dist[i] );
        Serial.println( "cm");
        
        //-- Assign values
        values[index][0] = dist[i];
        values[index][1] = readSensor();
        
        //-- Update index
        index+=1;
    }
  }
  
  //-- Once all measurements have been done, print data.
  Serial.println("Done\nCopy and paste the following data:");
  
  for (int i = 0; i < MEASURES; i++)
  {
     Serial.print(values[i][0]);
     Serial.print(" ");
     Serial.println( values[i][1] );
   }
}

//-- Read sensor function:
//----------------------------------------------
//-- Waits for user input, when some value is recieved, reads the value
//-- from the sensor and return that value in volts.

double readSensor()
{
    int flag = 0;
    
    while( flag == 0)
    {
      if (Serial.available() > 0)
        flag = 1;
    }
    
    double reading = analogRead( analogPin );
    reading = reading * 5/1023;

    Serial.print("Done: ");
    Serial.println(reading);
    
    Serial.flush();
    
    return reading;
}
