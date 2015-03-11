using Gee;

namespace CelticEgyptianRatscrewKata.SnapRules
{
    public class SnapValidator : Object, ISnapValidator
    {
        private Iterable<IRule> m_Rules;

        public SnapValidator(Iterable<IRule> rules)
        {
            m_Rules = rules;
        }

        public bool CanSnap(Cards stack)
        {
            return m_Rules.fold<bool>((rule, b) => b || rule.CanSnap(stack), false);
        }
    }
}
