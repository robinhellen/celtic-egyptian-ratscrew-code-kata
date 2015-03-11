namespace CelticEgyptianRatscrewKata.SnapRules
{
    public class StandardSnapRule : Object, IRule
    {
        public bool CanSnap(Cards stack)
        {
            Rank? previous = null;
            foreach (var card in stack)
            {
                if (card.Rank == previous) return true;
                previous = card.Rank;
            }
            return false;
        }
    }
}
