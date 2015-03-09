using System;
using System.Collections.Generic;

namespace ConsoleBasedGame
{
    class UserInterface
    {
        public IEnumerable<PlayerInfo> GetPlayerInfoFromUserLazily()
        {
            bool again;
            do
            {
                Console.Write("Enter player name: ");
                var playerName = Console.ReadLine();
                var playCardKey = AskForKey("Enter play card key: ");
                var snapKey = AskForKey("Enter snap key: ");
                yield return new PlayerInfo(playerName, playCardKey, snapKey);

                var createPlayerKey = AskForKey("Create another player? (y|n): ");
                again = createPlayerKey.Equals('y');
            } while (again);
        }

        private static char AskForKey(string prompt)
        {
            Console.Write(prompt);
            var response = Console.ReadKey().KeyChar;
            Console.WriteLine();
            return response;
        }

        public bool TryReadUserInput(out char userInput)
        {
            ConsoleKeyInfo keyPress = Console.ReadKey();
            Console.WriteLine();
            userInput = keyPress.KeyChar;
            return keyPress.Key != ConsoleKey.Escape;
        }
    }
}