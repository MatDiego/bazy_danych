using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVPSample.Models
{
    public class Rectangle1
    {
        public double Length { get; set; }
        public double Breadth { get; set; }
        public double CalculateArea()
        {
            return Length * Breadth;
        }

        public double Obwod()
        {
            return Length * 2 + Breadth * 2;
        }

    }
}
