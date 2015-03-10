
namespace CelticEgyptianRatscrewKata.GameSetup
{
    public interface IDealer
    {
        public abstract List<Cards> Deal(int numberOfHands, Cards deck);
    }
}
