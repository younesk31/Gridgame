/* 
*
*  Der skal tilføjes mad som er grønt. Maden er levende og skal bevæge sig rundt ligesom fjenderne, men i stedet for at løbe mod spillere, skal de løbe væk fra dem. 
*  Hver gang du rammer et felt med mad på får du et point (point). Herefter flytter maden til en ny tilfældig position på boardet.
*  Du skal lave endnu en spiller som er en anden farve end den første, men ikke samme farve som fjender eller mad. Den nye spiller skal styres med piletasterne.
*  Når en spiller har mindre end 1 playerLife tilbage, dør den og modstanderen har vundet. Man kan også vinde, ved at være den første spiller der opnår max point (f.eks 100).
*
*  Ovenstående er minimumskrav. Alle udvidelser og ekstra funktionalitet er yderst velkomne og vil give ekstra class-credit.
*
*/

Game game;
import java.util.Random;
int enemy_amount = 4; // halvdelen mod player 1 og den anden mod player 2

boolean startMenu = true;
boolean newGame = false;
boolean restart = false;
boolean dead = false;
boolean won = false;
boolean player1ded = false;
boolean player2ded = false;
float rnd = random(6,12);
int goal = round(rnd);
int splayer1 = 0; int splayer2 = 0; int points1 = 0; int points2 = 0; 
String Gameover = "Øv bøv bussemand"; String Gameover1 = "Player 1 vandt denne runde!"+'\n'+"Press To Continue"; String Gameover2 = "Player 2 vandt denne runde!"+'\n'+"Press To Continue";
String Start = "Press any key for start";                
String Start1 = "Player 1 - Controls: WASD       Player 2 - Controls: Arrow Keys";


PFont font;

public void settings() {
  size(1201, 801);
}

void setup()
{
  frameRate(10);
  font = createFont("Arial", 16, true);
  textFont(font);
}

void keyReleased()
{
  game.onKeyReleased(key);
  game.onKeyReleasedPlayer2(keyCode);
}

void keyPressed()
{
  if (startMenu) {
    newGame = true;
    startMenu = false;
    System.out.println("[Start Menu] --> ");
  }
  if (restart) {
    game.gamerestart();
    loop();
    System.out.println("Succes! Starter nyt game! ");
    
  }
  game.onKeyPressed(key);
  game.onKeyPressedPlayer2(keyCode);
}

void draw()
{
  if (startMenu) {
    game = new Game(30, 20, enemy_amount);
    displayMenu();
    return;
  }
  if (newGame) {
    game.update();
  }
///////// High score /////////
  if (splayer1 == 0 || points1 >= splayer1) {
      splayer1 = points1;
    }
    if (splayer2 == 0 || points2 >= splayer2) {
      splayer2 = points2;
    }
    
    // points1 == Collected 
    if (points1 == goal && dead == false) {
      //dead = false;
      background(0);
      textSize(30);
      fill(255, 255, 255);
      textAlign(CENTER, BOTTOM);
      text("Player 1 Vandt med en score på: ", width/2, height/2-35);  
      text(points1+" mod "+points2, width/2, height/2);
      text("GG!", width/2, height/2+35);
      restart = false;
      //won = true;
      System.out.println();
      System.out.print("Player 1 ramte målet og vandt --> Venter på genstart :) ");
      noLoop();
      return;
    } else if (points2 == goal && dead == false) {
      //dead = true;
      background(0);
      textSize(30);
      fill(255, 255, 255);
      textAlign(CENTER, BOTTOM);
      text("Player 2 Vandt med en score på: ", width/2, height/2-35);  
      text(points2+" mod "+points1, width/2, height/2);
      text("GG!", width/2, height/2+35);
      textAlign(BASELINE );
      textFont(font, 16);
      restart = false;
      //won = true;
      System.out.println();
      System.out.println("Player 2 ramte målet og vandt --> Venter på genstart :) ");
      noLoop();
      return;
    }

  if (player1ded) {
    dead = false;
    player1ded = false;
    points2 = points2 + 1;
    background(0);
    textSize(30);
    fill(255, 255, 255);
    textAlign(CENTER, BOTTOM);
    text("Player 1: > "+points1+" <         Player 2: > "+points2+" <", width/2, 45);
    text(Gameover, width/2, height/2);
    text(Gameover2, width/2, height/2+75);
    textAlign(BASELINE );
    textFont(font, 16);
    System.out.print("Game over -->"+" Scoren er: "+points1+"|"+points2+" --> venter på input --> ");
    restart = true;
    noLoop();
    return;
  } else if (player2ded) {
    dead = false;
    player2ded = false;
    points1 = points1 + 1;
    background(0);
    textSize(30);
    fill(255, 255, 255);
    textAlign(CENTER, BOTTOM);
    text("Player 1: > "+points1+" <         Player 2: > "+points2+" <", width/2, 45);
    text(Gameover, width/2, height/2);
    text(Gameover1, width/2, height/2+75);
    textAlign(BASELINE );
    textFont(font, 16);
    System.out.print("Game over -->"+" Scoren er: "+points1+"|"+points2+" --> venter på input --> ");
    restart = true;
    noLoop();
    return;
    
  }
  
    background(0);
    int[][] board = game.getBoard();
    for (int y = 0; y < game.getHeight(); y++)
    {
      for (int x = 0; x < game.getWidth(); x++)
      {
        if (board[x][y] == 0)        // Sort (board)
        {
          fill(0, 0, 0);
        } else if (board[x][y] == 1) // Blå (Player 1)
        {
          fill(0, 0, 255);
        } else if (board[x][y] == 2) // Gul (Player 2)
        {
          fill(255, 255, 0);
        } else if (board[x][y] == 3) // Grøn (Mad)
        {
          fill(0, 255, 0);
        } else if (board[x][y] == 4) // Rød (Fjender)
        {
          fill(255, 0, 0);
        }
        stroke(100, 100, 100);
        rect(x*40, y*40, 50, 50);
      }
    }
    fill(255);
    textFont(font, 30);
    textAlign(CENTER, BOTTOM);
    text(">"+points1+"<   Målet er: "+goal+"   >"+points2+"<", width/2, 45);
    textFont(font, 16);
    textAlign(BASELINE );
    text("Player 1 Life: "+game.getPlayerLife(), 25, 25);
    text("Player 2 Life: "+game.getPlayer2Life(), width-150, 25);
  }

void displayMenu() {
  background(0, 0, 0);
  textSize(30);
  fill(50, 255, 255);
  textAlign(CENTER, BOTTOM);
  text(Start, width/2, height/2);
  text(Start1, width/2, height/2+50);
  textAlign(BASELINE );
  textFont(font, 16);
  return;
}
