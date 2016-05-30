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

namespace VrticApp
{
    /// <summary>
    /// Interaction logic for AddChild.xaml
    /// </summary>
    public partial class AddChild : Window
    {
        SqlConnection conn;
        public AddChild(SqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            if (checkChild())
            {
                using (SqlCommand command= new SqlCommand("SP_DODAJ_DETE", conn))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@ime", txtName.Text);
                    command.Parameters.AddWithValue("@prezime", txtLastName.Text);
                    command.Parameters.AddWithValue("@datum_rodjenja", datePicker.SelectedDate);
                    command.Parameters.AddWithValue("@grupa_id", int.Parse(txtGroupId.Text));
                    command.Parameters.AddWithValue("@dodatne_informacije", txtInfo.Text);
                    try
                    {
                        command.ExecuteNonQuery();
                        MessageBox.Show("Uspešno dodato u bazu");
                    }catch(Exception exp) {
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

        private void btnAddGroup_Click(object sender, RoutedEventArgs e)
        {
            if (checkGroup())
            {
                using (SqlCommand command = new SqlCommand("SP_DODAJ_GRUPU", conn))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@ime_grupe", txtGroupName.Text);
                    command.Parameters.AddWithValue("@sprat", int.Parse(txtGroupFloor.Text));
                    command.Parameters.AddWithValue("@vaspitaci",txtTeachers.Text);
                    command.Parameters.AddWithValue("@cena", txtGroupPrice.Text);
                    try
                    {
                        command.ExecuteNonQuery();
                        MessageBox.Show("Uspešno dodato u bazu");
                    }
                    catch (Exception exp) {
                        MessageBox.Show(exp.ToString()); 
                        MessageBox.Show("Greška pri dodavanju!Proverite podatke!");

                    }
                }
            }
            else MessageBox.Show("Morate da popunite sva polja!");
        }
        private bool checkChild()
        {
            if (txtName.Text.Equals("") || txtGroupId.Text.Equals("") || txtLastName.Text.Equals("") || datePicker.SelectedDate == null)
                return false;
            return true;
        }
        private bool checkGroup()
        {
            if (txtGroupFloor.Text.Equals("") || txtGroupName.Text.Equals("") || txtGroupPrice.Text.Equals(""))
                return false;
            return true;
        }

    }
}
