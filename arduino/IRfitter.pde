

//-- 
int dist[] =   { 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,25,30,35,40,50,60,70,80};
int repeat[] = { 5,5,5,5,5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 7, 7, 7, 7};

  int N  = sizeof(dist)/sizeof(int);
const int MEASURES = 128; //80;
const int analogPin = A2;

//-- space for the measures
double values[MEASURES][2];

void setup()
{
  Serial.begin(9600); 
  /*
  int num = 0;
  for (int i = 0; i< N; i++)
    num+=repeat[i];
  
  Serial.println(num);
  delay(50000); */
  
  Serial.println("Ok. Start measuring");
}

void loop()
{
  //-- Collect data
  int index = 0;
  
  for (int i = 0; i < N; i++)
  {
    for(int j = 0; j < repeat[i]; j++)
    { 
        //-- Output
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
  
  //-- Print data
  Serial.println("Done\nCopy and paste the following data");
  
  for (int i = 0; i < MEASURES; i++)
  {
     Serial.print(values[i][0]);
     Serial.print(" ");
     Serial.println( values[i][1] );
   }
}

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
