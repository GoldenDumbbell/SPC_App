namespace SpS_Foremployee
{
    partial class Login
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            label3 = new Label();
            label2 = new Label();
            label1 = new Label();
            tb_password = new TextBox();
            tb_email = new TextBox();
            btn_login = new Button();
            SuspendLayout();
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(333, 65);
            label3.Name = "label3";
            label3.Size = new Size(253, 25);
            label3.TabIndex = 11;
            label3.Text = "Welcome to SPS for Employee";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(202, 235);
            label2.Name = "label2";
            label2.Size = new Size(87, 25);
            label2.TabIndex = 10;
            label2.Text = "Password";
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(202, 168);
            label1.Name = "label1";
            label1.Size = new Size(54, 25);
            label1.TabIndex = 9;
            label1.Text = "Email";
            // 
            // tb_password
            // 
            tb_password.Location = new Point(333, 229);
            tb_password.Name = "tb_password";
            tb_password.Size = new Size(265, 31);
            tb_password.TabIndex = 8;
            // 
            // tb_email
            // 
            tb_email.Location = new Point(333, 162);
            tb_email.Name = "tb_email";
            tb_email.Size = new Size(265, 31);
            tb_email.TabIndex = 7;
            // 
            // btn_login
            // 
            btn_login.Location = new Point(372, 313);
            btn_login.Name = "btn_login";
            btn_login.Size = new Size(172, 73);
            btn_login.TabIndex = 6;
            btn_login.Text = "Login";
            btn_login.UseVisualStyleBackColor = true;
            btn_login.Click += btn_login_Click;
            // 
            // Login
            // 
            AutoScaleDimensions = new SizeF(10F, 25F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(label3);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(tb_password);
            Controls.Add(tb_email);
            Controls.Add(btn_login);
            Name = "Login";
            Text = "Login";
            Load += Login_Load;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label label3;
        private Label label2;
        private Label label1;
        private TextBox tb_password;
        private TextBox tb_email;
        private Button btn_login;
    }
}