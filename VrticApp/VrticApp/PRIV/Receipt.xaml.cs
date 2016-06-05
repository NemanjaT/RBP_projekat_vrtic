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
            this.conn = conn;
        }

        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {
            if (check())
            {
                using (SqlCommand command = new SqlCommand("SP_DODAJ_RACUN", conn))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@ukupni_racun", Double.Parse(txtTotal.Text));
                    command.Parameters.AddWithValue("@staratelj_id", txtTeacherID.Text);
                    command.Parameters.AddWithValue("@datum_otplate", datePicker.SelectedDate);
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
            else MessageBox.Show("Morate da popunite sva polja!");
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
