
namespace CelticEgyptianRatscrewKata.GameSetup
{
    public interface IDealer
    {
        List<Cards> Deal(int numberOfHands, Cards deck);
    }
}
