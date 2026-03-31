"use client";

import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { HeartPulse, Calendar, Users, Building, Mail, Phone, ArrowLeft, Loader2, CheckCircle2 } from "lucide-react";
import Link from "next/link";
import { useState } from "react";
import { submitHealthCampRequest } from "@/lib/actions/db-sync";

export default function RequestCampPage() {
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isSuccess, setIsSuccess] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function onSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const formData = new FormData(event.currentTarget);
    const result = await submitHealthCampRequest(formData);

    if (result.success) {
      setIsSuccess(true);
    } else {
      setError(result.message);
    }
    setIsSubmitting(false);
  }

  if (isSuccess) {
    return (
      <div className="min-h-screen bg-slate-50 flex flex-col justify-center items-center py-12 px-4 sm:px-6 lg:px-8">
        <div className="max-w-md w-full text-center space-y-6">
          <CheckCircle2 className="mx-auto h-16 w-16 text-green-500" />
          <h2 className="text-3xl font-extrabold text-slate-900">Request Received!</h2>
          <p className="text-slate-600">Thank you for submitting your request. Our administrative team will review it and get back to your Point of Contact shortly.</p>
          <Link href="/">
            <Button className="mt-4 bg-emerald-600 hover:bg-emerald-700">Return Home</Button>
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col justify-center py-12 px-4 sm:px-6 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-md mb-8">
        <Link href="/" className="inline-flex items-center text-sm font-medium text-slate-500 hover:text-slate-700 transition-colors mb-6">
          <ArrowLeft className="mr-2 h-4 w-4" /> Back to Home
        </Link>
        <div className="flex justify-center mb-4">
          <div className="p-3 bg-emerald-100 rounded-2xl">
            <HeartPulse className="h-10 w-10 text-emerald-600" />
          </div>
        </div>
        <h2 className="text-center text-3xl font-extrabold text-slate-900 tracking-tight">
          Request a Health Camp
        </h2>
        <p className="mt-2 text-center text-sm text-slate-600 max-w">
          Fill out the details below to request a medical team visit for your school.
        </p>
      </div>

      <div className="sm:mx-auto sm:w-full sm:max-w-[32rem]">
        <Card className="border-t-4 border-t-emerald-600 shadow-xl shadow-emerald-900/5">
          <CardHeader>
            <CardTitle>School Information</CardTitle>
            <CardDescription>Tell us about your institution and requirements</CardDescription>
          </CardHeader>
          <CardContent>
            {error && <div className="p-3 mb-4 text-sm text-red-700 bg-red-50 rounded-lg">{error}</div>}
            <form onSubmit={onSubmit} className="space-y-6">
              <div className="space-y-2">
                <Label htmlFor="schoolName" className="font-semibold text-slate-700">School Name</Label>
                <div className="relative">
                  <Building className="absolute left-3 top-3 h-4 w-4 text-slate-400" />
                  <Input id="schoolName" name="schoolName" className="pl-10 h-11 bg-slate-50 border-slate-200" placeholder="e.g. Pathfinder Global School" required />
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div className="space-y-2">
                  <Label htmlFor="date" className="font-semibold text-slate-700">Tentative Date</Label>
                  <div className="relative">
                    <Calendar className="absolute left-3 top-3 h-4 w-4 text-slate-400" />
                    <Input id="date" name="date" type="date" className="pl-10 h-11 bg-slate-50 border-slate-200" required />
                  </div>
                </div>
                <div className="space-y-2">
                  <Label htmlFor="students" className="font-semibold text-slate-700">Estimated Students</Label>
                  <div className="relative">
                    <Users className="absolute left-3 top-3 h-4 w-4 text-slate-400" />
                    <Input id="students" name="students" type="number" min="10" className="pl-10 h-11 bg-slate-50 border-slate-200" placeholder="e.g. 500" required />
                  </div>
                </div>
              </div>

              <div className="border-t pt-6 mt-6">
                <h3 className="text-sm font-semibold text-slate-900 mb-4 uppercase tracking-wide">Point of Contact</h3>
                <div className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="pocName">Full Name</Label>
                    <Input id="pocName" name="pocName" className="h-11 bg-slate-50 border-slate-200" placeholder="e.g. Dinesh Kumar" required />
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="email">Email Address</Label>
                      <div className="relative">
                        <Mail className="absolute left-3 top-3 h-4 w-4 text-slate-400" />
                        <Input id="email" name="email" type="email" className="pl-10 h-11 bg-slate-50 border-slate-200" placeholder="pathfinder@gmail.com" required />
                      </div>
                    </div>
                    <div className="space-y-2">
                      <Label htmlFor="phone">Phone Number</Label>
                      <div className="relative">
                        <Phone className="absolute left-3 top-3 h-4 w-4 text-slate-400" />
                        <Input id="phone" name="phone" type="tel" className="pl-10 h-11 bg-slate-50 border-slate-200" placeholder="+91 98765XXXXX" required />
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div className="pt-4">
                <Button type="submit" disabled={isSubmitting} className="w-full h-12 text-base font-semibold bg-emerald-600 hover:bg-emerald-700 shadow-md transition-all hover:shadow-lg">
                  {isSubmitting ? <><Loader2 className="mr-2 h-4 w-4 animate-spin" /> Submitting...</> : "Submit Request"}
                </Button>
              </div>
            </form>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
