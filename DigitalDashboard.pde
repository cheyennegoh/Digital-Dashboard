import org.gicentre.utils.stat.*;
PFont font;
int vehicleIndex = -1;
SensorDataProvider sensorDataProvider;
Car car;
Gauge speedometer;
Gauge tachometer;
Gauge fuelGauge;
Gauge gearIndicator;
float[] fuelConsumptionGraphArray;
float[] averageFuelEconomyGraphArray;
float[] fuelEconomyHistoryGraphArray;
boolean simulationRunning = false;

void setup() {
  fullScreen();
  background(0);
  noStroke();
  font = createFont("DINAlternate-Bold", 32);
  textFont(font);
  frameRate(1);
}

void draw() {
  if(!simulationRunning) {
    menu();
    if(vehicleIndex >= 0) {
      sensorDataProvider = new SensorDataProvider();
      sensorDataProvider.Initialize(vehicleIndex);
      
      car = new Car();
      car.tripComputer.setRadius(sensorDataProvider.radius);
      car.fuelTank.setTankCapacity(sensorDataProvider.tankCapacity);
      
      speedometer = new Gauge();
      speedometer.minimum = 0;
      speedometer.maximum = sensorDataProvider.topSpeed;
      speedometer.unit = "km/h";
      speedometer.positionX = 0.75*width;
      speedometer.positionY = 0.5*height+0.05*width;
      speedometer.size = 0.08*width;
      
      tachometer = new Gauge();
      tachometer.minimum = 0;
      tachometer.maximum = 6;
      tachometer.unit = "RPM x 1000";
      tachometer.positionX = 0.25*width;
      tachometer.positionY = 0.5*height+0.05*width;
      tachometer.size = 0.08*width;
      
      fuelGauge = new Gauge();
      fuelGauge.minimum = 0;
      fuelGauge.maximum = sensorDataProvider.tankCapacity;
      fuelGauge.unit = "L";
      fuelGauge.positionX = 0.75*width;
      fuelGauge.positionY = 0.5*height+0.05*width;
      fuelGauge.size = 0.025*width;
      
      gearIndicator = new Gauge();
      gearIndicator.minimum = 1;
      gearIndicator.maximum = sensorDataProvider.topGear;
      gearIndicator.positionX = 0.25*width;
      gearIndicator.positionY = 0.5*height+0.05*width;
      gearIndicator.size = 0.025*width;
      
      simulationRunning = true;
    }
  } else {
    car.processInput(sensorDataProvider.readRPM(), sensorDataProvider.readRatio(), sensorDataProvider.readFuelLevel(), sensorDataProvider.readX(), sensorDataProvider.readY());
    speedometer.setCurrentValue(car.tripComputer.getCurrentSpeed()*3.6); // km/h
    tachometer.setCurrentValue((float)car.tripComputer.RPM/1000); // RPM x 1000
    fuelGauge.setCurrentValue(car.fuelTank.fuelLevel); // L
    gearIndicator.setCurrentValue(getGear(car.tripComputer.gearRatio));
    fuelConsumptionGraphArray = makeGraphArray(car.fuelComputer.fuelConsumptionHistory);
    averageFuelEconomyGraphArray = makeGraphArray(car.fuelComputer.averageFuelEconomyHistory);
    fuelEconomyHistoryGraphArray = makeGraphArray(car.fuelComputer.fuelEconomyHistory);
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    fuelGauge.display(1);
    gearIndicator.display(2);
    speedometer.display(3);
    tachometer.display(3);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(0.02*width);
    text("Trip: "+nf(car.tripComputer.totalTravelledDistance/1000, 1, 3)+" km", 0.25*width, 0.5*height+0.20*width);
    if(car.fuelComputer.range > 0) {
      text("Range: "+nf(car.fuelComputer.range, 1, 3)+" km", 0.75*width, 0.5*height+0.20*width);
    } else {
      text("Range: --- km", 0.75*width, 0.5*height+0.20*width);
    }
    textSize(0.015*width);
    if(car.fuelComputer.fuelConsumption > 0) {
      text("Fuel Consumption: "+nf(car.fuelComputer.fuelConsumption, 1, 3)+" L/100 km", 0.5*width, 0.5*height-0.075*width);
    } else {
      text("Fuel Comsumption: --- L/100km", 0.5*width, 0.5*height-0.075*width);
    }
    if(car.fuelComputer.fuelConsumption > 0) {
      text("Fuel Economy: "+nf(car.fuelComputer.fuelEconomy, 1, 3)+" km/L", 0.5*width, 0.5*height+0.045*width);
    } else {
      text("Fuel Economy: --- km/L", 0.5*width, 0.5*height+0.04*width);
    }
    
    textSize(0.01*width);
    text("Fuel Consumption (L) over time (s)", 0.5*width, 0.5*height+0.01*width);
    text("Average Fuel Economy (km/L) over time (s)", 0.5*width, 0.5*height+0.13*width);
    text("Fuel Economy History (km/L) over time (s)", 0.5*width, 0.5*height+0.21*width);
    
    textSize(0.008*width);
    
    if(fuelConsumptionGraphArray[0] != 0){
      BarChart fuelConsumptionGraph = new BarChart(this);
      fuelConsumptionGraph.setData(fuelConsumptionGraphArray);
      fuelConsumptionGraph.setMinValue(0);
      fuelConsumptionGraph.showValueAxis(true);
      fuelConsumptionGraph.setValueFormat("#");
      fuelConsumptionGraph.setBarColour(color(255));
      fuelConsumptionGraph.draw(0.42*width, 0.5*height-0.06*width, 0.16*width, 0.06*width);
    }
    
    if(averageFuelEconomyGraphArray[0] != 0){
      BarChart averageFuelEconomyGraph = new BarChart(this);
      averageFuelEconomyGraph.setData(averageFuelEconomyGraphArray);
      averageFuelEconomyGraph.setMinValue(0);
      averageFuelEconomyGraph.showValueAxis(true);
      averageFuelEconomyGraph.setValueFormat("#");
      averageFuelEconomyGraph.setBarColour(color(255));
      averageFuelEconomyGraph.draw(0.42*width, 0.5*height+0.06*width, 0.16*width, 0.06*width);
    }

    if(fuelEconomyHistoryGraphArray[0] != 0){
      BarChart fuelEconomyHistoryGraph = new BarChart(this);
      fuelEconomyHistoryGraph.setData(fuelEconomyHistoryGraphArray);
      fuelEconomyHistoryGraph.setMinValue(0);
      fuelEconomyHistoryGraph.showValueAxis(true);
      fuelEconomyHistoryGraph.setValueFormat("#");
      fuelEconomyHistoryGraph.setBarColour(color(255));
      fuelEconomyHistoryGraph.draw(0.42*width, 0.5*height+0.14*width, 0.16*width, 0.06*width);
    }
    
    if(car.location.previousX != 0 && car.location.previousY != 0){
      pushMatrix();
      translate(0.5*width, 0.5*height-0.17*width);
      rotate(car.location.getAngle()+0.5*PI);
      fill(50);
      ellipse(0, 0, 0.1*width, 0.1*width);
      fill(255, 59, 67);
      quad(0, width*0.04, -0.03*width, -0.03*width, 0, -0.015*width, 0.03*width, -0.03*width);
      popMatrix();
      fill(255);
      textSize(0.015*width);
      text(car.location.getDirection(), 0.5*width, 0.5*height-0.17*width);
    }
    
    textAlign(RIGHT, BOTTOM);
    textSize(0.03*width);
    fill(50);
    text(sensorDataProvider.vehicle + " simulation", 0.98*width, 0.98*height);
    
    sensorDataProvider.readNext();
  }
}

void keyPressed() {
  if(key == 49) {
    vehicleIndex = 0;
  } else if(key == 50) {
    vehicleIndex = 1;
  } else if(key == 51) {
    exit();
  }
}
    
void menu() {
  background(0);
  textAlign(RIGHT, BOTTOM);
  textSize(0.03*width);
  fill(50);
  text("v1.1", 0.98*width, 0.98*height);
  
  fill(255);
  textSize(0.07*width);
  textAlign(CENTER, CENTER);
  text("Digital Dashboard", 0.5*width, 0.5*height - 0.19*width);
  textSize(0.02*width);
  text("by Cheyenne Goh", 0.685*width, 0.5*height - 0.14*width);
  textSize(0.02*width);
  text("Press one of the following numbers to make a selection:", 0.5*width, 0.5*height - 0.04*width);

  fill(0, 218, 48); //green
  beginShape();
  vertex(0, 0.5*height);
  vertex(0.27*width, 0.5*height);
  vertex(0.37*width, 0.5*height+0.1*width);
  vertex(0.27*width, 0.5*height+0.2*width);
  vertex(0, 0.5*height+0.2*width);
  endShape(CLOSE);
  
  fill(255, 217, 0); //yellow
  beginShape();
  vertex(0.28*width, 0.5*height);
  vertex(0.61*width, 0.5*height);
  vertex(0.71*width, 0.5*height+0.1*width);
  vertex(0.61*width, 0.5*height+0.2*width);
  vertex(0.28*width, 0.5*height+0.2*width);
  vertex(0.38*width, 0.5*height+0.1*width);
  endShape(CLOSE);

  fill(255, 59, 67); //red
  beginShape();
  vertex(0.62*width, 0.5*height);
  vertex(width, 0.5*height);
  vertex(width, 0.5*height+0.2*width);
  vertex(0.62*width, 0.5*height+0.2*width);
  vertex(0.72*width, 0.5*height+0.1*width);
  endShape(CLOSE);
  
  textSize(0.25*width);
  fill(0);
  fill(0*0.75, 218*0.75, 48*0.75); //green
  text("1", 0.235*width,0.5*height+0.082*width);
  fill(255*0.75, 217*0.75, 0*0.75); //yellow
  text("2", 0.56*width,0.5*height+0.082*width);
  fill(255*0.75, 59*0.75, 67*0.75); //red
  text("3", 0.885*width,0.5*height+0.081*width);
  
  fill(255);
  textSize(0.04*width);
  text("Minicar\n(BMW 323i)", 0.175*width,0.5*height+0.086*width);
  text("Truck\n(Ford F150)", 0.5*width,0.5*height+0.086*width);
  text("Quit\nProgram", 0.825*width,0.5*height+0.086*width);
}

float[] makeGraphArray(float[] array) {
  if(array.length < 40) {
    float[] graphArray = new float[40];
    for(int i = 0; i < array.length; i++) {
      graphArray[i] = array[i];
    }
    return graphArray;
  } else if (array.length > 40) {
    return subset(array, array.length - 40, 40);
  } else {
    return array;
  }
}

int getGear(float gearRatio) {
  if(gearRatio <= 1) {
    return 4;
  } else if(gearRatio <= 2) {
    return 3;
  } else if(gearRatio <= 3) {
    return 2;
  } else {
    return 1;
  }
}
