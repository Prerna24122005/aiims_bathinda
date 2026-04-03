"use server";

import { prisma } from "@/lib/db/prisma";
import bcryptjs from "bcryptjs";
import crypto from "crypto";
import { sendPasswordResetOtpEmail } from "@/lib/email";

// Generate a 6-digit OTP
function generateOtp(): string {
    return crypto.randomInt(100000, 999999).toString();
}

// Step 1: Send OTP to email
export async function sendPasswordResetOtp(email: string) {
    try {
        // Check if user exists and is active
        const user = await prisma.user.findFirst({
            where: { email, isActive: true }
        });
        if (!user) {
            return { success: false, error: "No active account found with this email." };
        }

        // Invalidate any existing unused OTPs for this email
        await prisma.passwordResetOtp.updateMany({
            where: { email, used: false },
            data: { used: true }
        });

        // Generate new OTP with 10-minute expiry
        const otp = generateOtp();
        const expiresAt = new Date(Date.now() + 10 * 60 * 1000);

        await prisma.passwordResetOtp.create({
            data: { email, otp, expiresAt }
        });

        // Send OTP email
        await sendPasswordResetOtpEmail(email, user.fullName, otp);

        return { success: true };
    } catch (error) {
        console.error("Failed to send OTP:", error);
        return { success: false, error: "Failed to send OTP. Please try again." };
    }
}

// Step 2: Verify OTP
export async function verifyPasswordResetOtp(email: string, otp: string) {
    try {
        const record = await prisma.passwordResetOtp.findFirst({
            where: {
                email,
                otp,
                used: false,
                expiresAt: { gt: new Date() }
            },
            orderBy: { createdAt: "desc" }
        });

        if (!record) {
            return { success: false, error: "Invalid or expired OTP." };
        }

        return { success: true };
    } catch (error) {
        console.error("Failed to verify OTP:", error);
        return { success: false, error: "Verification failed. Please try again." };
    }
}

// Step 3: Reset password (after OTP verification)
export async function resetPasswordWithOtp(email: string, otp: string, newPassword: string) {
    try {
        if (newPassword.length < 6) {
            return { success: false, error: "Password must be at least 6 characters." };
        }

        // Re-verify OTP
        const record = await prisma.passwordResetOtp.findFirst({
            where: {
                email,
                otp,
                used: false,
                expiresAt: { gt: new Date() }
            },
            orderBy: { createdAt: "desc" }
        });

        if (!record) {
            return { success: false, error: "Invalid or expired OTP. Please request a new one." };
        }

        // Mark OTP as used
        await prisma.passwordResetOtp.update({
            where: { id: record.id },
            data: { used: true }
        });

        // Update password
        const passwordHash = await bcryptjs.hash(newPassword, 10);
        await prisma.user.update({
            where: { email },
            data: { passwordHash }
        });

        return { success: true };
    } catch (error) {
        console.error("Failed to reset password:", error);
        return { success: false, error: "Failed to reset password. Please try again." };
    }
}
