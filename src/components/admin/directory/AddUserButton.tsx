"use client";

import { useState, useRef, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { UserPlus, Loader2, ChevronDown, Search, Check } from "lucide-react";
import { addMedicalStaff } from "@/lib/actions/admin-actions";

const DEPARTMENTS = [
  { value: "COMMUNITY_MEDICINE", label: "Community Medicine" },
  { value: "DENTAL", label: "Dental" },
  { value: "OPHTHALMOLOGY", label: "Ophthalmology" },
  { value: "DERMATOLOGY", label: "Dermatology" },
  { value: "ENT", label: "ENT" },
  { value: "INTERNAL_MEDICINE", label: "Internal Medicine" },
  { value: "PEDIATRICS", label: "Pediatrics" },
  { value: "OB_GYN", label: "OB/GYN" },
  { value: "EMERGENCY_MEDICINE", label: "Emergency Medicine" },
  { value: "NEUROLOGY", label: "Neurology" },
  { value: "ORTHOPAEDICS", label: "Orthopaedics" },
  { value: "GASTROENTEROLOGY", label: "Gastroenterology" },
  { value: "PATHOLOGY", label: "Pathology" },
  { value: "PSYCHIATRY", label: "Psychiatry" },
  { value: "OTHER", label: "Other" },
];

export function AddUserButton() {
  const [isOpen, setIsOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Department dropdown state
  const [deptOpen, setDeptOpen] = useState(false);
  const [deptSearch, setDeptSearch] = useState("");
  const [selectedDept, setSelectedDept] = useState<string>("COMMUNITY_MEDICINE");
  const deptRef = useRef<HTMLDivElement>(null);

  // Close dropdown on outside click
  useEffect(() => {
    const handleClick = (e: MouseEvent) => {
      if (deptRef.current && !deptRef.current.contains(e.target as Node)) {
        setDeptOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClick);
    return () => document.removeEventListener("mousedown", handleClick);
  }, []);

  const filteredDepts = DEPARTMENTS.filter(d =>
    d.label.toLowerCase().includes(deptSearch.toLowerCase())
  );

  const selectedLabel = DEPARTMENTS.find(d => d.value === selectedDept)?.label || "Select department";

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError(null);

    const formData = new FormData(e.currentTarget);
    const fullName = formData.get("fullName") as string;
    const email = formData.get("email") as string;

    const res = await addMedicalStaff(fullName, email, selectedDept);

    if (res.success) {
      setIsOpen(false);
      setSelectedDept("COMMUNITY_MEDICINE");
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
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 px-4" onClick={(e) => { if (e.target === e.currentTarget) setIsOpen(false); }}>
          <div className="bg-white rounded-lg p-6 max-w-md w-full shadow-xl">
            <h3 className="text-xl font-bold text-gray-900 mb-1">Add Medical Staff</h3>

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

              <div className="space-y-1" ref={deptRef}>
                <label className="text-sm font-medium text-slate-700">Department</label>
                <div className="relative">
                  <button
                    type="button"
                    onClick={() => { setDeptOpen(!deptOpen); setDeptSearch(""); }}
                    className="w-full flex items-center justify-between p-2 border rounded-md bg-white text-left hover:border-slate-400 transition-colors"
                  >
                    <span className="text-sm text-slate-800">{selectedLabel}</span>
                    <ChevronDown className={`h-4 w-4 text-slate-400 transition-transform ${deptOpen ? 'rotate-180' : ''}`} />
                  </button>

                  {deptOpen && (
                    <div className="absolute z-10 mt-1 w-full bg-white border border-slate-200 rounded-lg shadow-lg overflow-hidden">
                      <div className="p-2 border-b border-slate-100">
                        <input
                          type="text"
                          placeholder="Search departments..."
                          className="w-full px-3 py-1.5 text-sm border border-slate-200 rounded-md focus:outline-none focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500"
                          value={deptSearch}
                          onChange={(e) => setDeptSearch(e.target.value)}
                          autoFocus
                        />
                      </div>
                      <div className="max-h-48 overflow-y-auto py-1">
                        {filteredDepts.length === 0 ? (
                          <div className="px-3 py-2 text-sm text-slate-400 text-center">No departments found</div>
                        ) : (
                          filteredDepts.map(dept => (
                            <button
                              key={dept.value}
                              type="button"
                              onClick={() => { setSelectedDept(dept.value); setDeptOpen(false); setDeptSearch(""); }}
                              className={`w-full flex items-center justify-between px-3 py-2 text-sm text-left hover:bg-emerald-50 transition-colors ${selectedDept === dept.value ? 'bg-emerald-50 text-emerald-700 font-medium' : 'text-slate-700'}`}
                            >
                              <span>{dept.label}</span>
                              {selectedDept === dept.value && <Check className="h-4 w-4 text-emerald-600" />}
                            </button>
                          ))
                        )}
                      </div>
                    </div>
                  )}
                </div>
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
