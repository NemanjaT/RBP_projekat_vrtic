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
        private void btnLogOut_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ReadData(string Table)
        {
            listView.Items.Clear();
            try
            {
                string str = "";
                command = new SqlCommand("SELECT * FROM "+Table , conn);
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    foreach (var x in reader)
                        str += x.ToString() + '\t';
                    listView.Items.Add(str);
                }
            }
            catch (Exception exc) { MessageBox.Show(exc.ToString()); }
            reader.Close();
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
