import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private int [] playerLifes;
  private Dot [] players;
  private Dot[] enemies;
  private Dot[] food;
  private int maxLife;
  private boolean gameover;


  Game(int width, int height, int numberOfEnemies, int numberOfFood)
  {
    gameover = false;
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
    playerLifes = new int[2];
    players = new Dot[2];
    enemies = new Dot[numberOfEnemies];
    food = new Dot[numberOfFood];
    for (int i = 0; i < players.length; ++i)
    {
      players[i] = new Dot(0*width, 0, width-1, height-1);
      playerLifes[i] = 100;
    }
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }

    for (int i = 0; i < numberOfFood; ++i)
    {
      food[i] = new Dot(width/2, height/2, width-1, height-1);
    }
  }

  public int [] getPlayerLife()
  {
    return playerLifes;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }

  public void update()
  {
    if (gameover != true) {
      updatePlayer();
      updateEnemies();
      updateFood();
      clearBoard();
      populateBoard();
      checkForCollisions();
      checkLifes();
    } else {
      background(255);
      fill(0);
      if (playerLifes[0] > playerLifes[1]) {
        text("GAME OVER: SPILLER 1 VANDT", width/2, height/2);
      } else {
        text("GAME OVER: SPILLER 2 VANDT", width/2, height/2);
      }
    }
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
    for (int i = 0; i < players.length; ++i)
    {
      if (keys.wDown(i) && !keys.sDown(i))
      {
        players[i].moveUp();
      }
      if (keys.aDown(i) && !keys.dDown(i))
      {
        players[i].moveLeft();
      }
      if (keys.sDown(i) && !keys.wDown(i))
      {
        players[i].moveDown();
      }
      if (keys.dDown(i) && !keys.aDown(i))
      {
        players[i].moveRight();
      }
    }
  }

  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        float [] dist = new float [2];
        for (int b = 0; b < players.length; ++b)
        {
          dist[b] = dist(players[b].getX(), players[b].getY(), enemies[i].getX(), enemies[i].getY());
        }
        //We follow
        int dx;
        int dy;
        if (dist[0] > dist[1]) {
          dx = players[1].getX()- enemies[i].getX();
          dy =  players[1].getY() - enemies[i].getY();
        } else {
          dx = players[0].getX()- enemies[i].getX();
          dy =  players[0].getY()- enemies[i].getY();
        }

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

  private void updateFood()
  {
    for (int i = 0; i < food.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..

      if (rnd.nextInt(3) < 2)
      {

        int [] dx_ = new int [2];
        int [] dy_ = new int [2];
        for (int b = 0; b < players.length; ++b)
        {
          dx_[b] = players[b].getX() - food[i].getX();
          dy_[b] = players[b].getY() - food[i].getY();
        }
        //We follow
        int dx;
        int dy;
        if (dy_[0]+dx_[0] > dy_[1]+dx_[1]) {
          dx = dx_[1];
          dy = dy_[1];
        } else {
          dx = dx_[0];
          dy = dy_[0];
        }
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            food[i].moveLeft();
          } else
          {
            //Player is to the left
            food[i].moveRight();
          }
        } else if (dy > 0)
        {
          //Player is down;
          food[i].moveUp();
        } else
        {//Player is up;
          food[i].moveDown();
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

    for (int i = 0; i < players.length; ++i)
    {
      board[players[i].getX()][players[i].getY()] = 1;
      if (i ==1) {
        board[players[i].getX()][players[i].getY()] = 4;
      } else {
        board[players[i].getX()][players[i].getY()] = 1;
      }
    }

    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    
    //Insert food
    for (int i = 0; i < food.length; ++i)
    {
      board[food[i].getX()][food[i].getY()] = 3;
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      for (int b = 0; b < players.length; ++b)
      {
        if (enemies[i].getX() == players[b].getX() && enemies[i].getY() == players[b].getY())
        {
          //We have a collision
          --playerLifes[b];
        }
      }
    }

    for (int i = 0; i < food.length; ++i)
    {
      for (int b = 0; b < players.length; ++b)
        if (food[i].getX() == players[b].getX() && food[i].getY() == players[b].getY())
        {
          //We have a collision
          if (playerLifes[b] > maxLife) {
            playerLifes[b] += 25;
            food[i].x = (int) random(width-1);
            food[i].y = (int) random(width-1);
          }
        }
    }
  }

  private void checkLifes() {
    for (int b = 0; b < players.length; ++b)

      //We have a collision
      if (playerLifes[b] <= 0) {
        gameover = true;
      }
  }
}
