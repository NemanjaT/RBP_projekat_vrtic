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
using System.Windows.Navigation;
using System.Windows.Shapes;
using VrticApp.PRIV;

namespace VrticApp
{
    /// <summary>
    /// Interaction logic for LoginWindow.xaml
    /// </summary>
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();
        }

        private void btnLogIn_Click(object sender, RoutedEventArgs e)
        {
            SqlConnectionStringBuilder connectionString = new SqlConnectionStringBuilder();
            connectionString.UserID = txtName.Text;
            connectionString.Password = txtPassword.Password;
            connectionString.DataSource = "localhost";
            connectionString.InitialCatalog = "VRTIC";
            connectionString.IntegratedSecurity = true;
            SqlConnection conn = new SqlConnection(connectionString.ToString());
            try
            {
                conn.Open();                
            }
            catch (Exception except) { MessageBox.Show(except.ToString()); }
            
            MessageBox.Show("Uspešno povezivanje sa bazom!");
            switch (txtName.Text)
            {
                case "DB_KORISNIK": UserWindow usr = new UserWindow(conn); usr.Show(); this.Close(); break;
               // case "DB_ADMIN": AdminWindow adm = new AdminWindow(conn); adm.Show(); this.Close(); break;
                case "DB_PRIV": PrivWindow priv = new PrivWindow(conn); priv.Show(); this.Close(); break;
            }
         
            

        }
        }
}
