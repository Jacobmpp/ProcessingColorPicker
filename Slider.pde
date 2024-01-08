class Slider {
  public int value;
  public int max;
  public PVector pos;
  public PVector size;
  
  public Slider (int x, int y, int w, int h, int defVal, int _max){
    pos = new PVector(x, y);
    size = new PVector(w, h);
    value = defVal;
    max = _max;
  }
  
  public void show(int index, int val1, int val2){
    strokeWeight(3);
    stroke(color((brightness(getColor(lerp(0, max, (float)value/max), index, val1, val2))<50)?100:0));
    fill(getColor(0, index, val1, val2));
    ellipse(pos.x, pos.y+size.y/2, size.y, size.y);
    fill(getColor(max, index, val1, val2));
    ellipse(pos.x+size.x, pos.y+size.y/2, size.y, size.y);
    
    strokeWeight(size.x/255+1);
    for(int i = 0; i < 255; i++){
      stroke(getColor(lerp(0, max, (float)i/255), index, val1, val2));
      line(pos.x+(float)size.x/255*i+(float)size.x/510, pos.y+3, pos.x+(float)size.x/255*i+(float)size.x/510, pos.y+size.y-3);
    }
    
    strokeWeight(3);
    stroke(color((brightness(getColor(lerp(0, max, (float)value/max), index, val1, val2))<50)?100:0));
    line(pos.x, pos.y, pos.x+size.x, pos.y);
    line(pos.x, pos.y+size.y, pos.x+size.x, pos.y+size.y);
    
    stroke(color((brightness(getColor(lerp(0, max, (float)value/max), index, val1, val2))<200)?255:0));
    fill(color(0,0,0,1));
    ellipse(pos.x+(int)((float)value/max*size.x), pos.y+size.y/2, size.y-6, size.y-6);
  }
  
  private color getColor(float i, int index, int val1, int val2){
    switch(index){
      case 0:
        return color(i, val1, val2);
      case 1:
        return color(val1, i, val2);
      default:
        return color(val1, val2, i);
    }
  }
  
  public void update(){
    float rS = size.y/2;
    rS *= rS;
    PVector sel = new PVector(pos.x+(int)((float)value/max*size.x), pos.y+size.y/2);
    float distS = (mouseY-sel.y)*(mouseY-sel.y);
    if(distS<=rS){
      value = (int)((float)(mouseX-pos.x)/size.x*max);
    }
    value = constrain(value, 0, max);
  }
  
}
