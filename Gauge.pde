/*
  •  A Gauge module that can be re-used to display different numbers on the dashboard.
  
        o  Gauge needs to display current value, unit of the parameter as well as the minimum
           and maximum of the possible value. 
           
        o  Gauge should display the values in the first and last 15% of the range differently. For
           example, you can use different colors for this purpose.
*/

class Gauge {
  float minimum;
  float maximum;
  float currentValue;
  String unit;
  
  float positionX;
  float positionY;
  float size;
  
  void setCurrentValue(float value) {
    if(value >= minimum && value <= maximum) {
      currentValue = value;
    }
  }
  
  void display(int gaugeType) {
    if(gaugeType == 1) { // fuel gauge
      fill(50);
      arc(positionX, positionY, 0.45*width, 0.45*width, 1.75*PI, 2.25*PI);
      if (currentValue < 0.15*maximum) {
        fill(255, 59, 67); //red
      } else if (currentValue > 0.85*maximum) {
        fill(0, 218, 48); //green
      } else {
        fill(255, 217, 0); //yellow
      }
      arc(positionX, positionY, 0.45*width, 0.45*width, 2.25*PI-(currentValue/maximum)*0.5*PI, 2.25*PI); //Fuel gauge
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(size);
      text("Fuel: "+nf(currentValue, 1, 1)+" "+unit, 0.90*width, 0.5*height-0.15*width);
    } else if(gaugeType == 2) {
      fill(50);
      arc(positionX, positionY, 0.45*width, 0.45*width, 0.75*PI, 1.25*PI);
      if (currentValue == 1) {
        fill(0, 218, 48); //green
      } else if (currentValue == 2) {
        fill(255, 217, 0); //yellow
      } else if (currentValue == 3) {
        fill(255, 156, 0); //orange
      } else {
        fill(255, 59, 67); //red
      }
      arc(positionX, positionY, 0.45*width, 0.45*width, 0.75*PI, 0.75*PI+(currentValue/maximum)*0.5*PI); //Gear indicator
      fill(0);
      for(int i = 1; i < maximum; i++){
        arc(positionX, positionY, 0.45*width, 0.45*width, 0.75*PI+(i/maximum)*0.5*PI-0.000008*width, 0.75*PI+(i/maximum)*0.5*PI+0.000008*width);
      }
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(size);
      text("Gear: "+(int)currentValue, 0.10*width, 0.5*height-0.15*width);
    } else if(gaugeType == 3) { // speed/RPM gauge
      fill(0);
      ellipse(positionX, positionY, 0.40*width, 0.40*width);
      fill(50);
      arc(positionX, positionY, 0.30*width, 0.30*width, 0.75*PI, 2.25*PI);
      if (currentValue < 0.15*maximum) {
        fill(255, 217, 0); //yellow
      } else if (currentValue > 0.85*maximum) {
        fill(255, 59, 67); //red
      } else {
        fill(255, 156, 0); //orange
      }
      arc(positionX, positionY, 0.30*width, 0.30*width, 0.75*PI, 0.75*PI+(currentValue/maximum)*1.5*PI); //RPM gauge
      fill(0);
      ellipse(positionX, positionY, 0.28*width, 0.28*width);
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(size);
      text(nf(currentValue, 1, 1), positionX, positionY-0.03*width);
      textSize(0.03*width);
      text(unit, positionX, positionY+0.03*width);
    }
  }
}
