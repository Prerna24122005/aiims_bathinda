import nodemailer from 'nodemailer';
import dotenv from 'dotenv';
dotenv.config();

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_APP_PASSWORD,
  },
  tls: {
    rejectUnauthorized: false
  }
});

async function main() {
  console.log("Testing email with user:", process.env.EMAIL_USER);
  
  try {
    const info = await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: process.env.EMAIL_USER, // send to self
      subject: "Test Email from HealthCampPro",
      text: "If you are seeing this, the email configuration is working."
    });
    console.log("Email sent successfully: ", info.response);
  } catch (error) {
    console.error("Error sending email: ", error);
  }
}

main();
