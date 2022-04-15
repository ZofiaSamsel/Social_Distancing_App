import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import controlP5.*;
import jp.nyatla.nyar4psg.*; 

MultiMarker nya;
ControlP5 cp5; 
Capture video;
OpenCV opencv;


PImage start_screen, virus_screen, biohazard;
float a = PI/8;

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
  //frameRate(30); kod czasem sie nie włącza przez to
  size(640, 480, P3D);
  background(color(211,211,211));
  
  biohazard = loadImage("data/biohazard.jpg");
  start_screen = loadImage("data/ekran_start.jpg");
  virus_screen = loadImage("data/ekran_loneliness.jpg");
  
  video = new Capture(this, width, height, "pipeline: autovideosrc");
  opencv = new OpenCV(this, width, height);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  nya = new MultiMarker(this, width, height,"data/camera_para.dat",NyAR4PsgConfig.CONFIG_PSG); //assigning the nyar4psg configuration file
  nya.addARMarker("data/47.patt",80); //select tag (47) and specify resolution
    
 
  faceList = new ArrayList<Face>();
  
  //width and height of a button
  bX = width/5;
  bY = height/15;
  
  //position of the button1
  pX1 = width/2 - bX/2;
  pY1 = height-bY;
  
  //position of the button2
  pX2 = width/2 - bX- bX;
  pY2 = height-bY;
  
//button3
  pX3 = width/2 +bX ;
  pY3 = height-bY;
  
//button4
  pX4 = width/2 - 2*bX ;
  pY4 = height-2*bY;

  
  cp5 = new ControlP5(this);
  cp5.addButton("Button1")
    .setPosition(pX1, pY1)
    .setSize(bX, bY)
    .setColorActive(color(255,255,255))
    .setColorBackground(color(255,120,120))//Color of the button the without mouse pointer on it
    .setColorForeground(color(255,80,80)) //Color of the button with mouse pointer over it
    .getCaptionLabel()            //The lines from .getCaptionLabel() should go to
    .setFont(createFont("",20))  //followed and applied to the button source
    .toUpperCase(false)          //Avoid all capital letters in the text
    .setText("Start/Stop")            //Button text 
    .setColor(color(0,0,255));
   
  cp5.addButton("Button2")
    .setPosition(pX2, pY2)
    .setSize(bX, bY)
    .setColorActive(color(255,255,255))
    .setColorBackground(color(255,120,120))//Color of the button the without mouse pointer on it
    .setColorForeground(color(255,80,80)) //Color of the button with mouse pointer over it
    .getCaptionLabel()            //The lines from .getCaptionLabel() should go to
    .setFont(createFont("",20))  //followed and applied to the button source
    .toUpperCase(false)           //Avoid all capital letters in the text
    .setText("Add exepction")            //Button text 
    .setColor(color(0,0,255));
    ;
      cp5.addButton("Button3")
    .setPosition(pX3, pY3)
    .setSize(bX, bY)
    .setColorActive(color(255,255,255))
    .setColorBackground(color(255,120,120))//Color of the button the without mouse pointer on it
    .setColorForeground(color(255,80,80)) //Color of the button with mouse pointer over it
    .getCaptionLabel()            //The lines from .getCaptionLabel() should go to
    .setFont(createFont("",20))  //followed and applied to the button source
    .toUpperCase(false)           //Avoid all capital letters in the text
    .setText("Marker")            //Button text
    .setColor(color(0,0,255));
      
      cp5.addButton("Button4")
    .setPosition(pX4, pY4)
    .setSize(bX, bY)
    .setColorActive(color(255,255,255))
    .setColorBackground(color(255,120,120))//Color of the button the without mouse pointer on it
    .setColorForeground(color(255,80,80)) //Color of the button with mouse pointer over it
    .getCaptionLabel()            //The lines from .getCaptionLabel() should go to
    .setFont(createFont("",20))  //followed and applied to the button source
    .toUpperCase(false)           //Avoid all capital letters in the text
    .setText("Distance")            //Button text
    .setColor(color(0,0,255));

  video.start();
}
 // main draw void which display and draw elements
void draw() {
  start_screen();
  
  if(button1) {
    
    image(virus_screen, 0, 0);
    image(video, 0,0);
        
    opencv.loadImage(video);
    //faces detection
    detectFaces();
    
    
    // Draw all the faces
    for (int i = 0; i < faces.length; i++) {

    if (a == 2*PI) {
      a = 0;}
      //check the size of the face square, if it is too big mark it red
      if (faces[i].width > 90) {
        //red   
        stroke(255,0,0);
         fill(255,0,0);
         strokeWeight(3);}
  
      else{
        //blue
        stroke(0,255,255);
        noFill();
        strokeWeight(3);  
      }
   if (button2 == true && faces[i].width > 90) {
     noFill(); 
     stroke(0,0,222);
      }
          //drawing an overhead object
    lights();
    pushMatrix();
    translate(faces[i].x + ( faces[i].width / 2) , faces[i].y - 80., 0);    
    rotateY(a);
    a+=0.05;
    box(50);
    popMatrix();

}
  //distance between two faces in front of the camera
     if (faces.length > 1 && button4) {
       if (faces[1].x < faces[0].x) {
       int widthfacesL = int(faces[0].x) - int(faces[1].x) - faces[1].width;
       //comment to report: average face width is about 15cm; distance divided by face width is x/15 
       // if x/15 <10 then the distance between people is less than 150cm; however, this is difficult to do in the screen frame, so I reduced it to less than 75cm (widthfacesL/faces[0].width) < 5 // jezeli x/15 <10 to dystans miedzy osobami mniejszy niż 150cm; jest to jednak trudne do zrobiena w kadrze ekranu, wiec zmniejszyłam do mniej niż 75 cm (widthfacesL/faces[0].width) < 5
        if ((widthfacesL/faces[0].width) < 5 && widthfacesL > 0) {
          //text drawing 
          textSize(widthfacesL/4);
          fill(255,0,0);
          text("WARNING",faces[1].x+faces[1].width, faces[1].y + faces[1].height/2);
       }
     }
       if (faces[0].x < faces[1].x) {
       int widthfaces = int(faces[1].x) - int(faces[0].x) - faces[0].width;
       if ((widthfaces/faces[0].width) < 5 && widthfaces > 0) {
         //text drawing
          textSize(widthfaces/4);
          fill(255,0,0);
          text("WARNING", faces[0].x+faces[0].width, faces[1].y + faces[1].height/2);
     }
   }
   }
  }
 

  if (button3) {
    marker();
    image(virus_screen, 0, 0);
    image(video, 0,0);
    
    if (video.available() !=true) {  
        return; // conditional instruction returning a camera image
    }
  }
//camera scaling, marker, buttons for including friends and deactivating friends 
 
  }
  
   
void marker() {
    video.read(); // current frame readout function
    nya.detect(video);  // Marker detection function in the current frame
    nya.drawBackground(video); // background function when displaying a tag
    if((!nya.isExist(0))){ 
      return; //conditional statement checking if marker is visible 47
    }
    nya.beginTransform(0);  //start the function of transforming an object in place of a marker
       translate(-biohazard.width/2,-biohazard.height/2,0);
       biohazard();
       { translate(biohazard.width/2,biohazard.height/2,-20);
       // biohazard drawing
         box(biohazard.width,biohazard.height,20);
         stroke(255,204,0);
         fill(255,0,0);

       }
    nya.endTransform(); // termination of the transformation function

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
      //println("+++ New face detected with ID: " + faceCount);
      faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height, faces[i].width * 2));
      faceCount++;
    }
   
 
  // SCENARIO 2
  // We have fewer Face objects than face Rectangles found from OPENCV
  } 
  else if (faceList.size() <= faces.length) {
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
        //println("+++ New face detected with ID: " + faceCount);
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

//photo loading
void start_screen(){
  image(start_screen,0,0);
}

//photo loading
void biohazard(){
  image(biohazard,0,0);
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
