"use client";

import { useState, useRef } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
    Mail, HeartPulse, ArrowLeft, Loader2, AlertCircle, CheckCircle2,
    Lock, Eye, EyeOff, ShieldCheck
} from "lucide-react";
import Link from "next/link";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { useRouter } from "next/navigation";
import {
    sendPasswordResetOtp,
    verifyPasswordResetOtp,
    resetPasswordWithOtp
} from "@/lib/actions/password-reset-actions";

type Step = "email" | "otp" | "newPassword" | "success";

export default function ForgotPasswordPage() {
    const router = useRouter();
    const [step, setStep] = useState<Step>("email");
    const [email, setEmail] = useState("");
    const [otp, setOtp] = useState("");
    const otpRefs = useRef<(HTMLInputElement | null)[]>([]);
    const [otpDigits, setOtpDigits] = useState<string[]>(["", "", "", "", "", ""]);

    function handleOtpChange(index: number, value: string) {
        // Handle paste of full OTP
        if (value.length > 1) {
            const digits = value.replace(/\D/g, "").slice(0, 6).split("");
            const newDigits = [...otpDigits];
            digits.forEach((d, i) => {
                if (index + i < 6) newDigits[index + i] = d;
            });
            setOtpDigits(newDigits);
            setOtp(newDigits.join(""));
            const nextIndex = Math.min(index + digits.length, 5);
            otpRefs.current[nextIndex]?.focus();
            return;
        }

        const digit = value.replace(/\D/g, "");
        const newDigits = [...otpDigits];
        newDigits[index] = digit;
        setOtpDigits(newDigits);
        setOtp(newDigits.join(""));

        if (digit && index < 5) {
            otpRefs.current[index + 1]?.focus();
        }
    }

    function handleOtpKeyDown(index: number, e: React.KeyboardEvent<HTMLInputElement>) {
        if (e.key === "Backspace" && !otpDigits[index] && index > 0) {
            otpRefs.current[index - 1]?.focus();
        }
    }
    const [newPassword, setNewPassword] = useState("");
    const [confirmPassword, setConfirmPassword] = useState("");
    const [showPassword, setShowPassword] = useState(false);
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState("");

    async function handleSendOtp(e: React.FormEvent) {
        e.preventDefault();
        setIsLoading(true);
        setError("");

        const res = await sendPasswordResetOtp(email);
        setIsLoading(false);

        if (res.success) {
            setStep("otp");
        } else {
            setError(res.error || "Failed to send OTP");
        }
    }

    async function handleVerifyOtp(e: React.FormEvent) {
        e.preventDefault();
        setIsLoading(true);
        setError("");

        const res = await verifyPasswordResetOtp(email, otp);
        setIsLoading(false);

        if (res.success) {
            setStep("newPassword");
        } else {
            setError(res.error || "Invalid OTP");
        }
    }

    async function handleResetPassword(e: React.FormEvent) {
        e.preventDefault();
        setError("");

        if (newPassword !== confirmPassword) {
            setError("Passwords do not match.");
            return;
        }
        if (newPassword.length < 6) {
            setError("Password must be at least 6 characters.");
            return;
        }

        setIsLoading(true);
        const res = await resetPasswordWithOtp(email, otp, newPassword);
        setIsLoading(false);

        if (res.success) {
            setStep("success");
        } else {
            setError(res.error || "Failed to reset password");
        }
    }

    return (
        <div className="min-h-screen bg-slate-50 flex flex-col justify-center py-12 px-4 sm:px-6 lg:px-8">
            <div className="sm:mx-auto sm:w-full sm:max-w-md mb-8 relative">
                <Link href="/login" className="absolute -top-12 left-0 inline-flex items-center text-sm font-medium text-slate-500 hover:text-slate-700 transition-colors">
                    <ArrowLeft className="mr-2 h-4 w-4" /> Back to Login
                </Link>
                <div className="flex justify-center mb-4">
                    <div className="p-3 bg-emerald-100 rounded-2xl shadow-sm">
                        <HeartPulse className="h-10 w-10 text-emerald-600" />
                    </div>
                </div>
                <h2 className="text-center text-3xl font-extrabold text-slate-900 tracking-tight">
                    Reset Password
                </h2>
                <p className="mt-2 text-center text-sm text-slate-600">
                    {step === "email" && "Enter your email to receive a verification code."}
                    {step === "otp" && "Enter the 6-digit code sent to your email."}
                    {step === "newPassword" && "Create a new secure password."}
                    {step === "success" && "Your password has been reset successfully."}
                </p>
            </div>

            <div className="sm:mx-auto sm:w-full sm:max-w-[28rem]">
                <Card className="border-t-4 border-t-emerald-600 shadow-xl shadow-emerald-900/5">
                    <CardHeader>
                        <CardTitle className="text-xl flex items-center gap-2">
                            {step === "email" && <><Mail className="h-5 w-5 text-emerald-600" /> Enter Email</>}
                            {step === "otp" && <><ShieldCheck className="h-5 w-5 text-emerald-600" /> Verify OTP</>}
                            {step === "newPassword" && <><Lock className="h-5 w-5 text-emerald-600" /> New Password</>}
                            {step === "success" && <><CheckCircle2 className="h-5 w-5 text-emerald-600" /> All Done!</>}
                        </CardTitle>
                    </CardHeader>
                    <CardContent>
                        {error && (
                            <Alert variant="destructive" className="mb-6 bg-red-50 border-red-200 text-red-800">
                                <AlertCircle className="h-4 w-4" />
                                <AlertDescription>{error}</AlertDescription>
                            </Alert>
                        )}

                        {/* Step 1: Email */}
                        {step === "email" && (
                            <form onSubmit={handleSendOtp} className="space-y-6">
                                <div className="space-y-2">
                                    <Label htmlFor="email" className="font-semibold text-slate-700">Email Address</Label>
                                    <div className="relative">
                                        <Mail className="absolute left-3 top-3 h-4 w-4 text-slate-400" />
                                        <Input
                                            id="email"
                                            type="email"
                                            value={email}
                                            onChange={(e) => setEmail(e.target.value)}
                                            className="pl-10 h-11 bg-slate-50 border-slate-200 focus-visible:ring-emerald-600"
                                            placeholder="your@email.com"
                                            required
                                        />
                                    </div>
                                </div>
                                <Button
                                    type="submit"
                                    disabled={isLoading}
                                    className="w-full h-12 text-base font-semibold bg-slate-900 hover:bg-slate-800 shadow-md disabled:opacity-100"
                                >
                                    {isLoading ? (
                                        <><Loader2 className="mr-2 h-4 w-4 animate-spin" /> Sending OTP...</>
                                    ) : (
                                        "Send Verification Code"
                                    )}
                                </Button>
                            </form>
                        )}

                        {/* Step 2: OTP */}
                        {step === "otp" && (
                            <form onSubmit={handleVerifyOtp} className="space-y-6">
                                <div className="space-y-4">
                                    <Label className="font-semibold text-slate-700">6-Digit OTP</Label>
                                    <div className="flex justify-center gap-3">
                                        {otpDigits.map((digit, i) => (
                                            <input
                                                key={i}
                                                ref={(el) => { otpRefs.current[i] = el; }}
                                                type="text"
                                                inputMode="numeric"
                                                maxLength={1}
                                                value={digit}
                                                onChange={(e) => handleOtpChange(i, e.target.value)}
                                                onKeyDown={(e) => handleOtpKeyDown(i, e)}
                                                onPaste={(e) => {
                                                    e.preventDefault();
                                                    const pasted = e.clipboardData.getData("text");
                                                    handleOtpChange(i, pasted);
                                                }}
                                                className="w-12 h-14 text-center text-xl font-bold rounded-lg border-2 border-slate-200 bg-slate-50 focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 focus:outline-none transition-all"
                                            />
                                        ))}
                                    </div>
                                    <p className="text-xs text-slate-500 text-center">
                                        Code sent to <span className="font-medium text-slate-700">{email}</span>. Expires in 10 minutes.
                                    </p>
                                </div>
                                <Button
                                    type="submit"
                                    disabled={isLoading || otp.length !== 6}
                                    className="w-full h-12 text-base font-semibold bg-slate-900 hover:bg-slate-800 shadow-md disabled:opacity-100"
                                >
                                    {isLoading ? (
                                        <><Loader2 className="mr-2 h-4 w-4 animate-spin" /> Verifying...</>
                                    ) : (
                                        "Verify Code"
                                    )}
                                </Button>
                                <button
                                    type="button"
                                    onClick={async () => {
                                        setIsLoading(true);
                                        setError("");
                                        await sendPasswordResetOtp(email);
                                        setIsLoading(false);
                                        setOtpDigits(["", "", "", "", "", ""]);
                                        setOtp("");
                                        otpRefs.current[0]?.focus();
                                    }}
                                    className="w-full text-sm text-emerald-600 hover:text-emerald-700 font-medium"
                                >
                                    Resend Code
                                </button>
                            </form>
                        )}

                        {/* Step 3: New Password */}
                        {step === "newPassword" && (
                            <form onSubmit={handleResetPassword} className="space-y-6">
                                <div className="space-y-2">
                                    <Label htmlFor="newPassword" className="font-semibold text-slate-700">New Password</Label>
                                    <div className="relative">
                                        <Lock className="absolute left-3 top-3 h-4 w-4 text-slate-400" />
                                        <Input
                                            id="newPassword"
                                            type={showPassword ? "text" : "password"}
                                            value={newPassword}
                                            onChange={(e) => setNewPassword(e.target.value)}
                                            className="pl-10 pr-10 h-11 bg-slate-50 border-slate-200 focus-visible:ring-emerald-600"
                                            placeholder="••••••••"
                                            required
                                            minLength={6}
                                        />
                                        <button
                                            type="button"
                                            onClick={() => setShowPassword(!showPassword)}
                                            className="absolute right-3 top-3 text-slate-400 hover:text-slate-600"
                                        >
                                            {showPassword ? <EyeOff className="h-5 w-5" /> : <Eye className="h-5 w-5" />}
                                        </button>
                                    </div>
                                </div>
                                <div className="space-y-2">
                                    <Label htmlFor="confirmPassword" className="font-semibold text-slate-700">Confirm Password</Label>
                                    <div className="relative">
                                        <Lock className="absolute left-3 top-3 h-4 w-4 text-slate-400" />
                                        <Input
                                            id="confirmPassword"
                                            type="password"
                                            value={confirmPassword}
                                            onChange={(e) => setConfirmPassword(e.target.value)}
                                            className="pl-10 h-11 bg-slate-50 border-slate-200 focus-visible:ring-emerald-600"
                                            placeholder="••••••••"
                                            required
                                            minLength={6}
                                        />
                                    </div>
                                    <p className="text-xs text-slate-400">Minimum 6 characters.</p>
                                </div>
                                <Button
                                    type="submit"
                                    disabled={isLoading}
                                    className="w-full h-12 text-base font-semibold bg-slate-900 hover:bg-slate-800 shadow-md disabled:opacity-100"
                                >
                                    {isLoading ? (
                                        <><Loader2 className="mr-2 h-4 w-4 animate-spin" /> Resetting...</>
                                    ) : (
                                        "Reset Password"
                                    )}
                                </Button>
                            </form>
                        )}

                        {/* Step 4: Success */}
                        {step === "success" && (
                            <div className="text-center space-y-6 py-4">
                                <div className="flex justify-center">
                                    <div className="p-4 bg-emerald-100 rounded-full">
                                        <CheckCircle2 className="h-12 w-12 text-emerald-600" />
                                    </div>
                                </div>
                                <div>
                                    <p className="text-slate-700 font-medium">Your password has been reset successfully.</p>
                                    <p className="text-sm text-slate-500 mt-1">You can now sign in with your new password.</p>
                                </div>
                                <Button
                                    onClick={() => router.push("/login")}
                                    className="w-full h-12 text-base font-semibold bg-slate-900 hover:bg-slate-800 shadow-md"
                                >
                                    Back to Login
                                </Button>
                            </div>
                        )}
                    </CardContent>
                </Card>
            </div>
        </div>
    );
}
