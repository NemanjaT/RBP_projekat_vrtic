using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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

namespace VrticApp.PRIV
{
    /// <summary>
    /// Interaction logic for Receipt.xaml
    /// </summary>
    public partial class Receipt : Window
    {
        SqlConnection conn;
        public Receipt(SqlConnection conn)
        {
            InitializeComponent();
        }

        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {
            int yes_no = 99;
            if (check())
            {
                if (rbtnNo.IsChecked == true) yes_no = 99;
                else yes_no = 1;
                using (SqlCommand command = new SqlCommand("SP_DODAJ_RAČUN", conn))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@ukupan_racun", Double.Parse(txtTotal.Text));
                    command.Parameters.AddWithValue("@staratelj_id", txtTeacherID.Text);
                    command.Parameters.AddWithValue("@datum_otplate", datePicker.SelectedDate);
                    command.Parameters.AddWithValue("@racun_otplacen", yes_no);
                    command.Parameters.AddWithValue("@dodatne_informacije", txtInfo.Text);
                    try
                    {
                        command.ExecuteNonQuery();
                        MessageBox.Show("Uspešno dodato u bazu");
                    }
                    catch (Exception exp)
                    {
                        MessageBox.Show(exp.ToString());
                        MessageBox.Show("Greska pri dodavanju! Proverite sve informacija");
                    }
                }
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private bool check()
        {
            if ( txtTeacherID.Text.Equals("") || txtTotal.Text.Equals("") || datePicker.SelectedDate == null)
                return false;
            return true;
        }
    }
}
