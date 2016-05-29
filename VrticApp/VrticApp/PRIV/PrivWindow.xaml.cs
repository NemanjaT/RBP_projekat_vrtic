using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using VrticApp.PRIV;

namespace VrticApp
{
    /// <summary>
    /// Interaction logic for PrivWindow.xaml
    /// </summary>
    public partial class PrivWindow : Window
    {
        SqlConnection conn;
        SqlCommand command;
        SqlDataAdapter adapter;
        DataTable table;
        public PrivWindow(SqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }

        private void btnLogOut_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void btnFinansijske_Grupe_Click(object sender, RoutedEventArgs e)
        {
            ReadData("VW_FINANSIJSKE_GRUPE");
        }

        private void btnRacuni_Click(object sender, RoutedEventArgs e)
        {
            ReadData("VW_RACUNI");
        }

        private void btnUplate_Click(object sender, RoutedEventArgs e)
        {
            ReadData("VW_UPLATE");
        }
        private void btnAddChild_Click(object sender, RoutedEventArgs e)
        {
            AddChild add = new AddChild(conn);
            add.Show();
        }
        public void OnWindowClosing(object sender, CancelEventArgs e)
        {
            try
            {
                conn.Close();
                conn = null;
                command = null;
                table = null;
                adapter = null;
            }
            catch (Exception excp) { MessageBox.Show(excp.ToString()); }
            LoginWindow log = new LoginWindow();
            log.Show();
        }
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

        private void btnLeaveTake_Click(object sender, RoutedEventArgs e)
        {
            LeaveTake lt = new LeaveTake(conn);
            lt.Show();
        }

        private void btnReceipt_Click(object sender, RoutedEventArgs e)
        {
            Receipt rcp = new Receipt(conn);
        }
    }
}
