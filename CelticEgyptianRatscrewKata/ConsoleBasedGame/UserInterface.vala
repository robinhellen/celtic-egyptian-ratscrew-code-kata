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
                stdout.printf("Enter player name: ");
                var playerName = stdin.read_line();
                var playCardKey = AskForKey("Enter play card key: ");
                var snapKey = AskForKey("Enter snap key: ");
                result.add(new PlayerInfo(playerName, playCardKey, snapKey));

                var createPlayerKey = AskForKey("Create another player? (y|n): ");
                again = createPlayerKey == 'y';
            } while (again);
            return result;
        }

        private static int AskForKey(string prompt)
        {
            stdout.printf(prompt);
            var response = stdin.getc();
            stdout.printf("/n");
            return response;
        }

        public bool TryReadUserInput(out int userInput)
        {
            var keyPress = stdin.getc();
            stdout.printf("/n");
            userInput = keyPress;
            return true;
        }
    }
}
