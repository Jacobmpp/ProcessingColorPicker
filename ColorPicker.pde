Slider hue;
Slider sat;
Slider val;
color col;
int mode = HSB;

void setup() {
  size(500, 540);
  //fullScreen();
  
  ellipseMode(CENTER);
  rectMode(CORNER);
  textMode(CENTER);
  colorMode(HSB);
  
  hue = new Slider(height/8, height/40*13, width-height/4, height/5, 0, 255);
  sat = new Slider(height/8, height/40*22, width-height/4, height/5, 127, 255);
  val = new Slider(height/8, height/40*31, width-height/4, height/5, 127, 255);
}

void mousePressed(){
  if(mouseY <= height/7){
    switch(mode){
      case HSB:
        mode = RGB;
        hue.value = (int)red(col);
        sat.value = (int)green(col);
        val.value = (int)blue(col);
        colorMode(RGB);
        break;
      default:
        mode = HSB;
        hue.value = (int)hue(col);
        sat.value = (int)saturation(col);
        val.value = (int)brightness(col);
        colorMode(HSB);
    }
  }
}

void draw() {
  if(mousePressed){
    hue.update();
    sat.update();
    val.update();
  }
  col = color(hue.value, sat.value, val.value);
  background(col);
  colorMode(RGB);
  fill(color((brightness(col)>127)?0:255));
  colorMode(mode);
  float h = height/7;
  textSize(h);
  text(mode==RGB?"RGB":"HSB", width/2-h, h);
  if(mode == RGB)
    text("0x"+hex(col).substring(2), width/2-h*2, h*2);
  else {
    PVector HSV = new PVector(hue(col), saturation(col), brightness(col));
    colorMode(RGB);
    text("0x"+hex(color(HSV.x, HSV.y, HSV.z)).substring(2), width/2-h*2, h*2);
    colorMode(HSB);
  }
  hue.show(0, sat.value, val.value);
  sat.show(1, hue.value, val.value);
  val.show(2, hue.value, sat.value);
}
