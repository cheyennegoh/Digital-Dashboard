class Car {
  TripComputer tripComputer = new TripComputer();
  FuelTank fuelTank = new FuelTank();
  FuelComputer fuelComputer = new FuelComputer();
  Location location = new Location();
  
  void processInput(int RPM, float gearRatio, float fuelLevel, float x, float y) {
    tripComputer.setRPM(RPM);
    tripComputer.setGearRatio(gearRatio);
    fuelTank.setFuelLevel(fuelLevel);
    location.setLocation(x, y);
    tripComputer.updateTotalDistance();
    fuelComputer.calculateFuelEconomy(tripComputer.getCurrentSpeed(), fuelTank.getConsumedFuel());
    fuelComputer.calculateAverageFuelEconomy();
    fuelComputer.calculateFuelConsumption();
    fuelComputer.calculateRange(fuelTank.fuelLevel);
    
  }
}
