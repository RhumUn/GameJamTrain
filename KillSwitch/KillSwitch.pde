String[] Elements;
int currentMapID;
ArrayList<Bouton> boutons = new ArrayList<Bouton>();


void setup(){
  
  size(1200,800);
  Elements = new String[4];
  Elements[0]="feu";
  Elements[1]="eau";
  Elements[2]="air";
  Elements[3]="terre";
  
  
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