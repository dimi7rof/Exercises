using System;
using System.Collections.Generic;
using System.Text;

namespace PlayersAndMonsters
{
   public class Wizard : Hero
    {
        public Wizard(string name, int level) : base(name, level)
        {

        }
    }
    public class DarkWizard : Wizard
    {
        public DarkWizard(string name, int level) : base(name, level)
        {

        }
    }
    public class SoulMaster : DarkWizard
    {
        public SoulMaster(string name, int level) : base(name, level)
        {

        }
    }
}
