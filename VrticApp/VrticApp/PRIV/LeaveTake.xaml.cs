﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Data.SqlClient;
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
    /// Interaction logic for LeaveTake.xaml
    /// </summary>
    public partial class LeaveTake : Window
    {
        SqlConnection conn;
        public LeaveTake(SqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
            rdoLeave.IsChecked = true;
        }

        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {
            string time = "@vreme_ostavljanja";
            string proc = "SP_DODAJ_OSTAVLJANJE_DETETA";
            if (check())
            {
                if (rdoTake.IsChecked == true) { time = "@vreme_preuzimanja"; proc = "SP_DODAJ_PREUZIMANJE_DETETA"; }

                using (SqlCommand command = new SqlCommand(proc, conn))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@staratelj_id", int.Parse(txtTeacherID.Text));
                    command.Parameters.AddWithValue("@dete_id", int.Parse(txtChildID.Text));
                    command.Parameters.AddWithValue(time, datePicker.SelectedDate);
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
            if (txtChildID.Text.Equals("") || txtTeacherID.Text.Equals("") || datePicker.SelectedDate == null)
                return false;
            return true;
        }
    }
}
