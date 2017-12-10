int currentMapID;
ArrayList<Bouton> boutons = new ArrayList<Bouton>();

import java.util.Iterator;

String[] Elements = {"feu", "eau", "air", "terre"};
ArrayList<Monster> monsters = new ArrayList<Monster>();
int heroX = 300;
int heroY = 200;
float monsterSpeed = 0.1;
int time;
int spawnNbr = 1;
boolean gameover = false;
PFont f;

void setup(){
  
  size(1200,800);
  f = createFont("Arial",16,true);
  smooth();
  time = millis();

  currentMapID = 0;
  
  Bouton boutonEau = new BoutonEau();
  boutons.add(boutonEau);
  
  Bouton boutonFeu = new BoutonFeu();
  boutons.add(boutonFeu);
  
  Bouton boutonAir = new BoutonAir();
  boutons.add(boutonAir);
  
  Bouton boutonTerre = new BoutonTerre();
  boutons.add(boutonTerre);
}

void draw()
{
  background(255);
  Map newMap = new Map();
  newMap.PickMap(Elements[currentMapID]);
  
  for (Bouton bouton : boutons){
    bouton.DrawButton();
  }
    Bouton mouseBouton = getMouseBouton();
  if (mouseBouton != null){
      mouseBouton.Over();
  }
  if (gameover){
    drawGameOver();
  }
  else {
    createMonsters();
    drawHero();
    drawMonsters();
  }
}

public Bouton getMouseBouton()
{
  for (Bouton bouton : boutons){
    if (bouton.x < mouseX && mouseX < bouton.x + width/6  && bouton.y < mouseY && mouseY < bouton.y + height/8) return bouton;
  }
  return null;
}

void mousePressed(){
  Bouton mouseBouton = getMouseBouton();
  if (mouseBouton != null){
      mouseBouton.Click();
  }
}
class Map
{
PImage MondeFeu; 
PImage MondeEau;
PImage MondeAir;
PImage MondeTerre;

Map()
{

MondeFeu = loadImage("feu.jpg");
MondeEau = loadImage("eau.jpg");
MondeAir = loadImage("air.jpg");
MondeTerre = loadImage("terre.jpg");

}

  
public void PickMap(String typeMap)
{
  if (typeMap == "feu")
  {
    printMap(MondeFeu);  
  }
  
    if (typeMap == "eau")
  {
    printMap(MondeEau); 
  }
  
    if (typeMap == "air")
  {
    printMap(MondeAir); 
  }
  
    if (typeMap == "terre")
  {
    printMap(MondeTerre); 
  }
}
public void printMap(PImage Image)
{
  image(Image, 0, 0, width/2, height/2); 
}
}

abstract class Bouton
{

int x;
int y;


PImage Image;
PImage Over;



Bouton(int x,int y)
{
  setX(x);
  setY(y);
}

public void setX(int X)
{
  this.x = X;
}

public void setY(int Y)
{
  this.y = Y;
}

public void DrawButton()
{
  
  image(this.Image, this.x, this.y, width/3, height/15); 
  
}

public void Over()
{
  image(this.Over, this.x, this.y, width/3, height/15);  
}

public void Click(){

}
}

void drawMonsters(){
  for (Iterator<Monster> iterator = monsters.iterator(); iterator.hasNext();){
      Monster monster = iterator.next();
      switch (monster._element) {
        case "feu":
          fill(255 - (100 - monster._hp),0,0);
          break;
        case "eau":
          fill(0,0,255);
          break;
        case "terre":
          fill(0,255,0);
          break;
        case "air":
          fill(235,235,235);
          break;
      }
          monster.update();
          monster.checkEdges();
          monster.checkMapElement();
          monster.checkKill();
          monster.display();
          println(monster.isDead());
          if (monster.isDead() == true){
            iterator.remove();
          }
  }
}

void drawHero(){
    fill(255,0,255);
    rect(heroX,heroY,20,20);
}

void drawGameOver(){
   fill(0);
   rect(15, 15, 600, 400);
   textFont(f,80);  
   fill(255);
   textAlign(CENTER);
   text("GAME OVER",300,200);
   textFont(f,25);  
   fill(255);
   textAlign(CENTER);
   text("PRESS R TO RESTART",300,250);
   text("PRESS Q TO QUIT",300,300);
}

void createMonsters(){
  float x;
  float y;
  if (millis() > time + 000 && monsters.size() == 0)
  {
    if (time > 15000) spawnNbr += 0;
    for (int i = 0; i < spawnNbr; i++){
      int index = int(random(elements.length));
      int spawnDir = int(random(1,5));
      switch (spawnDir){
        case 1:
          x = randomSpawnLeft()[0];
          y = randomSpawnLeft()[1];
        break;
        case 2:
          x = randomSpawnRight()[0];
          y = randomSpawnRight()[1];
        break;
        case 3:
          x = randomSpawnTop()[0];
          y = randomSpawnTop()[1];
        break;
        case 4:
          x = randomSpawnBot()[0];
          y = randomSpawnBot()[1];
        break;
        default:
          x = 0;
          y = 0;
        break;
      }
      monsters.add(new Monster(x, y, elements[0], 100));
    }
    time = millis();
  }
}

class Monster {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float _hp;
  String _element;
  String weakElement;
  
  Monster (float x, float y, String element, float hp) {
     _element = element;
     _hp = hp;
     location = new PVector(x,y);
     velocity = new PVector(0,0);
     topspeed = 0.1;
     switch (element){
     case "feu":
       weakElement = "eau";
       break;
     case "eau":
       weakElement = "terre";
       break;
     case "terre":
       weakElement = "air";
       break;
     case "air":
       weakElement = "feu";
       break;
     }
  }
  
  void update() {

    // Our algorithm for calculating acceleration:
    PVector mouse = new PVector(300,200);
    PVector dir = PVector.sub(mouse,location);  // Find vector pointing towards mouse
    dir.normalize();     // Normalize
    dir.mult(0.5);       // Scale 
    acceleration = dir;  // Set to acceleration

    // Motion 101!  Velocity changes by acceleration.  Location changes by velocity.
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  void display() {
      stroke(0);
      rect(location.x,location.y,20,20);
  }
  
  void checkMapElement(){
    topspeed = 0.1;
    if (currentMapElement == _element)
       topspeed = topspeed*2;
     else if (currentMapElement == weakElement){
       _hp -= 0.5;
       topspeed = topspeed/2;
     }
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    }  else if (location.y < 0) {
      location.y = height;
    }
  }
  
  void checkKill() {
    if ((int)location.x >= heroX &&  (int)location.x <= heroX +10) gameover = true;
    if ((int)location.y >= heroY &&  (int)location.y <= heroY +10) gameover = true;
  }
  
  boolean isDead(){
    if (_hp <= 0) return true;
    else return false;
  }
}

float[] randomSpawnLeft(){
  float x = 0;
  float y = random(0, 400);
  float spawn[] = {x,y};
  return spawn;
}

float[] randomSpawnRight(){
  float x = 600;
  float y = random(0, 400);
  float spawn[] = {x,y};
  return spawn;
}

float[] randomSpawnTop(){
  float x = random(0, 600);
  float y = 0;
  float spawn[] = {x,y};
  return spawn;
}

float[] randomSpawnBot(){
  float x = random(0, 600);
  float y = 400;
  float spawn[] = {x,y};
  return spawn;
}

void keyPressed(KeyEvent e) {

    if (key == 'r' && gameover) {
      restart();
    }
    else if (key == 'q' && gameover) {
      exit();
    }
}

void restart(){
   monsters = new ArrayList<Monster>();
   spawnNbr = 1;
   gameover = false;
}