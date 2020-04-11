using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Xsl;

namespace NetFramework
{
    class Program
    {
        static void Main(string[] args)
        {
            XslTransform myXslTransform;
            myXslTransform = new XslTransform();
            myXslTransform.Load(@"C:\Users\kokor\source\repos\Metrics\NetFramework\metrics.xslt");

            Console.Write("Hello world");
            myXslTransform.Transform(@"C:\Users\kokor\source\repos\Metrics\NetFramework\NetFramework.Metrics.xml", @"C:\Users\kokor\source\repos\Metrics\NetFramework\f\output.html");
            //for(int i=0; i< 100; i++)
            //{
            //    for (int j = 0; j < 100; j++)
            //    {
            //        Console.WriteLine($"{i}:{j}");
            //    }
            //}
        }

        public static void test()
        {
            Console.Write("Hello world");
            for (int i = 0; i < 100; i++)
            {
                for (int j = 0; j < 100; j++)
                {
                    Console.WriteLine($"{i}:{j}");
                }
            }
        }
    }
}
