using Gee;

using CelticEgyptianRatscrewKata;
using CelticEgyptianRatscrewKata.Game;

namespace ConsoleBasedGame
{
    class Program
    {
        static void main(string[] args)
        {
            var reporter = new ConsoleEventReporter();
            GameController game = new GameFactory().Create(reporter);

            var userInterface = new UserInterface();
            Gee.List<PlayerInfo> playerInfos = userInterface.GetPlayerInfoFromUser();
            var keyActionMap = new HashMap<int, ActionWrapper>();

            foreach (PlayerInfo playerInfo in playerInfos)
            {
                var player = new Player(playerInfo.PlayerName);
                game.AddPlayer(player);
                keyActionMap[playerInfo.PlayCardKey] = (ActionWrapper) Object.new(typeof(ActionWrapper), Player: player, Action: PlayerAction.PlayCard);
                keyActionMap[playerInfo.SnapKey] = (ActionWrapper) Object.new(typeof(ActionWrapper), Player: player, Action: PlayerAction.Snap);
            }

            game.StartGame(GameFactory.CreateFullDeckOfCards());

            int userInput;
            while (userInterface.TryReadUserInput(out userInput))
            {
                ActionWrapper action = keyActionMap[userInput];
                if(action == null)
                    continue;

                switch (action.Action)
                {
                    case PlayerAction.PlayCard:
                        game.PlayCard(action.Player);
                        break;
                    case PlayerAction.Snap:
                        game.AttemptSnap(action.Player);
                        break;
                    default:
                        assert_not_reached();
                }
                IPlayer p;
                if (game.TryGetWinner(out p))
                    break;
            }
        }
    }

    public class ConsoleEventReporter : Object, IGameEventReporter
    {
        public void OnCardPlayed(IPlayer player, Card card, TurnReport report)
        {
            stdout.printf(@"$(player.Name) played the $(card.Rank) of $(card.Suit).");
            WriteTurnReport(report);
        }

        private void WriteTurnReport(TurnReport report)
        {
            stdout.printf(@"Next to play is $(report.NextPlayer.Name).");
            stdout.printf(@"There are $(report.State.StackSize) cards in the stack.");
            if(report.State.StackSize != 0)
                stdout.printf(@" The top card is  the $(report.State.TopCard.Rank) of $(report.State.TopCard.Suit)");
            foreach (var playerStack in report.State.PlayerStacks.entries)
            {
                stdout.printf(@"$(playerStack.key) has $(playerStack.value) cards left");
            }
        }

        public void OnStackSnapped(IPlayer player, TurnReport report)
        {
            stdout.printf(@"$(player.Name) snapped the stack.");
            WriteTurnReport(report);
        }

        public void OnPlayerPenalised(IPlayer player)
        {
            stdout.printf(@"$(player.Name) tried to snap when not valid and is now in the sin bin.");
        }

        public void OnPlayerAttemptedSnapWhilePenalised(IPlayer player)
        {
            stdout.printf(@"Naughty player, you're in the sin bin.");
        }

        public void OnPenaltyDeadlockCleared()
        {
            stdout.printf(@"Deadlock cleared.");
        }

        public void OnPlayerPlayedOutOfTurn(IPlayer player, Card card, TurnReport report)
        {
            stdout.printf(@"$(player.Name) played $(card.Rank) of $(card.Suit) out of turn and is now in the sin bin.");
            WriteTurnReport(report);
        }
    }

    internal class ActionWrapper : Object
    {
        public PlayerAction Action {get; construct set;}
        public IPlayer Player {get; construct set;}
    }

    internal enum PlayerAction
    {
        PlayCard,
        Snap
    }
}
