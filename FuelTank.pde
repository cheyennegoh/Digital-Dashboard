/*
  •  A FuelTank that calculates the remaining fuel using the input fuel level.
*/

class FuelTank {
  float tankCapacity; //do once
  float fuelLevel;
  float previousFuelLevel = 0;
  
  float getConsumedFuel() {
    if(previousFuelLevel == 0) {
      return 0;
    } else {
      return previousFuelLevel-fuelLevel;
    }
  }
  
  void setFuelLevel(float value) {
    previousFuelLevel = fuelLevel;
    fuelLevel = value;
  }
  
  void setTankCapacity(float value) {
    tankCapacity = value;  }
}
