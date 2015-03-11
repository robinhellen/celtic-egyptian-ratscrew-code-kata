using Gee;

namespace CelticEgyptianRatscrewKata.Game
{
    /// <summary>
    /// Represents the state of the game at any point.
    /// </summary>
    public class GameState : IGameState
    {
        private Cards m_Stack;
        private Map<string, Cards> m_Decks;

        /// <summary>
        /// Default constructor.
        /// </summary>
        public GameState.Default()
        {
            m_Stack = Cards.Empty();
            m_Decks = new HashMap<string, Cards>();
        }

        /// <summary>
        /// Constructor to allow setting the central stack.
        /// </summary>
        public GameState(Cards stack, Map<string, Cards> decks)
        {
            m_Stack = stack;
            m_Decks = decks;
        }

        public Cards Stack { owned get {return new Cards(m_Stack);} }

        public void AddPlayer(string playerId, Cards deck)
        {
            if (m_Decks.has_key(playerId)) throw new ArgumentException.Default("Can't add the same player twice");
            m_Decks.set(playerId, deck);
        }

        public Card PlayCard(string playerId, bool addToTop = true)
        {
            if (!m_Decks.has_key(playerId)) throw new ArgumentException.Default("The selected player doesn't exist");
            if (m_Decks[playerId].fold<bool>(_ => true, false)) throw new ArgumentException.Default("The selected player doesn't have any cards left");

            var topCard = m_Decks[playerId].Pop();

            if(addToTop)
            {
                m_Stack.AddToTop(topCard);
            }
            else
            {
                m_Stack.AddToBottom(topCard);
            }
            return topCard;
        }

        public void WinStack(string playerId)
        {
            if (!m_Decks.has_key(playerId)) throw new ArgumentException.Default("The selected player doesn't exist");

            foreach (var card in m_Stack.Reverse())
            {
                m_Decks[playerId].AddToBottom(card);
            }

            ClearStack();
        }

        private void ClearStack()
        {
            while (m_Stack.HasCards)
            {
                m_Stack.RemoveCardAt(0);
            }
        }

        public bool HasCards(string playerId)
        {
            if (!m_Decks.has_key(playerId)) throw new ArgumentException.Default("The selected player doesn't exist");
            return m_Decks[playerId].fold<bool>(() => false, true);
        }

        public void Clear()
        {
            ClearStack();
            m_Decks.clear();
        }

        public GameStateReport GetCurrentStateReport()
        {
            var stackSize = m_Stack.fold<int>((x, i) => i+1, 0);
            var stacks = new HashMap<string, int>();
            foreach(var entry in m_Decks.entries)
            {
                stacks[entry.key] = entry.value.fold<int>((x, i) => i+1, 0);
            }

            return (GameStateReport)Object.new(typeof(GameStateReport),
                TopCard: m_Stack.HasCards ? m_Stack.CardAt(0) : null,
                StackSize: stackSize,
                PlayerStacks: stacks);
        }
    }

    public errordomain ArgumentException
    {
        Default
    }
}
