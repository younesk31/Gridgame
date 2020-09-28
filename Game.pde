import java.util.Random;
class Game
{
  private Random rnd;
  private final int width;
  private final int height;
  private int[][] board;
  private Keys keys; 
  private Keys2 keys2;
  private int playerLife;
  private int player2Life;
  private Dot player;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] food;
  private int numberOfFood = 1;



  Game(int width, int height, int numberOfEnemies)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    keys2 = new Keys2();
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(width-1, 0, width-1, height-1);
    enemies = new Dot[numberOfEnemies];
    food = new Dot[numberOfFood];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width/2, height/2, width-1, height-1);
    }

    this.playerLife = 100;
    this.player2Life = 100;
    for (int i = 0; i < numberOfFood; ++i)
    {
      food[i] = new Dot(0, height-1, width-1, height-1);
    }
    
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }

  public int getPlayer2Life()
  {
    return player2Life;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }

  public void onKeyPressedPlayer2(int move)
  {
    keys2.onKeyPressed(move);
  }

  public void onKeyReleasedPlayer2(int move)
  {
    keys2.onKeyReleased(move);
  }

  public void update()
  {
    updatePlayer();
    updatePlayer2();
    updateEnemies();
    updateEnemies2();
    updateFood();
    checkForCollisions();
    clearBoard();
    populateBoard();
    game.healthSys();
  }

  public int[][] getBoard()
  {
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer()
  {
    //Update player
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }

  private void updatePlayer2()
  {
    //Update player 2
    if (keys2.wDown() && !keys2.sDown())
    {
      player2.moveUp();
    }
    if (keys2.aDown() && !keys2.dDown())
    {
      player2.moveLeft();
    }
    if (keys2.sDown() && !keys2.wDown())
    {
      player2.moveDown();
    }
    if (keys2.dDown() && !keys2.aDown())
    {
      player2.moveRight();
    }
  }

  private void updateEnemies() {
    for (int i = 0; i < enemies.length-(enemies.length/2); ++i) 
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void updateEnemies2() {
    for (int i = (enemies.length/2); i < enemies.length; ++i) 
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player2.getX() - enemies[i].getX();
        int dy = player2.getY() - enemies[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

private void updateFood() {
    for (int i = 0; i < food.length; ++i) 
    {
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = (player.getX() - food[i].getX())+(player2.getX() - food[i].getX());
        int dy = (player.getY() - food[i].getY())+(player2.getY() - food[i].getY());
        if (abs(dx*2) > abs(dy*2))
        {
          if (dx > 0)
          {
            //Player is to the right
            food[i].moveRight();
          } else
          {
            //Player is to the left
            food[i].moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
          food[i].moveDown();
        } else
        {//Player is up;
          food[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          food[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          food[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          food[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }
  


  private void populateBoard()
  {
    //Insert player
    board[player.getX()][player.getY()] = 1;
    board[player2.getX()][player2.getY()] = 2;
    
    
    for (int i = 0; i < food.length; ++i) {
      board[food[i].getX()][food[0].getY()] = 3;
    }
    //Insert food
    
    //board[food[1].getX()][food[1].getY()] = 3;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i) {
      board[enemies[i].getX()][enemies[i].getY()] = 4;
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i) {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        --playerLife;
      } else if (enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY()) {
        --player2Life;
      }
    }
    for (int i = 0; i < food.length; ++i) {
      //Check for food collisions
      if (food[i].getX() == player.getX() && food[i].getY() == player.getY()) {
        //We have a collision
        playerLife = playerLife +2;
        food[i] = new Dot(rnd.nextInt(width-1), rnd.nextInt(height-1), width-1, height-1);
        } else if (food[i].getX() == player2.getX() && food[i].getY() == player2.getY()) {
          //We have a collision
        player2Life = player2Life +2;
        food[i] = new Dot(rnd.nextInt(width-1), rnd.nextInt(height-1), width-1, height-1);
      }
    }
  }

  private void healthSys() {
    if (playerLife <= 0) dead = true;
    if (playerLife <= 0) {
      dead = true;
      player1ded = true;
      System.out.print("Player 1 død --> venter på input --> ");
      noLoop();
      return;
    } else if (player2Life <= 0) {
      dead = true;
      player2ded = true;
      System.out.print("Player 2 død --> venter på input --> ");
      noLoop();
      return;
    }
  }

  private void gamerestart() {
    if (restart) {
      restart = false;
      newGame = true;
      playerLife = 100;                
      player2Life = 100;
      game = new Game(30, 20, enemy_amount);
      draw();
      System.out.print("Keypressed --> Kalder restart --> ");
    }
  }
}
