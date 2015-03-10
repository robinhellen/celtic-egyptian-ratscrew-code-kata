using System;
using System.Collections.Generic;
using System.Linq;
using CelticEgyptianRatscrewKata;
using CelticEgyptianRatscrewKata.Game;

namespace ConsoleBasedGame
{
    class Program
    {
        static void Main(string[] args)
        {
            var reporter = new ConsoleEventReporter();
            GameController game = new GameFactory().Create(reporter
                );

            var userInterface = new UserInterface();
            IEnumerable<PlayerInfo> playerInfos = userInterface.GetPlayerInfoFromUserLazily();
            var keyActionMap = new Dictionary<char, Tuple<IPlayer, PlayerAction>>();

            foreach (PlayerInfo playerInfo in playerInfos)
            {
                var player = new Player(playerInfo.PlayerName);
                game.AddPlayer(player);
                keyActionMap[playerInfo.PlayCardKey] = new Tuple<IPlayer, PlayerAction>(player, PlayerAction.PlayCard);
                keyActionMap[playerInfo.SnapKey] = new Tuple<IPlayer, PlayerAction>(player, PlayerAction.Snap);
            }

            game.StartGame(GameFactory.CreateFullDeckOfCards());

            char userInput;
            while (userInterface.TryReadUserInput(out userInput))
            {
                Tuple<IPlayer, PlayerAction> action;
                if(!keyActionMap.TryGetValue(userInput, out action))
                    continue;

                switch (action.Item2)
                {
                    case PlayerAction.PlayCard:
                        game.PlayCard(action.Item1);
                        break;
                    case PlayerAction.Snap:
                        game.AttemptSnap(action.Item1);
                        break;
                    default:
                        throw new ArgumentOutOfRangeException();
                }
                IPlayer p;
                if (game.TryGetWinner(out p))
                    break;
            } 
        }
    }

    public class ConsoleEventReporter : IGameEventReporter
    {
        public void OnCardPlayed(IPlayer player, Card card, TurnReport report)
        {
            Console.WriteLine("{0} played the {1} of {2}.", player.Name, card.Rank, card.Suit);
            WriteTurnReport(report);
        }

        private void WriteTurnReport(TurnReport report)
        {
            Console.WriteLine("Next to play is {0}.", report.NextPlayer.Name);
            Console.WriteLine("There are {0} cards in the stack.", report.State.StackSize);
            if(report.State.StackSize != 0)
                Console.WriteLine(" The top card is {0}",report.State.TopCard);
            foreach (var playerStack in report.State.PlayerStacks)
            {
                Console.WriteLine("{0} has {1} cards left", playerStack.Item1, playerStack.Item2);
            }
        }

        public void OnStackSnapped(IPlayer player, TurnReport report)
        {
            Console.WriteLine("{0} snapped the stack.", player.Name);
            WriteTurnReport(report);
        }

        public void OnPlayerPenalised(IPlayer player)
        {
            Console.WriteLine("{0} tried to snap when not valid and is now in the sin bin.", player.Name);
        }

        public void OnPlayerAttemptedSnapWhilePenalised(IPlayer player)
        {
            Console.WriteLine("Naughty player, you're in the sin bin.");
        }

        public void OnPenaltyDeadlockCleared()
        {
            Console.WriteLine("Deadlock cleared.");
        }

        public void OnPlayerPlayedOutOfTurn(IPlayer player, Card card, TurnReport report)
        {
            Console.WriteLine("{0} played {1} of {2} out of turn and is now in the sin bin.", player.Name, card.Rank, card.Suit);
            WriteTurnReport(report);
        }
    }

    internal enum PlayerAction
    {
        PlayCard,
        Snap
    }
}
