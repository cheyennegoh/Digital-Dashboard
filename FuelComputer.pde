/*
  •  A FuelComputer module that calculates fuel economy and range based on the outputs of trip
     computer and fuel tank: distance travelled, fuel consumed and fuel remaining. 
*/

class FuelComputer {
  float fuelEconomy; //km/L
  float[] fuelEconomyHistory = {};
  float fuelConsumption;
  float[] fuelConsumptionHistory = {};
  float averageFuelEconomy;
  float[] averageFuelEconomyHistory = {};
  float range; //km
  
  int time = 0;
  float speed = 0;
  float fuel = 0;
  
  void calculateFuelEconomy(float currentSpeed, float consumedFuel) {
    time += 1;
    speed += currentSpeed;
    fuel += consumedFuel;
    if (consumedFuel > 0 && currentSpeed > 0) {
      fuelEconomy = (speed/1000)*time / fuel;
      time = 0;
      speed = 0;
      fuel = 0;
    }
    if (fuelEconomy > 0) {
      fuelEconomyHistory = append(fuelEconomyHistory, fuelEconomy);
    }
  }
  
  void calculateAverageFuelEconomy() {
    float sum = 0;
    if(fuelEconomyHistory.length > 60) {
      for(int i = 0; i < subset(fuelEconomyHistory, fuelEconomyHistory.length - 60, 60).length; i++) {
        sum += subset(fuelEconomyHistory, fuelEconomyHistory.length - 60, 60)[i];
      }
      averageFuelEconomy = sum/subset(fuelEconomyHistory, fuelEconomyHistory.length - 60, 60).length;
    } else {
      for(int i = 0; i < fuelEconomyHistory.length; i++) {
        sum += fuelEconomyHistory[i];
      }
      averageFuelEconomy = sum/fuelEconomyHistory.length;
    }
    if(averageFuelEconomy > 0) {
      averageFuelEconomyHistory = append(averageFuelEconomyHistory, averageFuelEconomy);
    }
  }
  
  void calculateFuelConsumption() {
    fuelConsumption = 1 / averageFuelEconomy*100;
    if(fuelConsumption > 0) {
      fuelConsumptionHistory = append(fuelConsumptionHistory, fuelConsumption);
    }
  }
  
  void calculateRange(float fuelLevel) {
    range = averageFuelEconomy*fuelLevel;
  }
}
