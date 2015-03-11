namespace CelticEgyptianRatscrewKata.GameSetup
{
    public interface IShuffler : Object
    {
        public abstract Cards Shuffle(Cards deck);
    }
}
