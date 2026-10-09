// James Jia | 15 Sept 2026 | Calculator

Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];
float l, r, result;
char op;
boolean left;
boolean newEntry;
String displayVal;

void setup() {
  size(130, 230);
  l = 0.0;
  r = 0.0;
  result = 0.0;
  op = ' ';
  left = true;
  newEntry = true;
  displayVal = "0.0";

  // Number buttons
  numButtons[0] = new Button(20, 150, 25, 25, '0', 10);
  numButtons[1] = new Button(50, 90, 25, 25, '9', 10);
  numButtons[2] = new Button(20, 90, 25, 25, '8', 10);
  numButtons[3] = new Button(110, 120, 25, 25, '7', 10);
  numButtons[4] = new Button(80, 120, 25, 25, '6', 10);
  numButtons[5] = new Button(50, 120, 25, 25, '5', 10);
  numButtons[6] = new Button(20, 120, 25, 25, '4', 10);
  numButtons[7] = new Button(110, 150, 25, 25, '3', 10);
  numButtons[8] = new Button(80, 150, 25, 25, '2', 10);
  numButtons[9] = new Button(50, 150, 25, 25, '1', 10);

  // Operator buttons
  opButtons[0] = new Button(110, 60, 25, 25, 'c', 10);
  opButtons[1] = new Button(20, 60, 25, 25, '+', 10);
  opButtons[2] = new Button(80, 90, 25, 25, '-', 10);
  opButtons[3] = new Button(50, 60, 25, 25, '×', 10);
  opButtons[4] = new Button(80, 60, 25, 25, '÷', 10);
  opButtons[5] = new Button(110, 90, 25, 25, '±', 10);
  opButtons[6] = new Button(80, 210, 25, 25, '.', 10);
  opButtons[7] = new Button(110, 195, 25, 56, '=', 10);
  opButtons[8] = new Button(35, 210, 56, 25, '√', 10);
  opButtons[9] = new Button(20, 180, 25, 25, 'S', 10);
  opButtons[10] = new Button(80, 180, 25, 25, 'C', 10);
  opButtons[11] = new Button(50, 180, 25, 25, 'T', 10);
}

void draw() {
  background(#1400FF);
  drawDisplay();
  for (int i = 0; i<numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].mouseOver(mouseX, mouseY);
  }

  for (int i = 0; i<opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].mouseOver(mouseX, mouseY);
  }
}

void drawDisplay() {
  rectMode(CENTER);
  fill(#E7FC00);
  rect(width/2, 24, 115, 30, 10);
  fill(0);
  textSize(16);
  textAlign(RIGHT, CENTER);
  text(displayVal, width-20, 25);
}

void mouseReleased() {
  // Number Buttons
  for (int i = 0; i < numButtons.length; i++) {
    if (numButtons[i].hover) {
      handleEvent(numButtons[i].val,true);
    }
  }

  // Operator Buttons
  for (int i = 0; i < opButtons.length; i++) {
    if (opButtons[i].hover) {
      handleEvent(opButtons[i].val, false);
    }
  }


  printState();
}

void printState() {
  println("L:" + l);
  println("R:" + r);
  println("Result:" + result);
  println("Left:" + left);
  println("Op:" + op);
  println("----------------");
}

void performCalc() {
  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == '÷') {
    if (r != 0) {
      result = l / r;
    } else {
      displayVal = "Error";
      return;
    }
  } else if (op == '×') {
    result = l * r;
  }

  displayVal = str(result);
  l = result;
  newEntry = true;
}

void keyPressed() {
  println("keyCode: " + keyCode);
  if (keyCode == 49 || keyCode == 97) {
    handleEvent('1', true);
  } else if (keyCode == 50 || keyCode == 98) {
    handleEvent('2', true);
  } else if (keyCode == 51 || keyCode == 99) {
    handleEvent('3', true);
  } else if (keyCode == 52 || keyCode == 100) {
    handleEvent('4', true);
  } else if (keyCode == 53 || keyCode == 101) {
    handleEvent('5', true);
  } else if (keyCode == 54 || keyCode == 102) {
    handleEvent('6', true);
  } else if (keyCode == 55 || keyCode == 103) {
    handleEvent('7', true);
  } else if (keyCode == 56 || keyCode == 104) {
    handleEvent('8', true);
  } else if (keyCode == 57 || keyCode == 105) {
    handleEvent('9', true);
  } else if (keyCode == 48 || keyCode == 96) {
    handleEvent('0', true);
  } 
  
  // Operators (+, -, ×, ÷)
  else if (keyCode == 45 || keyCode == 109 || key == '-') {
    handleEvent('-', false);
  } else if (keyCode == 107 || key == '+') {
    handleEvent('+', false);
  } else if (keyCode == 106 || key == '*' || key == 'x') {
    handleEvent('×', false);
  } else if (keyCode == 111 || key == '/') {
    handleEvent('÷', false);
  } else if (key == '=' || keyCode == ENTER || keyCode == RETURN) {
    handleEvent('=', false);
  }
}

void handleEvent(char val, boolean isNum) {
  if (isNum == true) {
    // do num stuff
    String digit = str(val);

    if (newEntry || displayVal.equals("0.0")) {
      displayVal = digit;
      newEntry = false;
    } else {
      displayVal += digit;
    }

    if (left) {
      l = float(displayVal);
    } else {
      r = float(displayVal);
    }
  } else {
    // do op stuff
    char clicked = val;

      if (clicked == '=') {
        performCalc();
      } else if (clicked == '+' || clicked == '-' || clicked == '×' || clicked == '÷') {
        op = clicked;
        left = false;
        newEntry = true;
        displayVal = str(op);
      } else if (clicked == '.') {
        if (!displayVal.contains(".")) {
          displayVal += ".";
        }
      } else if (clicked == '±') {
        if (left) {
          l *= -1;
          displayVal = str(l);
        } else {
          r *= -1;
          displayVal = str(r);
        }
      } else if (clicked == 'S') { // Sin
        float currentVal = float(displayVal);
        result = sin(radians(currentVal));
        displayVal = str(result);
        if (left) l = result;
        else r = result;
        newEntry = true;
      } else if (clicked == 'C') { // Cos
        float currentVal = float(displayVal);
        result = cos(radians(currentVal));
        displayVal = str(result);
        if (left) l = result;
        else r = result;
        newEntry = true;
      } else if (clicked == 'T') { // Tan
        float currentVal = float(displayVal);
        result = tan(radians(currentVal));
        displayVal = str(result);
        if (left) l = result;
        else r = result;
        newEntry = true;
      } else if (clicked == '√') { // Square Root
        float currentVal = float(displayVal);
        if (currentVal >= 0) {
          result = sqrt(currentVal);
          displayVal = str(result);
          if (left) l = result;
          else r = result;
        } else {
          displayVal = "Error";
        }
        newEntry = true;
      } else if (clicked == 'c') {
        // Reset all variables
        l = 0.0;
        r = 0.0;
        result = 0.0;
        op = ' ';
        left = true;
        newEntry = true;
        displayVal = "0.0";
      }
  }
}
