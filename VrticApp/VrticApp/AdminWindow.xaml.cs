using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Data;

namespace VrticApp
{
    /// <summary>
    /// Interaction logic for AdminWindow.xaml
    /// </summary>
    public partial class AdminWindow : Window
    {
        SqlConnection conn;
        public AdminWindow(SqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }

        private void btnExecute_Click(object sender, RoutedEventArgs e)
        {
            Grid.Columns.Clear();
            listView.ItemsSource = null;
            try
            {
                using (SqlCommand command = new SqlCommand(txtSQL.Text, conn))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        using (DataTable table = new DataTable())
                        {
                            adapter.Fill(table);
                            foreach (DataColumn dc in table.Columns)
                            {
                                GridViewColumn coll = new GridViewColumn();
                                coll.Header = dc.ToString();
                                coll.DisplayMemberBinding = new Binding(dc.ToString());
                                coll.Width = 100;
                                Grid.Columns.Add(coll);
                            }

                            listView.ItemsSource = table.DefaultView;
                        }
                    }
                }
            }catch(Exception exc)
            {
                MessageBox.Show(exc.ToString());
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            LoginWindow log = new LoginWindow();
            log.Show();
            this.Close();
        }
    }
}
