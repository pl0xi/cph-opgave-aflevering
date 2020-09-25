class Keys
{
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;

  private boolean wDown2 = false;
  private boolean aDown2 = false;
  private boolean sDown2 = false;
  private boolean dDown2 = false;

  public Keys() {
  }

  public boolean wDown(int player)
  {
    if (player == 0) {
      return wDown;
    } else {
      return wDown2;
    }
  }

  public boolean aDown(int player)
  {
    if (player == 0) {
      return aDown;
    } else {
      return aDown2;
    }
  }

  public boolean sDown(int player)
  {
    if (player == 0) {
      return sDown;
    } else {
      return sDown2;
    }
  }

  public boolean dDown(int player)
  {
    if (player == 0) {
      return dDown;
    } else {
      return dDown2;
    }
  }



  void onKeyPressed(char ch)
  {
    if (ch == CODED) {
      if (keyCode == UP)
      {
        wDown2 = true;
      } else if (keyCode == LEFT)
      {
        aDown2 = true;
      } else if (keyCode == DOWN)
      {
        sDown2 = true;
      } else if (keyCode == RIGHT)
      {
        dDown2 = true;
      }
    } else {
      if (ch == 'W' || ch == 'w')
      {
        wDown = true;
      } else if (ch == 'A' || ch == 'a')
      {
        aDown = true;
      } else if (ch == 'S' || ch == 's')
      {
        sDown = true;
      } else if (ch == 'D' || ch == 'd')
      {
        dDown = true;
      }
    }
  }

  void onKeyReleased(char ch)
  {
    if (ch == CODED) {
      if (keyCode == UP)
      {
        wDown2 = false;
      } else if (keyCode == LEFT)
      {
        aDown2 = false;
      } else if (keyCode == DOWN)
      {
        sDown2 = false;
      } else if (keyCode == RIGHT)
      {
        dDown2 = false;
      }
    } else {
      if (ch == 'W' || ch == 'w')
      {
        wDown = false;
      } else if (ch == 'A' || ch == 'a')
      {
        aDown = false;
      } else if (ch == 'S' || ch == 's')
      {
        sDown = false;
      } else if (ch == 'D' || ch == 'd')
      {
        dDown = false;
      }
    }
  }
}
