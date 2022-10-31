int rows, cols; 
int scale = 10; 
float[][] terrain;
int[] cValue; 
float xoff; 
float yoff; 
float flying = 0; 
float flyX = 0; 
boolean game_running = false; 

float test = 0; 

// Player 
float speed = .2; 
float roll = 0;
float yaw = 0; 

void setup(){
  size(1024, 800, P3D); 
  int w = 2400; 
  int h = 2400; 
  cols = w / scale; 
  rows = h / scale; 
  terrain = new float[cols][rows];
  cValue = new int[cols];
  for(int i = 0; i < cols; i++){
    cValue[i] = int(i*2.5);
  }
}

void draw(){
  background(0);
  
  if(game_running){
    // Draw HUD: 
    
    if (keyPressed) {
      if (key == 'a' && yaw < speed || key == 'A' && yaw < speed) {
        yaw += 0.01;
        }
      if (key == 'd' && yaw > -speed || key == 'D' && yaw > -speed){
        yaw -= 0.01;
        }
      if (key == 'q' && roll < .75 || key == 'Q' && roll < .75) {
        roll += 0.01;
        }
     if (key == 'e' && roll > -.75 || key == 'E' && roll > -.75){
        roll -= 0.01;
        }
     }
     
    flying -= speed; 
    flyX -= yaw; 
    yoff = flying;  
    for(int y = 0; y < rows; y++){
      xoff = flyX; 
      for(int x = 0; x < cols; x++){
        terrain[x][y] = map(noise((xoff), (yoff)), 0, 1, -100, 250);
        xoff += 0.1;
      }
      yoff += 0.1; 
    }
    //noFill(); 
    translate(width/2, height/2);
    rotateX(1);
    rotateY(roll);
    rotateZ(yaw); 
    translate(-width, -height/2);
    
    
    for(int y = 0; y < rows-1; y++){
      fill(0, 255-cValue[y],cValue[y], cValue[y]);
      beginShape(TRIANGLE_STRIP); 
      for(int x = 0; x < cols; x++){
          vertex(x*scale,y*scale, terrain[x][y]);
          vertex(x*scale,(y+1)*scale, terrain[x][y+1]);
      }
      endShape(); 
    }
  }
  else{
    String title = "Fly over Noise"
    float textOffsetX = 0; 
    float textOffsetY = 0; 
    
    textOffsetX += map(mouseX, 0, width, 100, -100);
    textOffsetY += map(mouseY, 0, width, 100, -100);
    
    textSize(128);
    textAlign(CENTER); 
    fill(0,233,0, 140);
    text(title, width/2+textOffsetX, height/2+textOffsetY, -120);
    fill(0,233,0, 240);
    text(title, width/2, height/2);
    
    textSize(32);
    fill(255);
    text("press ENTER", width/2, height/2+100);
    
    if (keyPressed) {
      if (key == ENTER) {
          game_running = true;
      }
      } 
  }
}
