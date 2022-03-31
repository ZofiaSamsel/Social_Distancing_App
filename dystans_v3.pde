import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import controlP5.*;
import jp.nyatla.nyar4psg.*; // import biblioteki nyar4psg, umożliwia odczyt znaczników

MultiMarker nya; // obiekt klasy znaczników
 
ControlP5 cp5; 
Capture video;
OpenCV opencv;

PImage start_screen, virus_screen;

boolean friend = false;
// List of my Face objects (persistent)
ArrayList<Face> faceList;
 
// List of detected faces (every frame)
Rectangle[] faces;
 
// Number of faces detected over all time. Used to set IDs.
int faceCount = 0;

// width and height of button
int bX,bY;

// position of a button
int pX1,pY1,pX2,pY2,pX3,pY3,pX4,pY4;

boolean button1 = false;

boolean button2 = false;
boolean button3 = false;
boolean button4 = false;

void setup() {
  size(640, 480, P3D);
  background(color(211,211,211));
  
  start_screen = loadImage("data/ekran_start.jpg");
  virus_screen = loadImage("data/ekran_loneliness.jpg");
  
  video = new Capture(this, width, height, "pipeline: autovideosrc");
  opencv = new OpenCV(this, width, height);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  nya=new MultiMarker(this, width, height,"data/camera_para.dat",NyAR4PsgConfig.CONFIG_PSG); //przypisanie pliku konfiguracyjnego nyar4psg
  nya.addARMarker("data/47.patt",80); //wybór znacznika (47) i określenie rozdzielczości
    
 
  faceList = new ArrayList<Face>();
  
  //width and height of a button
  bX = 150;
  bY = 40;
  
  //position of the button1
  pX1 = 150;
  pY1 = height-40;
  
  //position of the button2
  pX2 = 0;
  pY2 = height-40;
  
//button3
  pX3 = 300;
  pY3 = height-40;
  pX4 = 450;
  pY4 = height-40;
  
  cp5 = new ControlP5(this);
  cp5.addButton("Button1")
    .setPosition(pX1, pY1)
    .setSize(bX, bY)
    .setColorActive(color(255,255,255))
    .setColorBackground(color(255,120,120))//Color del botón el sin puntero del ratón encima
    .setColorForeground(color(255,80,80)) //Color del botón con puntero del ratón encima
    .getCaptionLabel()            //Las líneas desde .getCaptionLabel() deben ir
    .setFont(createFont("",20))  //seguidas y se aplican a la fuente del botón
    .toUpperCase(false)          //Evita que el texto quede todo en mayúscula
    .setText("Start/Stop")            //Texto del botón 
    .setColor(color(0,0,255));
   
  cp5.addButton("Button2")
    .setPosition(pX2, pY2)
    .setSize(bX, bY)
    .setColorActive(color(255,255,255))
    .setColorBackground(color(255,120,120))//Color del botón el sin puntero del ratón encima
    .setColorForeground(color(255,80,80)) //Color del botón con puntero del ratón encima
    .getCaptionLabel()            //Las líneas desde .getCaptionLabel() deben ir
    .setFont(createFont("",20))  //seguidas y se aplican a la fuente del botón
    .toUpperCase(false)          //Evita que el texto quede todo en mayúscula
    .setText("Add exepction")            //Texto del botón 
    .setColor(color(0,0,255));
    ;
      cp5.addButton("Button3")
    .setPosition(pX3, pY3)
    .setSize(bX, bY)
    .setColorActive(color(255,255,255))
    .setColorBackground(color(255,120,120))//Color del botón el sin puntero del ratón encima
    .setColorForeground(color(255,80,80)) //Color del botón con puntero del ratón encima
    .getCaptionLabel()            //Las líneas desde .getCaptionLabel() deben ir
    .setFont(createFont("",20))  //seguidas y se aplican a la fuente del botón
    .toUpperCase(false)          //Evita que el texto quede todo en mayúscula
    .setText("Stop Friend")            //Texto del botón 
    .setColor(color(0,0,255));
    
      cp5.addButton("Button4")
    .setPosition(pX4, pY4)
    .setSize(bX, bY)
    .setColorActive(color(255,255,255))
    .setColorBackground(color(255,120,120))//Color del botón el sin puntero del ratón encima
    .setColorForeground(color(255,80,80)) //Color del botón con puntero del ratón encima
    .getCaptionLabel()            //Las líneas desde .getCaptionLabel() deben ir
    .setFont(createFont("",20))  //seguidas y se aplican a la fuente del botón
    .toUpperCase(false)          //Evita que el texto quede todo en mayúscula
    .setText("Markers")            //Texto del botón 
    .setColor(color(0,0,255));
  video.start();
}
 
void draw() {
  start_screen();
  
  if(button1) {
    
    image(virus_screen, 0, 0);
    //scale(scl);
    image(video, 0,0);
        
    opencv.loadImage(video);
    detectFaces();
    println(friend);
    // Draw all the faces
    for (int i = 0; i < faces.length; i++) {
      stroke(255,222,0);
      rect(faces[i].x, faces[i].y- faces[i].height-10, faces[i].width, faces[i].height);
      println(faceList);

      println(faces[i].width);
    if (faces[i].width > 90) {
      //przycisk kliknięty
      if (friend == true) {
        stroke(0,0,222);
        //rect(faces[i].x, faces[i].y- faces[i].height-10, faces[i].width, faces[i].height);
      }
      else {stroke(255,0,0);
      //rect(faces[i].x, faces[i].y- faces[i].height-10, faces[i].width, faces[i].height);
      }
      rect(faces[i].x, faces[i].y- faces[i].height-10, faces[i].width, faces[i].height);
      println(friend);
    }}  
  
 
  for (Face f : faceList) {
    strokeWeight(2);
    f.display();
    
    }
  }
  
  if(button2) {
    
    //if (friend == true) {
      friend = true;
    }

  
  if(button3) {
    //if (friend == false) {
      friend = false;
  }
  
  if (button4) {
    marker();
    image(virus_screen, 0, 0);
    image(video, 0,0);
    
    if (video.available() !=true) {  
      return; // instrukcja warunkowa zwracająca obraz z kamery
    }
    //marker();
  }
//przeskalowanie kamery, marker, przyciski na waczanie przyjaciol i wylacanie przyjaciol 
 
  }
  
   
void marker() {
    video.read(); // funkcja zczytywania aktualnej klatki
    nya.detect(video);  // funkcja wykrywania znaczników w aktualnej klatce
    nya.drawBackground(video); // funkcja tła przy wyświetlaniu znacznika
    if((!nya.isExist(0))){ 
      println("tak");
      return; //instrukcja warunkowa sprawdzająca czy widoczny jest znacznik 47
    }
    nya.beginTransform(0);  //rozpoczęcie funkcji transformacji obiektu w miejsce znacznika
    stroke(0,0,100);  // funkcja koloru zewnętrznej ramki (krawędzi)
    fill(255,200,0, 40); // funkcja koloru wypełnienia zewnętrznej ramki
    rect(-40,-40,80,80); // funkcja tworząca prostokąt: koordynaty zewnętrznej ramki
    fill(0,0,255,10); // funkcja koloru wypełnienia kostki
    stroke(255,0,255); // funkcja koloru krawędzi kostki
    strokeWeight(4); // funkcja grubości krawędzi
    translate(0,0,20); //funkcja dopasowania obiektu do aktualnego okna
    box(40); // funkcja tworząca kostkę 
    println("tu");
    nya.endTransform(); // zakończenie funkcji transformacji
    //delay(500);
}



void detectFaces() {
 
  // Faces detected in this frame
  faces = opencv.detect();
 
  // Check if the detected faces already exist are new or some has disappeared.
 
  // SCENARIO 1
  // faceList is empty
  if (faceList.isEmpty()) {
    // Just make a Face object for every face Rectangle
    for (int i = 0; i < faces.length; i++) {
      println("+++ New face detected with ID: " + faceCount);
      faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height, faces[i].width * 2));
      faceCount++;
    }
   
 
  // SCENARIO 2
  // We have fewer Face objects than face Rectangles found from OPENCV
  } else if (faceList.size() <= faces.length) {
    boolean[] used = new boolean[faces.length];
    // Match existing Face objects with a Rectangle
    for (Face f : faceList) {
       // Find faces[index] that is closest to face f
       // set used[index] to true so that it can't be used twice
       float record = 50000;
       int index = -1;
       for (int i = 0; i < faces.length; i++) {
         float d = dist(faces[i].x,faces[i].y,f.r.x,f.r.y);
         if (d < record && !used[i]) {
           record = d;
           index = i;
         }
       }
       // Update Face object location
       used[index] = true;
       f.update(faces[index]);
    }
    // Add any unused faces
    for (int i = 0; i < faces.length; i++) {
      if (!used[i]) {
        println("+++ New face detected with ID: " + faceCount);
        faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height, faces[i].width * 2));
        faceCount++;
      }
    }
 
  // SCENARIO 3
  // We have more Face objects than face Rectangles found
  } else {
    // All Face objects start out as available
    for (Face f : faceList) {
      f.available = true;
    }
    // Match Rectangle with a Face object
    for (int i = 0; i < faces.length; i++) {
      // Find face object closest to faces[i] Rectangle
      // set available to false
       float record = 50000;
       int index = -1;
       for (int j = 0; j < faceList.size(); j++) {
         Face f = faceList.get(j);
         float d = dist(faces[i].x,faces[i].y,f.r.x,f.r.y);
         if (d < record && f.available) {
           record = d;
           index = j;
         }
       }
       // Update Face object location
       Face f = faceList.get(index);
       f.available = false;
       f.update(faces[i]);
    }
    // Start to kill any left over Face objects
    for (Face f : faceList) {
      if (f.available) {
        f.countDown();
        if (f.dead()) {
          f.delete = true;
        }
      }
    }
  }
 
  // Delete any that should be deleted
  for (int i = faceList.size()-1; i >= 0; i--) {
    Face f = faceList.get(i);
    if (f.delete) {
      faceList.remove(i);
    }
  }
}
 
void captureEvent(Capture c) {
  c.read();
}

void start_screen(){
  image(start_screen,0,0);
}

void mousePressed(){
  if(mouseX > pX1 && mouseX < pX1+bX && mouseY > pY1 && mouseY < pY1+bY) {
    button1 = !button1;
  }
  if(mouseX > pX2 && mouseX < pX2+bX && mouseY > pY2 && mouseY < pY2+bY) {
    button2 = !button2;
  }
  if(mouseX > pX3 && mouseX < pX3+bX && mouseY > pY3 && mouseY < pY3+bY) {
    button3 = !button3;
    }
  if(mouseX > pX4 && mouseX < pX4+bX && mouseY > pY4 && mouseY < pY4+bY) {
    button4 = !button4;
  }
}
