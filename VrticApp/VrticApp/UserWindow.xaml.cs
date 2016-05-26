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

namespace VrticApp
{
    /// <summary>
    /// Interaction logic for UserWindow.xaml
    /// </summary>
    public partial class UserWindow : Window
    {
        SqlDataReader reader;
        SqlConnection conn;
        SqlCommand command;
        public UserWindow(SqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
            reader = null;
            this.Closing += OnWindowClosing;
            ReadData("VW_DECA");
        }

        private void btnDeca_Click(object sender, RoutedEventArgs e)
        {
            ReadData("VW_DECA");
        }
        private void btnGrupe_Click(object sender, RoutedEventArgs e)
        {
            ReadData("VW_GRUPE");
        }
        private void btnStaratelji_Click(object sender, RoutedEventArgs e)
        {
            ReadData("VW_STARATELJI");
        }
        private void btnStaratelji_Deca_Click(object sender, RoutedEventArgs e)
        {
            ReadData("VW_STARATELJI_DECA");
        }
        private void btnIncidenti_Click(object sender, RoutedEventArgs e)
        {
            ReadData("VW_INCIDENTI");
        }
        private void btnOstavljanja_Click(object sender, RoutedEventArgs e)
        {
            ReadData("VW_OSTAVLJANJA_DECE");
        }
        private void btnPreuzimanja_Click(object sender, RoutedEventArgs e)
        {
            ReadData("VW_PREUZIMANJA_DECE");
        }
        private void btnLogOut_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ReadData(string Table)
        {
            GridView1.Columns.Clear();
            listView.ItemsSource = null;
            try
            {
                command = new SqlCommand("SELECT * FROM " + Table, conn);
                reader = command.ExecuteReader();
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    GridViewColumn coll = new GridViewColumn();
                    coll.Header = reader.GetName(i);
                    coll.DisplayMemberBinding = new Binding(reader.GetName(i));
                    coll.Width = 100;
                    GridView1.Columns.Add(coll);
                }
                reader.Close();

                SqlDataAdapter ad = new SqlDataAdapter(command);
                DataTable t = new DataTable();
                ad.Fill(t);
                listView.ItemsSource = t.DefaultView;

            }
            catch (Exception exc) { MessageBox.Show(exc.ToString()); }
            command = null;
        }

        public void OnWindowClosing(object sender, CancelEventArgs e)
        {
            try
            {
                conn.Close();
                reader.Close();
                command = null;
            }
            catch (Exception excp) { MessageBox.Show(excp.ToString()); }
            MainWindow log = new MainWindow();
            log.Show();
        }


    }
}
