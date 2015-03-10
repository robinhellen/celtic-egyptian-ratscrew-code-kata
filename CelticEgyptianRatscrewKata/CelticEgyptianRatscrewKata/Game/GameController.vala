using System;
using System.Collections.Generic;
using System.Linq;
using CelticEgyptianRatscrewKata.GameSetup;
using CelticEgyptianRatscrewKata.SnapRules;

namespace CelticEgyptianRatscrewKata.Game
{
    /// <summary>
    /// Controls a game of Celtic Egyptian Ratscrew.
    /// </summary>
    public class GameController
    {
        private readonly ISnapValidator m_SnapValidator;
        private readonly IDealer m_Dealer;
        private readonly IShuffler m_Shuffler;
        private readonly IList<IPlayer> m_Players;
        private readonly IGameState m_GameState;
        private readonly ISet<IPlayer> m_NaughtyList;

        private IGameEventReporter m_Reporter;

        private IPlayer nextPlayer;

        public GameController(IGameState gameState, ISnapValidator snapValidator, IDealer dealer, IShuffler shuffler, IGameEventReporter mReporter)
        {
            m_Players = new List<IPlayer>();
            m_GameState = gameState;
            m_SnapValidator = snapValidator;
            m_Dealer = dealer;
            m_Shuffler = shuffler;
            m_Reporter = mReporter;
            m_NaughtyList = new HashSet<IPlayer>();
        }

        public bool AddPlayer(IPlayer player)
        {
            if (m_Players.Any(x => x.Name == player.Name)) return false;

            if(nextPlayer == null)
                nextPlayer = player;

            m_Players.Add(player);
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
                    nextPlayer = m_Players[(m_Players.IndexOf(player) + 1)%m_Players.Count];
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

            if(m_NaughtyList.Contains(player))
            {
                m_Reporter.OnPlayerAttemptedSnapWhilePenalised(player);
                return;
            }
            if (m_SnapValidator.CanSnap(m_GameState.Stack))
            {
                m_GameState.WinStack(player.Name);
                m_Reporter.OnStackSnapped(player, GetReport());
                m_NaughtyList.Clear();
            }
            else
            {
                PenalisePlayer(player, reporter => reporter.OnPlayerPenalised(player));
            }
        }

        private void PenalisePlayer(IPlayer player, Action<IGameEventReporter> reportPenalty)
        {
            m_NaughtyList.Add(player);
            reportPenalty(m_Reporter);

            if(m_Players.Count == m_NaughtyList.Count)
            {
                m_NaughtyList.Clear();
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
            var decks = m_Dealer.Deal(m_Players.Count, shuffledDeck);
            for (var i = 0; i < decks.Count; i++)
            {
                m_GameState.AddPlayer(m_Players[i].Name, decks[i]);
            }
        }

        public bool TryGetWinner(out IPlayer winner)
        {
            var playersWithCards = m_Players.Where(p => m_GameState.HasCards(p.Name)).ToList();

            if (!m_GameState.Stack.Any() && playersWithCards.Count() == 1)
            {
                winner = playersWithCards.Single();
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

    public interface IGameEventReporter
    {
        void OnCardPlayed(IPlayer player, Card card, TurnReport report);
        void OnStackSnapped(IPlayer player, TurnReport report);
        void OnPlayerPenalised(IPlayer player);
        void OnPlayerAttemptedSnapWhilePenalised(IPlayer player);
        void OnPenaltyDeadlockCleared();
        void OnPlayerPlayedOutOfTurn(IPlayer player, Card card, TurnReport report);
    }
}
