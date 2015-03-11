namespace CelticEgyptianRatscrewKata.Game
{
    public class Player : Object, IPlayer
    {
        private string name;

        public Player(string playerId)
        {
            name = playerId;
        }

        public string Name { get {return name;} }
    }
}
