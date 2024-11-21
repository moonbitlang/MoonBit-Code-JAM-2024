fn move (player1_:Player,player2_:Player)->Unit{
  if player1_.pos.x>player2_.pos.x{player1_.direction=true
  player2_.direction=false}
  if player2_.pos.x>player1_.pos.x{player2_.direction=true
  player1_.direction=false}
}