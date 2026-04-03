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
  const [eventDate, setEventDate] = useState("");
  const [hasUserSelected, setHasUserSelected] = useState(false);

  useEffect(() => {
    const today = new Date();
    const localDate = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
    setMinDate(localDate);
    setEventDate(localDate);
  }, []);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setIsSubmitting(true);
    setHasUserSelected(true);
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
    setSelectedStaff((prev) => (prev.includes(id) ? [] : [id]));
  };

  const [staffSearch, setStaffSearch] = useState("");

  const filteredStaff = medicalStaff.filter((s) => {
    if (!staffSearch) return true;
    const q = staffSearch.toLowerCase();
    const dept = s.department?.replace("_", " ") || "";
    return s.fullName.toLowerCase().includes(q) || dept.toLowerCase().includes(q);
  });

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
              className={`w-full p-2 border border-slate-200 rounded-md bg-white focus:text-slate-900 ${(!hasUserSelected && !isSubmitting) ? 'text-slate-400' : 'text-slate-900'}`}
              min={minDate}
              value={eventDate}
              onFocus={() => setHasUserSelected(true)}
              onChange={(e) => {
                setEventDate(e.target.value);
                setHasUserSelected(true);
              }}
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

          <div>
            <h4 className="font-medium text-slate-900 mb-1">Assign Event Head</h4>
            <p className="text-xs text-slate-400 mb-2">Optional — select one staff member to lead this event.</p>
            {(!medicalStaff || medicalStaff.length === 0) ? (
              <p className="text-sm text-red-500">No medical staff available.</p>
            ) : (
              <div className="border rounded-md overflow-hidden bg-white">
                <div className="p-2 border-b border-slate-100">
                  <input
                    type="text"
                    placeholder="Search by name or department..."
                    className="w-full px-3 py-1.5 text-sm border border-slate-200 rounded-md focus:outline-none focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500"
                    value={staffSearch}
                    onChange={(e) => setStaffSearch(e.target.value)}
                  />
                </div>
                <div className="space-y-1 p-2 max-h-48 overflow-y-auto bg-slate-50/10">
                  {filteredStaff.length === 0 ? (
                    <div className="p-4 text-center text-xs text-slate-500">No staff found</div>
                  ) : (
                    filteredStaff.map((staff) => (
                      <label
                        key={staff.id}
                        className={`flex items-center justify-between cursor-pointer p-2 rounded border transition-all ${selectedStaff.includes(staff.id) ? 'bg-emerald-50 border-emerald-100' : 'bg-white border-transparent hover:bg-slate-50'}`}
                      >
                        <div className="flex items-center space-x-3">
                          <input
                            type="radio"
                            name="eventHeadManual"
                            className="w-4 h-4 text-emerald-600 border-gray-300 focus:ring-emerald-500"
                            checked={selectedStaff.includes(staff.id)}
                            onClick={() => toggleStaffSelection(staff.id)}
                            readOnly
                          />
                          <div className="flex flex-col">
                            <span className="text-sm font-semibold text-gray-900 leading-tight">{staff.fullName}</span>
                            <span className="text-[10px] text-gray-500 font-medium">{staff.email}</span>
                          </div>
                        </div>
                        {staff.department && (
                          <span className="inline-flex items-center px-1.5 py-0.5 rounded-full text-[9px] font-bold bg-white text-slate-600 uppercase border border-slate-200 shadow-sm">
                            {staff.department.replace("_", " ")}
                          </span>
                        )}
                      </label>
                    ))
                  )}
                </div>
              </div>
            )}
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
