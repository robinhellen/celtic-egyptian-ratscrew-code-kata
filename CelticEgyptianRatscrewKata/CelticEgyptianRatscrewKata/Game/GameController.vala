using Gee;

using CelticEgyptianRatscrewKata.GameSetup;
using CelticEgyptianRatscrewKata.SnapRules;

namespace CelticEgyptianRatscrewKata.Game
{
    /// <summary>
    /// Controls a game of Celtic Egyptian Ratscrew.
    /// </summary>
    public class GameController
    {
        private ISnapValidator m_SnapValidator;
        private IDealer m_Dealer;
        private IShuffler m_Shuffler;
        private Gee.List<IPlayer> m_Players;
        private IGameState m_GameState;
        private Set<IPlayer> m_NaughtyList;

        private IGameEventReporter m_Reporter;

        private IPlayer nextPlayer;

        public GameController(IGameState gameState, ISnapValidator snapValidator, IDealer dealer, IShuffler shuffler, IGameEventReporter mReporter)
        {
            m_Players = new ArrayList<IPlayer>();
            m_GameState = gameState;
            m_SnapValidator = snapValidator;
            m_Dealer = dealer;
            m_Shuffler = shuffler;
            m_Reporter = mReporter;
            m_NaughtyList = new HashSet<IPlayer>();
        }

        public bool AddPlayer(IPlayer player)
        {
            if (m_Players.fold<bool>((x, y) => y || x.Name == player.Name, false)) return false;

            if(nextPlayer == null)
                nextPlayer = player;

            m_Players.add(player);
            m_GameState.AddPlayer(player.Name, Cards.Empty());
            return true;
        }

        public void PlayCard(IPlayer player)
        {
            if (m_GameState.HasCards(player.Name))
            {
                if(nextPlayer == player)
                {
                    var cardPlayed = m_GameState.PlayCard(player.Name);
                    nextPlayer = m_Players[(m_Players.index_of(player) + 1)%m_Players.size];
                    m_Reporter.OnCardPlayed(player, cardPlayed, GetReport());
                }
                else
                {
                    var cardPlayed = m_GameState.PlayCard(player.Name, false);
                    PenalisePlayer(player, reporter => reporter.OnPlayerPlayedOutOfTurn(player, cardPlayed, GetReport()));
                }
            }
        }

        public void AttemptSnap(IPlayer player)
        {
            AddPlayer(player);

            if(m_NaughtyList.contains(player))
            {
                m_Reporter.OnPlayerAttemptedSnapWhilePenalised(player);
                return;
            }
            if (m_SnapValidator.CanSnap(m_GameState.Stack))
            {
                m_GameState.WinStack(player.Name);
                m_Reporter.OnStackSnapped(player, GetReport());
                m_NaughtyList.clear();
            }
            else
            {
                PenalisePlayer(player, reporter => reporter.OnPlayerPenalised(player));
            }
        }

        private void PenalisePlayer(IPlayer player, Action<IGameEventReporter> reportPenalty)
        {
            m_NaughtyList.add(player);
            reportPenalty(m_Reporter);

            if(m_Players.size == m_NaughtyList.size)
            {
                m_NaughtyList.clear();
                m_Reporter.OnPenaltyDeadlockCleared();
            }
        }

        private TurnReport GetReport()
        {
            return new TurnReport()
            {
                State = m_GameState.GetCurrentStateReport(),
                NextPlayer = nextPlayer
            };
        }

        /// <summary>
        /// Starts a game with the currently added players
        /// </summary>
        public void StartGame(Cards deck)
        {
            m_GameState.Clear();

            var shuffledDeck = m_Shuffler.Shuffle(deck);
            var decks = m_Dealer.Deal(m_Players.size, shuffledDeck);
            for (var i = 0; i < decks.size; i++)
            {
                m_GameState.AddPlayer(m_Players[i].Name, decks[i]);
            }
        }

        public bool TryGetWinner(out IPlayer winner)
        {
            var playersWithCards = new ArrayList<IPlayer>();
            m_Players.filter(p => m_GameState.HasCards(p.Name)).foreach(p => playersWithCards.add(p));

            if (m_GameState.Stack.fold<bool>(() => true, false) && playersWithCards.size == 1)
            {
                winner = playersWithCards.first();
                return true;
            }

            winner = null;
            return false;
        }
    }

    public class TurnReport
    {
        public IPlayer NextPlayer;
        public GameStateReport State;
    }

    public interface IGameEventReporter : Object
    {
        public abstract void OnCardPlayed(IPlayer player, Card card, TurnReport report);
        public abstract void OnStackSnapped(IPlayer player, TurnReport report);
        public abstract void OnPlayerPenalised(IPlayer player);
        public abstract void OnPlayerAttemptedSnapWhilePenalised(IPlayer player);
        public abstract void OnPenaltyDeadlockCleared();
        public abstract void OnPlayerPlayedOutOfTurn(IPlayer player, Card card, TurnReport report);
    }

    public delegate void Action<T>(T t);
}
