namespace CelticEgyptianRatscrewKata.SnapRules
{
    public interface ISnapValidator : Object
    {
        public abstract bool CanSnap(Cards stack);
    }
}
