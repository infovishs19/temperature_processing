import codeanticode.syphon.*;
import oscP5.*;
import netP5.*;

Table data;
float minTemp = 0;
float maxTemp = 0;

int currentIndex = 0;

// communication with touch tracker and video mapper 
String sketchName = "temperature";
OscP5 oscP5;
final int videoMapperPort = 8400;
final int trackerMasterPort = 64000;
final int trackerReceivePort = 12000;
NetAddress videoMapperAddress;
NetAddress trackerMasterAddress;

//graphics 
SyphonServer syphonServer;
PGraphics canvas;
PGraphics attLayer;
int canvasW = 4*1920;
int canvasH = 1080;




void settings() 
{
  size(2560, 360, P3D);
  PJOGL.profile=1;
}

void setup () {

  frameRate(10);
  canvas = createGraphics(canvasW, canvasH, P3D);
 // setupTracking();
  setupVideoMapping();  
  
  data = loadTable("temperatur_ch.csv", "header");

  minTemp = min(data,"jan");
  maxTemp = max(data,"jan");
  println("minTemp: " + minTemp);
  println("maxTemp: " + maxTemp);

  
}

void draw () {

  canvas.beginDraw();
  canvas.background(200);

  currentIndex = constrain(currentIndex + 1, 0, data.getRowCount());
  println(currentIndex);

  float w = canvas.width / data.getRowCount();
  float x = 0;

  
  canvas.colorMode(RGB); 

  //colors cannot be used like this '#FFC200';
  color from = color(255, 194, 0);
  color middle = color(255, 255, 0);
  color to = color(255, 75, 0);

  for (int i = 0; i < currentIndex; i++) {
    float d = data.getInt(i,"jan");
    x = i * w;
    float amt = map(d, minTemp, maxTemp, 0, 1);
    canvas.colorMode(RGB);
    color col = lerpColor(from, to, amt);
    canvas.fill(col);
    canvas.noStroke();
    canvas.rect(x, 0, w, canvas.height);
  }
  
  canvas.endDraw();
  syphonServer.sendImage(canvas);
  
  image(canvas, 0, 0, width, height);

}
