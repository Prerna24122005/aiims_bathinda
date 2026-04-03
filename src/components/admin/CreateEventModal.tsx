"use client";

import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Loader2 } from "lucide-react";
import { createEvent } from "@/lib/actions/admin-actions";

type StaffType = {
  id: string;
  fullName: string;
  email: string;
  department?: string | null;
};

export function CreateEventModal({
  medicalStaff,
  onClose
}: {
  medicalStaff: StaffType[];
  onClose: () => void;
}) {
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [selectedStaff, setSelectedStaff] = useState<string[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [minDate, setMinDate] = useState<string>("");

  useEffect(() => {
    const today = new Date();
    const localDate = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
    setMinDate(localDate);
  }, []);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const formData = new FormData(e.currentTarget);
    const dateStr = formData.get("date") as string;

    const payload = {
      schoolDetails: formData.get("schoolDetails") as string,
      eventDate: new Date(dateStr),
      pocName: formData.get("pocName") as string,
      pocEmail: formData.get("pocEmail") as string,
      pocPhone: formData.get("pocPhone") as string,
      staffIds: selectedStaff
    };

    const res = await createEvent(payload as any);

    if (res.success) {
      onClose();
    } else {
      setError(res.error || "Failed to create event");
      setIsSubmitting(false);
    }
  };

  const toggleStaffSelection = (id: string) => {
    setSelectedStaff((prev) =>
      prev.includes(id) ? prev.filter((sId) => sId !== id) : [...prev, id]
    );
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 px-4" onClick={onClose}>
      <div className="bg-white rounded-lg p-6 max-w-lg w-full shadow-xl max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
        <h3 className="text-xl font-bold text-gray-900 mb-1">Create New Health Camp Event</h3>

        {error && <div className="p-3 mb-4 text-sm text-red-700 bg-red-50 rounded-lg">{error}</div>}

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-1">
            <label className="text-sm font-medium text-slate-700">School Name / Details</label>
            <input required name="schoolDetails" type="text" className="w-full p-2 border rounded-md" placeholder="e.g. Pathfinder Global School" />
          </div>

          <div className="space-y-1">
            <label className="text-sm font-medium text-slate-700">Event Date</label>
            <input
              required
              name="date"
              type="date"
              className="w-full p-2 border rounded-md"
              min={minDate}
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1">
              <label className="text-sm font-medium text-slate-700">POC Name</label>
              <input required name="pocName" type="text" className="w-full p-2 border rounded-md" placeholder="Dinesh Kumar" />
            </div>
            <div className="space-y-1">
              <label className="text-sm font-medium text-slate-700">POC Email</label>
              <input required name="pocEmail" type="email" className="w-full p-2 border rounded-md" placeholder="poc@school.com" />
            </div>
          </div>

          <div className="space-y-1">
            <label className="text-sm font-medium text-slate-700">Mobile Number</label>
            <input
              required
              name="pocPhone"
              type="tel"
              pattern="^\+91\d{10}$"
              maxLength={13}
              className="w-full p-2 border rounded-md"
              placeholder="e.g. +9112332xxxxx"
              title="Format: +91 followed by 10 digits"
              onInvalid={(e) => (e.target as HTMLInputElement).setCustomValidity("Please enter a valid mobile number starting with +91 followed by 10 digits.")}
              onInput={(e) => (e.target as HTMLInputElement).setCustomValidity("")}
            />
          </div>

          <div className="pt-2">
            <h4 className="font-medium text-slate-900 mb-2">Assign Medical Staff</h4>
            <div className="space-y-2 border rounded-md p-3 max-h-48 overflow-y-auto">
              {medicalStaff.map((staff) => (
                <label key={staff.id} className="flex items-center space-x-3 cursor-pointer p-2 hover:bg-slate-50 rounded">
                  <input
                    type="checkbox"
                    className="w-4 h-4 text-emerald-600 rounded border-gray-300 focus:ring-emerald-500"
                    checked={selectedStaff.includes(staff.id)}
                    onChange={() => toggleStaffSelection(staff.id)}
                  />
                  <div className="flex-1 flex justify-between items-center">
                    <div>
                      <p className="font-medium text-sm text-slate-900">{staff.fullName}</p>
                      <p className="text-xs text-slate-500">{staff.email}</p>
                    </div>
                    {staff.department && (
                      <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-[10px] font-bold tracking-wider bg-slate-100 text-slate-600 uppercase border border-slate-200">
                        {staff.department.replace("_", " ")}
                      </span>
                    )}
                  </div>
                </label>
              ))}
            </div>
          </div>

          <div className="flex justify-end gap-3 pt-4 border-t mt-4">
            <Button type="button" variant="outline" onClick={onClose}>
              Cancel
            </Button>
            <Button type="submit" disabled={isSubmitting} className="bg-emerald-600 hover:bg-emerald-700 disabled:opacity-100">
              {isSubmitting ? <Loader2 className="h-4 w-4 mr-2 animate-spin" /> : null}
              Create Event
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
}
