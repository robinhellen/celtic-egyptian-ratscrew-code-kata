namespace CelticEgyptianRatscrewKata.Game
{
    /// <summary>
    /// Represents a player of the game.
    /// </summary>
    public interface IPlayer
    {
        /// <summary>
        /// The name of the player, <em>must</em> be unique.
        /// </summary>
        string Name { get; } 
    }
}