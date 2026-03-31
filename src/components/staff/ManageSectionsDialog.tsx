"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger, DialogFooter } from "@/components/ui/dialog";
import { Loader2, Settings2 } from "lucide-react";
import { assignSections } from "@/lib/actions/staff-actions";

type StaffMember = {
  id: string;
  fullName: string;
  email: string;
};

// Map formal keys to human readable names
const BASE_CATEGORIES: Record<string, string> = {
  demographics: "General Information",
  ent: "ENT (Ear, Nose, Throat)",
  communityMed: "Community Medicine",
  dental: "Dental",
  optical: "Optical",
  skin: "Skin",
};

export function ManageSectionsDialog({
  eventId,
  formConfig,
  eventStaff,
}: {
  eventId: string;
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  formConfig: any;
  eventStaff: StaffMember[];
}) {
  const [isOpen, setIsOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  // Initialize a local state map matching category -> array of assigned doctor IDs
  const existingAssignments: Record<string, string[]> = formConfig.sectionAssignments || {};
  const customCategories = formConfig.customCategories || [];

  const allCategories = [
    ...Object.keys(BASE_CATEGORIES).map(k => ({ id: k, name: BASE_CATEGORIES[k] })),
    ...customCategories.map((c: any) => ({ id: c.slug, name: c.name }))
  ];

  const [assignments, setAssignments] = useState<Record<string, string[]>>(existingAssignments);

  const toggleDoctorForSection = (categorySlug: string, doctorId: string) => {
    setAssignments((prev) => {
      const activeForCategory = prev[categorySlug] || [];
      const updated = activeForCategory.includes(doctorId)
        ? activeForCategory.filter(id => id !== doctorId)
        : [...activeForCategory, doctorId];

      return { ...prev, [categorySlug]: updated };
    });
  };

  const handleSave = async () => {
    setIsSubmitting(true);
    const res = await assignSections(eventId, assignments);
    setIsSubmitting(false);

    if (res.success) {
      setIsOpen(false);
    } else {
      alert(res.error || "Failed to save section assignments");
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={setIsOpen}>
      <DialogTrigger className="inline-flex h-9 items-center justify-center rounded-md border border-slate-200 bg-white px-4 py-2 text-sm font-medium shadow-sm hover:bg-slate-100 text-slate-700 flex-1 sm:flex-none transition-colors">
        <Settings2 className="mr-2 h-4 w-4 text-emerald-600" /> Manage Sections
      </DialogTrigger>
      <DialogContent className="w-[95vw] sm:max-w-[95vw] md:max-w-4xl lg:max-w-6xl xl:max-w-[1400px] max-h-[90vh] flex flex-col rounded-2xl">
        <DialogHeader className="space-y-2">
          <DialogTitle className="text-xl">Form Section Assignments</DialogTitle>
          <DialogDescription>
            Assign specific medical staff to different sections of the digital form. Doctors not assigned to a section will only have <strong>Read-Only</strong> access to that section.
          </DialogDescription>
        </DialogHeader>

        <div className="flex-1 overflow-y-auto space-y-6 pr-2 py-4">
          {eventStaff.length === 0 ? (
            <p className="text-sm text-slate-500 italic">No medical staff have been assigned to this event yet.</p>
          ) : (
            allCategories.map((category) => {
              const activeDoctors = assignments[category.id] || [];

              return (
                <div key={category.id} className="space-y-4 p-4 rounded-xl bg-slate-50 border border-slate-200">
                  <h4 className="text-base font-semibold text-slate-900">
                    {category.name}
                  </h4>
                  <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                    {eventStaff.map(staff => {
                      const isAssigned = activeDoctors.includes(staff.id);
                      return (
                        <label
                          key={staff.id}
                          className={`flex items-center gap-3 p-4 rounded-xl border w-full overflow-hidden transition-all duration-150 cursor-pointer ${isAssigned
                            ? 'bg-emerald-50 border-emerald-300 ring-1 ring-emerald-400/30 shadow-sm'
                            : 'bg-white border-slate-200 hover:bg-slate-50'
                            }`}>
                          <input
                            type="checkbox"
                            className="h-4 w-8 rounded border-gray-300 text-emerald-600 focus:ring-emerald-600"
                            checked={isAssigned}
                            onChange={() => toggleDoctorForSection(category.id, staff.id)}
                          />
                          <div className="flex flex-col">
                            <span className="text-sm font-medium text-slate-900 truncate">{staff.fullName}</span>
                            <span className="text-xs text-slate-500 truncate w-full" title={staff.email}>{staff.email}</span>
                          </div>
                        </label>
                      );
                    })}
                  </div>
                </div>
              );
            })
          )}
        </div>

        <DialogFooter className="pt-4 border-t flex justify-between">
          <Button variant="outline" onClick={() => setIsOpen(false)} disabled={isSubmitting}>
            Cancel
          </Button>
          <Button onClick={handleSave} disabled={isSubmitting} className="bg-emerald-600 hover:bg-emerald-700 text-white min-w-[120px]">
            {isSubmitting ? <Loader2 className="h-4 w-4 animate-spin mr-2" /> : null}
            Save Assignments
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
