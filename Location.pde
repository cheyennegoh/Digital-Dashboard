class Location {
  float x;
  float y;
  float previousX = 0;
  float previousY = 0;
  
  void setLocation(float valueX, float valueY){
    previousX = x;
    previousY = y;
    x = valueX;
    y = valueY;
  }
  
  float getAngle(){
    return atan2(y-previousY, x-previousX);
  }
  
  String getDirection(){
    if(getAngle() >= 0.875*PI || getAngle() <= -0.875*PI) {
      return "E";
    } else if(getAngle() <= -0.625*PI) {
      return "SE";
    } else if(getAngle() <= -0.375*PI) {
      return "S";
    } else if(getAngle() <= -0.125*PI) {
      return "SW";
    } else if(getAngle() <= 0.125*PI) {
      return "W";
    } else if(getAngle() <= 0.375*PI) {
      return "NW";
    } else if(getAngle() <= 0.625*PI) {
      return "N";
    } else {
      return "NE";
    }
  }
}
