/*
  •  A TripComputer that calculates speed and distance travelled based on RPM and Gear Ratio.
     Details of calculations are provided in equation (1).
*/

class TripComputer {
  int RPM;
  float gearRatio;
  float totalTravelledDistance; //m
  float radius; //cm
  
  /*
    Calculates speed of the car in m/s.
  */
  float getCurrentSpeed() {
    return ((float)RPM / 60)*(1 / gearRatio)*2*PI*(radius/100); //m/s
  }
  
  void updateTotalDistance() {
    totalTravelledDistance += getCurrentSpeed(); //m
  }
  
  void setRPM(int value) {
    RPM = value;
  }
  
  void setGearRatio(float value) {
    gearRatio = value;
  }
  
  void setRadius(float value) {
    radius = value;
  }
}
