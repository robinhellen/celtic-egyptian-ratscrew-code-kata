namespace CelticEgyptianRatscrewKata
{
    public class Card
    {
        private Suit m_Suit;
        private Rank m_Rank;

        public Card(Suit suit, Rank rank)
        {
            m_Suit = suit;
            m_Rank = rank;
        }

        public Rank Rank { get { return m_Rank; } }

        public Suit Suit { get { return m_Suit; } }

        public string to_string()
        {
            return @"Card $m_Rank of $m_Suit";
        }

        public bool Equals(Card other)
        {
            return m_Suit == other.m_Suit && m_Rank == other.m_Rank;
        }
    }
}
