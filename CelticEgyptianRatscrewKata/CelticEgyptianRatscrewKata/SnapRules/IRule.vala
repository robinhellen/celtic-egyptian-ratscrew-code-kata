namespace CelticEgyptianRatscrewKata.SnapRules
{
    public interface IRule
    {
        public abstract bool CanSnap(Cards stack);
    }
}
