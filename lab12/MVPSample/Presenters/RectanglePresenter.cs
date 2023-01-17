using MVPSample.Views;
using MVPSample.Models;

namespace MVPSample.Presenters
{
    public class RectanglePresenter
    {
        IRectangle rectangleView;
        public RectanglePresenter(IRectangle view)
        {
            rectangleView = view;
        }
        public void CalculateArea()
        {
            Rectangle1 rectangle = new Rectangle1();
            rectangle.Length = double.Parse(rectangleView.LengthText);
            rectangle.Breadth = double.Parse(rectangleView.BreadthText);
            rectangleView.AreaText1 = rectangle.CalculateArea().ToString();
            rectangleView.AreaText2 = rectangle.Obwod().ToString();
        }

        

    }
}
