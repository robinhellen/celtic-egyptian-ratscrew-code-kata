namespace ConsoleBasedGame
{
    internal class PlayerInfo
    {
        public string PlayerName { get; private set; }
        public int PlayCardKey { get; private set; }
        public int SnapKey { get; private set; }

        public PlayerInfo(string playerName, int playCardKey, int snapKey)
        {
            SnapKey = snapKey;
            PlayerName = playerName;
            PlayCardKey = playCardKey;
        }
    }
}
