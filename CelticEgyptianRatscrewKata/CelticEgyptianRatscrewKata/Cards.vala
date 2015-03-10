using Gee;

namespace CelticEgyptianRatscrewKata
{
    public class Cards : Object, Iterable<Card>
    {
        private Gee.List<Card> m_Cards;

        public Cards(Iterable<Card> cards)
        {
            m_Cards = new LinkedList<Card>(cards);
        }

        public void AddToTop(Card card)
        {
            m_Cards.Insert(0, card);
        }

        public void AddToBottom(Card card)
        {
            m_Cards.Insert(m_Cards.Count, card);
        }

        public Card Pop()
        {
            var first = m_Cards.First();
            m_Cards.RemoveAt(0);
            return first;
        }

        public Card CardAt(int i)
        {
            return m_Cards.ElementAt(i);
        }

        public void RemoveCardAt(int i)
        {
            m_Cards.RemoveAt(i);
        }

        public bool HasCards
        {
            get { return m_Cards.Count > 0; }
        }

        public Iterator<Card> iterator()
        {
            return m_Cards.iterator();
        }

        public static Cards Empty()
        {
            return With();
        }

        public static Cards WithCards(Cards cards)
        {
            return With(cards.m_Cards.to_array());
        }

        public static Cards With(Card[] cards)
        {
            return new Cards(cards);
        }

        public override string ToString()
        {
            var output = "";

            foreach (var card in m_Cards)
            {
                if (!output.Equals("")) output += ", ";
                output += card;
            }

            return output;
        }
    }
}
