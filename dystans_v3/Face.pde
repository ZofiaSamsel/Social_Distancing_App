class Face {
 
  // A Rectangle
  Rectangle r;
 
  // Am I available to be matched?
  boolean available;
 
  // Should I be deleted?
  boolean delete;
 
  // How long should I live if I have disappeared?
  int timer = 100;
 
  // Assign a number to each face
  int id;
 
  //float a;
 
  // Make me
  Face(int newID, int x, int y, int w, int h, float s) {
    r = new Rectangle(x,y,w,h);
    available = true;
    delete = false;
    id = newID;
  }
 void display() {}
 
  // Give me a new location / size
  // Oooh, it would be nice to lerp here!
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
  }
 
  // Count me down, I am gone
  void countDown() {
    timer--;
  }
 
  // I am deed, delete me
  boolean dead() {
    if (timer < 0) return true;
    return false;
  }
}
