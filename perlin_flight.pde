int cols, rows;
int scl = 5;

float zScale = 50;
float heightMax = 100;

float yoff;
float xoff;

float[][] terrain;

boolean forward = false;
boolean backward = false;
boolean left = false;
boolean right = false;
boolean up = false;
boolean down = false;

void setup() {
  size(1000, 1000, P3D);
  
  cols = width / scl;
  rows = height / scl;
  
  terrain = new float[cols][rows];
}

void keyPressed()
{
  if (key == 'w') forward = true;
  if (key == 's') backward = true;
  if (key == 'a') left = true;
  if (key == 'd') right = true;
  if (key == ' ') up = true;
  if (key == TAB) down = true;
}

void keyReleased()
{
  if (key == 'w') forward = false;
  if (key == 's') backward = false;
  if (key == 'a') left = false;
  if (key == 'd') right = false;
  if (key == ' ') up = false;
  if (keyCode == TAB) down = false;
}

void draw()
{
  background(0);
  fill(255);
  textSize(32);
  text("height scale: " + heightMax, 50, 50);
  text("location: x: " + xoff, 50, 100);
  text(" y: " + -yoff, 500, 100);
  if (!(forward && backward))
  {
    if (forward) yoff -= 0.05;
    if (backward) yoff += 0.05;
  }
  
  if (!(left && right))
  {
    if (left) xoff -= 0.05;
    if (right) xoff += 0.05;
  }
  
  if (!(up && down))
  {
    if (up) heightMax++;
    if (down) heightMax--;
  }
  
  for (int y = 0; y < rows; y++)
  {
    for (int x = 0; x < cols; x++)
    {
      terrain[x][y] = map(noise(((float)x / zScale) + xoff, ((float)y / zScale) + yoff), 0, 1, -heightMax, heightMax);
    }
  }
  
  fill(128, 0, 255);
  
  translate(width / 2, height / 2);
  rotateX(PI/3);
  translate(-width / 2, -height / 2);
  
  colorMode(RGB);
  lights();
  noStroke();
  
  for (int y = 0; y < rows - 1; y++)
  {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++)
    {
      vertex(x * scl, y * scl, terrain[x][y]);
      vertex(x * scl, (y + 1) * scl, terrain[x][y + 1]);
    }
    endShape();
  }
}
