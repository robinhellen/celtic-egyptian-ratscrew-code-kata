namespace CelticEgyptianRatscrewKata.SnapRules
{
    public interface IRule : Object
    {
        public abstract bool CanSnap(Cards stack);
    }
}
