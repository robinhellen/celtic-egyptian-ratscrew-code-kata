using Gee;

namespace ConsoleBasedGame
{
    class UserInterface : Object
    {
        public Gee.List<PlayerInfo> GetPlayerInfoFromUser()
        {
            var result = new LinkedList<PlayerInfo>();
            bool again = false;
            do
            {
                GLib.stdout.printf("Enter player name: ");
                var playerName = GLib.stdin.read_line();
                var playCardKey = AskForKey("Enter play card key: ");
                var snapKey = AskForKey("Enter snap key: ");
                result.add(new PlayerInfo(playerName, playCardKey, snapKey));

                var createPlayerKey = AskForKey("Create another player? (y|n): ");
                again = createPlayerKey == 'y';
            } while (again);
            return result;
        }

        private static char AskForKey(string prompt)
        {
            GLib.stdout.printf(prompt);
            var response = GLib.stdin.read_line();
            return response[0];
        }

        public bool TryReadUserInput(out char userInput)
        {
            var keyPress = GLib.stdin.read_line();
            userInput = keyPress[0];
            return true;
        }
    }
}
