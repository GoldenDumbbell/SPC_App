using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace SpS_Foremployee
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }
        SqlConnection conn = new SqlConnection(@"Server=tcp:smartpackingsystem.database.windows.net,1433;Initial Catalog=SPSDB;Persist Security Info=False;User ID=adminsps;Password=Sps@12345;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30");


        private void Login_Load(object sender, EventArgs e)
        {

        }

        private void btn_login_Click(object sender, EventArgs e)
        {
            String email, pass;
            email = tb_email.Text;
            pass = tb_password.Text;

            try
            {
                String querry = "SELECT * FROM tb_Employee WHERE email = '" + tb_email.Text + "' AND password = '" + tb_password.Text + "'";
                SqlDataAdapter sda = new SqlDataAdapter(querry, conn);

                DataTable dtable = new DataTable();
                sda.Fill(dtable);
                if (dtable.Rows.Count > 0)
                {
                    email = tb_email.Text;
                    pass = tb_password.Text;

                    home home = new home();
                    home.Show();
                    this.Hide();

                }
                else
                {
                    MessageBox.Show("invalid login detail", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    tb_email.Clear();
                    tb_password.Clear();
                    tb_email.Focus();
                }

            }
            catch
            {
                MessageBox.Show("Invalid login");
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
