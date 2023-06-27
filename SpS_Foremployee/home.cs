using AForge.Video;
using AForge.Video.DirectShow;
using ZXing;
using ZXing.Common;
using ZXing.QrCode;
using ZXing.Datamatrix;
using ZXing.Maxicode;
using System.Windows.Forms;
using System.Drawing;
using System.Drawing.Imaging;
using Newtonsoft.Json;

namespace SpS_Foremployee
{
    public partial class home : Form
    {

        private FilterInfoCollection cameras;
        private VideoCaptureDevice cam;

        public home()
        {
            InitializeComponent();
            cameras = new FilterInfoCollection(FilterCategory.VideoInputDevice);
            foreach (FilterInfo info in cameras)
            {
                comboBox1.Items.Add(info.Name);
            }
            comboBox1.SelectedIndex = 0;
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (cam != null && cam.IsRunning)
            {
                cam.Stop();
            }
            cam = new VideoCaptureDevice(cameras[comboBox1.SelectedIndex].MonikerString);
            cam.NewFrame += Cam_NewFrame;
            cam.Start();
        }
        private void Cam_NewFrame(object sender, NewFrameEventArgs eventArgs)
        {
            Bitmap bitmap = (Bitmap)eventArgs.Frame.Clone();

            Result result = ReadQRCode(bitmap);

            if (result != null)
            {
                // Xử lý kết quả quét mã QR
                string json = result.Text;
            }
            pictureBox1.Image = bitmap;

        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (cam != null && cam.IsRunning)
            {
                cam.Stop();

            }
        }
        protected override void OnClosed(EventArgs e)
        {
            base.OnClosed(e);
            if (cam != null && cam.IsRunning)
            {
                cam.Stop();

            }
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
        private Result ReadQRCode(Bitmap bitmap)
        {
            try
            {
                MemoryStream memoryStream = new MemoryStream();
                bitmap.Save(memoryStream, ImageFormat.Bmp);
                byte[] byteArray = memoryStream.GetBuffer();
                ZXing.LuminanceSource source = new RGBLuminanceSource(byteArray, bitmap.Width, bitmap.Height);
                var binarizer = new HybridBinarizer(source);
                var binBitmap = new BinaryBitmap(binarizer);
                QRCodeReader qrCodeReader = new QRCodeReader();
                Result str = qrCodeReader.decode(binBitmap);
                return str;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi nếu có
                Console.WriteLine("Lỗi quét mã QR: " + ex.Message);
                return null;
            }

        }

        private void ProcessJsonData(string json)
        {
            try
            {
                dynamic jsonData = JsonConvert.DeserializeObject(json);
                string carPlate = jsonData.carPlate;
                string datetime = jsonData.datetime;
                string username = jsonData.username;

                textBox2.Invoke(new Action(() => textBox2.Text = jsonData.carPlate));
                textBox5.Invoke(new Action(() => textBox5.Text = jsonData.datetime));
                textBox1.Invoke(new Action(() => textBox1.Text = jsonData.username));
            }
            catch (Exception ex) { }
        }
    }
}