class BoutonFeu extends Bouton
{
  BoutonFeu()
  {
    super(width/2 + 100 ,height/2);
    Image = loadImage("boutonFeu.png");
    Over = loadImage("boutonFeuOver.png");
  }
  
    void Click(){
  currentMapID = 0;
  }
  
}

class BoutonEau extends Bouton
{
  BoutonEau()
  {
    super(width/2 + 100 ,height/2 + (height/15 + 50));
    Image = loadImage("boutonEau.png");
    Over = loadImage("boutonEauOver.png");
  }
  
  void Click(){
  currentMapID = 1;
  }
  
  
}

class BoutonAir extends Bouton
{
  BoutonAir()
  {
    super(width/2 + 100 ,height/2 + (height/15 + 50)*2);
    Image = loadImage("boutonAir.png");
    Over = loadImage("boutonAirOver.png");
  }
  
    void Click(){
  currentMapID = 2;
  }
  
}

class BoutonTerre extends Bouton
{
  BoutonTerre()
  {
    
    super(width/2 + 100,height/2 + (height/15 + 50)*3);
    Image = loadImage("boutonTerre.png");
    Over = loadImage("boutonTerreOver.png");
    
  }
  
    void Click(){
  currentMapID = 3;
  }
  
}