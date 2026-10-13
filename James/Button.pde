class Button {
  // Member Variables
  float x, y, w, h, r;
  char val;
  boolean hover;
  color c1, c2;


  //Constructor
  Button(float x, float y, float w, float h, char val, float r) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.val = val;
    this.r = r;
    hover = false;
    c1 = color(#FF0307);
    c2 = color(#FAFF00);
  }

  // Member Method
  void display() {
    if (hover == true) {
      fill(c2);
    } else {
      fill(c1);
    }
    rectMode(CENTER);
    rect(x, y, w, h, r);
    fill(#050505);
    textSize(12);
    textAlign(CENTER);
    text(val, x, y);
  }

  void mouseOver(float tempX, float tempY) {
    if (tempX>x-w/2 && tempX < x+w/2 && tempY > y-h/2 && tempY < y+h/2) {
      hover = true;
    } else {
      hover = false;
    }
  }
}
