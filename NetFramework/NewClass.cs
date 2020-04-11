using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetFramework
{
    public class NewClass
    {

        public void TestConditions(int a)
        {
            if(a < 10)
            {
                Console.WriteLine($"{a} menor a 10");
            }
            else if (a >=10 && a <= 20)
            {
                Console.WriteLine($"{a} entre 10 y 20");
            }
            else
            {
                Console.WriteLine($"{a} mayor a 20");
            }
        }
    }
}
