namespace ConsoleBasedGame
{
    internal class PlayerInfo
    {
        public string PlayerName { get; private set; }
        public char PlayCardKey { get; private set; }
        public char SnapKey { get; private set; }

        public PlayerInfo(string playerName, char playCardKey, char snapKey)
        {
            SnapKey = snapKey;
            PlayerName = playerName;
            PlayCardKey = playCardKey;
        }
    }
}