/*
    •  A SensorDataProvider module that reads the input sensor data from a comma separated
       format (csv) file provided. Two following two files will be provided that contain the sensor
       information. The application should prompt the users to select the desired file when the
       program starts. Each file contains sensor data from the time that the car starts to work. Use
       the provided numbers in the table for initializing the car properties depending on the
       selected file.
       
       Time (second), Fuel Level (liters), RPM, Gear ratio, X (latitude) and Y (longitude) for every 
       second is stored in the file. The files will be provided for you and your dashboard 
       application should load it at the beginning depending on user selection and then in each 
       iteration should read one line and provide the input data to main classes. Once the stats like
       speed and fuel economy are calculated, the results are displayed, and the application moves 
       to the next line of data.
*/

class SensorDataProvider {
  String[] vehicleArr = {"minicar", "truck"};
  String[] dataFileNameArr = {"car_status_BMW_323i.csv", "car_status_Truck_F150.csv"};
  float[] radiusArr = {23, 25.4}; //cm
  float[] tankCapacityArr = {60, 80}; //liters
  float[] topSpeedArr = {200, 172.2}; //km/h
  int[] topGearArr = {4, 3};
  
  String filePath; //filePath to store the path of the selected sensor data file
  Table dataTable; //dataTable of type Table to load the data in the csv input file
  int currentIndex; //currentIndex representing the data row index that needs to be processed
  String vehicle;
  float radius;
  float tankCapacity;
  float topSpeed;
  int topGear;
  
  /*
    This function is called at the beginning of the program. It reads the
    whole input csv file and loads it into dataTable.
  */
  void Initialize(int vehicleIndex) {
    filePath = dataFileNameArr[vehicleIndex];
    dataTable = loadTable(filePath, "header");
    currentIndex = 0;
    vehicle = vehicleArr[vehicleIndex];
    radius = radiusArr[vehicleIndex];
    tankCapacity = tankCapacityArr[vehicleIndex];
    topSpeed = topSpeedArr[vehicleIndex];
    topGear = topGearArr[vehicleIndex];
  }
  
  /*
    This function is called in the main loop of the program (draw). Each
    call advances to the next line by incrementing currentIndex. In order to make
    sure that the program does not crashes because of null reference, there should
    be a cap on incrementing currentIndex. 
  */
  void readNext() {
    if(currentIndex < dataTable.lastRowIndex()) {
      currentIndex++;
    } else {
      delay(5000);
      simulationRunning = false;
      vehicleIndex = -1;
    }
  }
  
  int readRPM() {
    return dataTable.getRow(currentIndex).getInt("RPM");
  }
  
  float readFuelLevel() {
    return dataTable.getRow(currentIndex).getFloat("Fuel Level (liter)");
  }
  
  float readRatio() {
    return dataTable.getRow(currentIndex).getFloat("Gear Ratio");
  }
  
  float readX() {
    return dataTable.getRow(currentIndex).getFloat("X");
  }
  
  float readY() {
    return dataTable.getRow(currentIndex).getFloat("Y");
  }
}
