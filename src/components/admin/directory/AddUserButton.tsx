"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { UserPlus, Loader2 } from "lucide-react";
import { addMedicalStaff } from "@/lib/actions/admin-actions";

export function AddUserButton() {
  const [isOpen, setIsOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const formData = new FormData(e.currentTarget);
    const fullName = formData.get("fullName") as string;
    const email = formData.get("email") as string;
    const password = formData.get("password") as string;
    const department = formData.get("department") as string | null;

    const res = await addMedicalStaff(fullName, email, password, department);

    if (res.success) {
      setIsOpen(false);
    } else {
      setError(res.error || "Failed to add user");
    }
    setIsSubmitting(false);
  };

  return (
    <>
      <Button variant="outline" className="bg-white border-slate-200 hover:bg-slate-50 text-slate-700" onClick={() => setIsOpen(true)}>
        <UserPlus className="mr-2 h-4 w-4" /> Add Medical Staff
      </Button>

      {isOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 px-4">
          <div className="bg-white rounded-lg p-6 max-w-md w-full shadow-xl">
            <h3 className="text-xl font-bold text-gray-900 mb-1">Add Medical Staff</h3>
            <p className="text-sm text-gray-500 mb-6">Create a new account for a doctor or nurse.</p>

            {error && <div className="p-3 mb-4 text-sm text-red-700 bg-red-50 rounded-lg">{error}</div>}

            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-1">
                <label className="text-sm font-medium text-slate-700">Full Name</label>
                <input required name="fullName" type="text" className="w-full p-2 border rounded-md" />
              </div>

              <div className="space-y-1">
                <label className="text-sm font-medium text-slate-700">Email Address</label>
                <input required name="email" type="email" className="w-full p-2 border rounded-md" />
              </div>

              <div className="space-y-1">
                <label className="text-sm font-medium text-slate-700">Temporary Password</label>
                <input required name="password" type="password" className="w-full p-2 border rounded-md" minLength={6} />
                <p className="text-xs text-slate-400 mt-1">Minimum 6 characters.</p>
              </div>

              <div className="space-y-1">
                <label className="text-sm font-medium text-slate-700">Department (Optional)</label>
                <select name="department" className="w-full p-2 border rounded-md bg-white" required>
                  <option value="COMMUNITY_MEDICINE">Community Medicine</option>
                  <option value="DENTAL">Dental</option>
                  <option value="OPHTHALMOLOGY">Ophthalmology</option>
                  <option value="DERMATOLOGY">Dermatology</option>
                  <option value="ENT">ENT</option>
                  <option value="GENERAL">General</option>
                </select>
              </div>

              <div className="flex justify-end gap-3 pt-4 border-t mt-4">
                <Button type="button" variant="outline" onClick={() => setIsOpen(false)}>
                  Cancel
                </Button>
                <Button type="submit" disabled={isSubmitting} className="bg-emerald-600 hover:bg-emerald-700">
                  {isSubmitting ? <Loader2 className="h-4 w-4 mr-2 animate-spin" /> : null}
                  Create Account
                </Button>
              </div>
            </form>
          </div>
        </div>
      )}
    </>
  );
}
