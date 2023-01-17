using MVPSample.Views;
using MVPSample.Models;
using MVPSample.Presenters;

namespace MVPSample
{
    public partial class Form1 : Form, IRectangle
    {
        public Form1()
        {
            InitializeComponent();
        }

        public string LengthText { get => txtLength.Text; set => txtLength.Text = value; }
        public string BreadthText { get => txtBreadth.Text; set => txtBreadth.Text = value; }
        public string AreaText1 { get => lblArea.Text; set =>  lblArea.Text = "Pole: " + value + " cm2"; }
        public string AreaText2 { get => obwod.Text; set => obwod.Text = "Obwod: " + value + " cm"; }







        private void button1_Click(object sender, EventArgs e)
        {
            RectanglePresenter presenter = new(this);
            presenter.CalculateArea();
        }
    }
}