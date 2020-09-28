class Keys2
{
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;
  
  public Keys2(){}
  
  public boolean wDown()
  {
    return wDown;
  }
  
  public boolean aDown()
  {
    return aDown;
  }
  
  public boolean sDown()
  {
    return sDown;
  }
  
  public boolean dDown()
  {
    return dDown;
  }
  
  
  
  void onKeyPressed(int move)
  {
    if(move == UP)
    {
      wDown = true;
    }
    else if (move == LEFT)
    {
      aDown = true;
    }
    else if(move == DOWN)
    {
      sDown = true;
    }
    else if(move == RIGHT)
    {
      dDown = true;
    }
  }
  
  void onKeyReleased(int move)
  {
    if(move == UP)
    {
      wDown = false;
    }
    else if (move == LEFT)
    {
      aDown = false;
    }
    else if(move == DOWN)
    {
      sDown = false;
    }
    else if(move == RIGHT)
    {
      dDown = false;
    }
  }
}
