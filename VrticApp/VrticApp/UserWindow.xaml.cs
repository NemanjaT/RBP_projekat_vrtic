using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.ComponentModel;
using System.Data;
using System.Threading;

namespace VrticApp
{
    /// <summary>
    /// Interaction logic for UserWindow.xaml
    /// </summary>
    public partial class UserWindow : Window
    {
        SqlConnection conn;
        SqlCommand command;
        SqlDataAdapter adapter;
        DataTable table;
        public UserWindow(SqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
            this.Closing += OnWindowClosing;
            ReadData("VW_DECA");
        }
        //on_clic eventovi za dugmiće
        private void btnDeca_Click(object sender, RoutedEventArgs e)
        {
            new Thread(()=>ReadData("VW_DECA")).Start();
        }
        private void btnGrupe_Click(object sender, RoutedEventArgs e)
        {
            new Thread(()=>ReadData("VW_GRUPE")).Start();
        }
        private void btnStaratelji_Click(object sender, RoutedEventArgs e)
        {
            new Thread(()=>ReadData("VW_STARATELJI")).Start();
        }
        private void btnStaratelji_Deca_Click(object sender, RoutedEventArgs e)
        {
            new Thread(()=>ReadData("VW_STARATELJI_DECA")).Start();
        }
        private void btnIncidenti_Click(object sender, RoutedEventArgs e)
        {
            new Thread(()=>ReadData("VW_INCIDENTI")).Start();
        }
        private void btnOstavljanja_Click(object sender, RoutedEventArgs e)
        {
            new Thread(()=>ReadData("VW_OSTAVLJANJA_DECE")).Start();
        }
        private void btnPreuzimanja_Click(object sender, RoutedEventArgs e)
        {
            new Thread(()=>ReadData("VW_PREUZIMANJA_DECE")).Start();
        }
        private void btnLogOut_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }


        //Metoda za čitanje podataka iz baze i stavljanje u listview
        private void ReadData(string Table)
        {
            GridView1.Columns.Clear();
            listView.ItemsSource = null;
            try
            {
                command = new SqlCommand("SELECT * FROM " + Table, conn);
                adapter = new SqlDataAdapter(command);
                table = new DataTable();
                adapter.Fill(table);
                foreach (DataColumn dc in table.Columns)
                {
                    GridViewColumn coll = new GridViewColumn();
                    coll.Header = dc.ToString();
                    coll.DisplayMemberBinding = new Binding(dc.ToString());
                    coll.Width = 100;
                    GridView1.Columns.Add(coll);
                }

                listView.ItemsSource = table.DefaultView;

            }
            catch (Exception exc) { MessageBox.Show(exc.ToString()); }
            command = null;
        }


        //closing event za window
        //Zatvaranje konekcije i otvaranje windowa Login
        public void OnWindowClosing(object sender, CancelEventArgs e)
        {
            try
            {
                conn.Close();
                command = null;
            }
            catch (Exception excp) { MessageBox.Show(excp.ToString()); }
            LoginWindow log = new LoginWindow();
            log.Show();
        }
    }
}
