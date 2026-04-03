import nodemailer from 'nodemailer';

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

export const sendRequestReceivedEmail = async (to: string, pocName: string, schoolName: string, date: Date) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject: 'Health Camp Request Received - HealthCampPro',
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; color: #333;">
        <h2>Hello ${pocName},</h2>
        <p>Thank you for submitting a health camp request for <strong>${schoolName}</strong> on <strong>${new Date(date).toLocaleDateString()}</strong>.</p>
        <p>Your request has been successfully received and is currently marked as <strong>PENDING</strong>. Our administrative team will review it shortly. You will receive another email once the request is accepted or if further information is required.</p>
        <p>Best regards,<br/>The HealthCampPro Team</p>
      </div>
    `,
  };

  try {
    // If credentials aren't set, just log to console to prevent crashes
    if (!process.env.EMAIL_USER || !process.env.EMAIL_APP_PASSWORD) {
      console.log("------------------------");
      console.log("[MOCK EMAIL: REQUEST RECEIVED] To:", to);
      console.log("Subject:", mailOptions.subject);
      console.log("------------------------");
      return true;
    }
    await transporter.sendMail(mailOptions);
    return true;
  } catch (error) {
    console.error("Error sending email: ", error);
    return false;
  }
};

export const sendRequestAcceptedEmail = async (to: string, pocName: string, schoolName: string, date: Date, password: string) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject: 'Health Camp Request Accepted! - HealthCampPro',
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; color: #333;">
        <h2>Hello ${pocName},</h2>
        <p>Great news! Your health camp request for <strong>${schoolName}</strong> on <strong>${new Date(date).toLocaleDateString()}</strong> has been <strong>ACCEPTED</strong>.</p>
        <p>Our medical staff has been assigned, and we will be arriving on the scheduled date. If you have any questions or need to make adjustments, please contact our support team.</p>
        <p>Your login credentials for the portal are:</p>
        <ul>
          <li><strong>Email:</strong> ${to}</li>
          <li><strong>Temporary Password:</strong> ${password}</li>
        </ul>
        <p>Please change your password after your first login for security purposes.</p>
        <p>We look forward to a successful health camp!</p>
        <p>Best regards,<br/>The HealthCampPro Team</p>
      </div>
    `,
  };

  try {
    if (!process.env.EMAIL_USER || !process.env.EMAIL_APP_PASSWORD) {
      console.log("------------------------");
      console.log("[MOCK EMAIL: REQUEST ACCEPTED] To:", to);
      console.log("Subject:", mailOptions.subject);
      console.log("------------------------");
      return true;
    }
    await transporter.sendMail(mailOptions);
    return true;
  } catch (error) {
    console.error("Error sending email: ", error);
    return false;
  }
};

export const sendRequestRejectedEmail = async (to: string, pocName: string, schoolName: string, reason: string) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject: 'Update on Health Camp Request - HealthCampPro',
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; color: #333;">
        <h2>Hello ${pocName},</h2>
        <p>We regret to inform you that your health camp request for <strong>${schoolName}</strong> cannot be accommodated at this time.</p>
        <p><strong>Reason provided:</strong> ${reason}</p>
        <p>We apologize for any inconvenience this may cause. We encourage you to submit a new request later or contact our administrative team for alternative dates.</p>
        <p>Best regards,<br/>The HealthCampPro Team</p>
      </div>
    `,
  };

  try {
    if (!process.env.EMAIL_USER || !process.env.EMAIL_APP_PASSWORD) {
      console.log("------------------------");
      console.log("[MOCK EMAIL: REQUEST REJECTED] To:", to);
      console.log("Subject:", mailOptions.subject);
      console.log("Reason:", reason);
      console.log("------------------------");
      return true;
    }
    await transporter.sendMail(mailOptions);
    return true;
  } catch (error) {
    console.error("Error sending email: ", error);
    return false;
  }
};

export const sendEventCanceledEmail = async (to: string, pocName: string, schoolName: string, date: Date) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject: 'Health Camp Event Cancelled - HealthCampPro',
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; color: #333;">
        <h2>Hello ${pocName},</h2>
        <p>We regret to inform you that your scheduled health camp for <strong>${schoolName}</strong> on <strong>${new Date(date).toLocaleDateString()}</strong> has been <strong>CANCELLED</strong>.</p>
        <p>If you have any questions or would like to reschedule, please contact our administrative team.</p>
        <p>We apologize for any inconvenience this may cause.</p>
        <p>Best regards,<br/>The HealthCampPro Team</p>
      </div>
    `,
  };

  try {
    if (!process.env.EMAIL_USER || !process.env.EMAIL_APP_PASSWORD) {
      console.log("------------------------");
      console.log("[MOCK EMAIL: EVENT CANCELLED] To:", to);
      console.log("Subject:", mailOptions.subject);
      console.log("------------------------");
      return true;
    }
    await transporter.sendMail(mailOptions);
    return true;
  } catch (error) {
    console.error("Error sending email: ", error);
    return false;
  }
};

export const sendManualEventCreatedEmail = async (to: string, pocName: string, schoolName: string, date: Date, password: string) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject: 'New Health Camp Event Scheduled - HealthCampPro',
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; color: #333;">
        <h2>Hello ${pocName},</h2>
        <p>A new health camp event has been scheduled for <strong>${schoolName}</strong> on <strong>${new Date(date).toLocaleDateString()}</strong>.</p>
        <p>An account has been provisioned for you to manage student records and track progress. You can log in to the portal using your email address.</p>
        <p><strong>Initial Login Credentials:</strong></p>
        <ul>
          <li><strong>Email:</strong> ${to}</li>
          <li><strong>Temporary Password:</strong> ${password}</li>
        </ul>
        <p>Please change your password after your first login for security purposes.</p>
        <p>We look forward to a successful health camp!</p>
        <p>Best regards,<br/>The HealthCampPro Team</p>
      </div>
    `,
  };

  try {
    if (!process.env.EMAIL_USER || !process.env.EMAIL_APP_PASSWORD) {
      console.log("------------------------");
      console.log("[MOCK EMAIL: MANUAL EVENT CREATED] To:", to);
      console.log("Subject:", mailOptions.subject);
      console.log("------------------------");
      return true;
    }
    await transporter.sendMail(mailOptions);
    return true;
  } catch (error) {
    console.error("Error sending email: ", error);
    return false;
  }
};

export const sendStaffAccountCreatedEmail = async (to: string, fullName: string, password: string) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject: 'Your HealthCampPro Account Has Been Created',
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; color: #333;">
        <h2>Hello ${fullName},</h2>
        <p>An account has been created for you on <strong>HealthCampPro</strong>. You can now log in to the portal to access your assigned health camp events.</p>
        <p><strong>Your Login Credentials:</strong></p>
        <ul>
          <li><strong>Email:</strong> ${to}</li>
          <li><strong>Temporary Password:</strong> ${password}</li>
        </ul>
        <p>Please change your password after your first login for security purposes.</p>
        <p>Best regards,<br/>The HealthCampPro Team</p>
      </div>
    `,
  };

  try {
    if (!process.env.EMAIL_USER || !process.env.EMAIL_APP_PASSWORD) {
      console.log("------------------------");
      console.log("[MOCK EMAIL: STAFF ACCOUNT CREATED] To:", to);
      console.log("Subject:", mailOptions.subject);
      console.log("Password:", password);
      console.log("------------------------");
      return true;
    }
    await transporter.sendMail(mailOptions);
    return true;
  } catch (error) {
    console.error("Error sending email: ", error);
    return false;
  }
};

export const sendPasswordResetOtpEmail = async (to: string, fullName: string, otp: string) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject: 'Password Reset OTP - HealthCampPro',
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; color: #333;">
        <h2>Hello ${fullName},</h2>
        <p>You have requested to reset your password. Use the following OTP to proceed:</p>
        <div style="text-align: center; margin: 30px 0;">
          <span style="font-size: 32px; font-weight: bold; letter-spacing: 8px; background: #f1f5f9; padding: 16px 32px; border-radius: 12px; color: #059669;">${otp}</span>
        </div>
        <p>This OTP is valid for <strong>10 minutes</strong>. If you did not request a password reset, please ignore this email.</p>
        <p>Best regards,<br/>The HealthCampPro Team</p>
      </div>
    `,
  };

  try {
    if (!process.env.EMAIL_USER || !process.env.EMAIL_APP_PASSWORD) {
      console.log("------------------------");
      console.log("[MOCK EMAIL: PASSWORD RESET OTP] To:", to);
      console.log("OTP:", otp);
      console.log("------------------------");
      return true;
    }
    await transporter.sendMail(mailOptions);
    return true;
  } catch (error) {
    console.error("Error sending OTP email: ", error);
    return false;
  }
};