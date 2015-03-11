using Gee;

namespace CelticEgyptianRatscrewKata
{
    public class Cards : Object, Iterable<Card>, Traversable<Card>
    {
        private Gee.List<Card> m_Cards;

        public Cards(Iterable<Card> cards)
        {
            m_Cards = new LinkedList<Card>();
            foreach(var card in cards)
            {
                m_Cards.add(card);
            }
        }

        public void AddToTop(Card card)
        {
            m_Cards.insert(0, card);
        }

        public void AddToBottom(Card card)
        {
            m_Cards.insert(m_Cards.size, card);
        }

        public Card Pop()
        {
            var first = m_Cards.first();
            m_Cards.remove_at(0);
            return first;
        }

        public Card CardAt(int i)
        {
            return m_Cards[i];
        }

        public void RemoveCardAt(int i)
        {
            m_Cards.remove_at(i);
        }

        public bool HasCards
        {
            get { return !m_Cards.is_empty; }
        }

        public Iterator<Card> iterator()
        {
            return m_Cards.iterator();
        }

        public bool @foreach (ForallFunc<Card> f)
        {
            return m_Cards.foreach(f);
        }

        public static Cards Empty()
        {
            return With(new Card[] {});
        }

        public static Cards WithCards(Cards cards)
        {
            return With(cards.m_Cards.to_array());
        }

        public static Cards With(Card[] cards)
        {
            var c = new Cards(Gee.List.empty<Card>());
            c.m_Cards.add_all_array(cards);
        }

        public Iterable<Card> Reverse()
        {
            var list = new LinkedList<Card>();
            foreach(var card in m_Cards)
            {
                list.insert(0, card);
            }
            return list;
        }

        public string to_string()
        {
            var output = "";

            foreach (var card in m_Cards)
            {
                if (output != "")
                    output += ", ";
                output += card.to_string();
            }

            return output;
        }
    }
}
