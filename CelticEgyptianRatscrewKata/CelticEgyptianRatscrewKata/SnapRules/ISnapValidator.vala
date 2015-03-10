namespace CelticEgyptianRatscrewKata.SnapRules
{
    public interface ISnapValidator
    {
        public abstract bool CanSnap(Cards stack);
    }
}
