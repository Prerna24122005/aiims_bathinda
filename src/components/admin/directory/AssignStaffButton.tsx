"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Plus, Loader2 } from "lucide-react";
import { assignStaffToEvent } from "@/lib/actions/admin-actions";

type StaffMember = {
  id: string;
  fullName: string;
  email: string;
  department?: string | null;
};

export function AssignStaffButton({ 
  eventId, 
  availableStaff,
  assignedStaffIds
}: { 
  eventId: string;
  availableStaff: StaffMember[];
  assignedStaffIds: string[];
}) {
  const [isOpen, setIsOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [selectedStaffIds, setSelectedStaffIds] = useState<Set<string>>(new Set());

  // Filter out staff who are already assigned to the event
  const unassignedStaff = availableStaff.filter(s => !assignedStaffIds.includes(s.id));

  const toggleStaffSelection = (id: string) => {
    const nextChoices = new Set(selectedStaffIds);
    if (nextChoices.has(id)) {
      nextChoices.delete(id);
    } else {
      nextChoices.add(id);
    }
    setSelectedStaffIds(nextChoices);
  };

  const handleAssign = async () => {
    if (selectedStaffIds.size === 0) {
      setIsOpen(false);
      return;
    }

    setIsSubmitting(true);
    setError(null);

    const res = await assignStaffToEvent(eventId, Array.from(selectedStaffIds));
    
    if (res.success) {
      setSelectedStaffIds(new Set());
      setIsOpen(false);
    } else {
      setError(res.error || "Failed to assign staff");
    }
    setIsSubmitting(false);
  };

  return (
    <>
      <Button 
        variant="ghost" 
        size="sm" 
        className="text-emerald-600 hover:text-emerald-700 hover:bg-emerald-50 h-8 font-medium" 
        onClick={() => setIsOpen(true)}
      >
        <Plus className="mr-1 h-3 w-3" /> Assign Staff
      </Button>

      {isOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 px-4">
          <div className="bg-white rounded-lg p-6 max-w-md w-full shadow-xl">
            <h3 className="text-xl font-bold text-gray-900 mb-1">Assign Medical Staff</h3>
            <p className="text-sm text-gray-500 mb-6">Select available doctors and nurses to assign them to this event's roster.</p>

            {error && <div className="p-3 mb-4 text-sm text-red-700 bg-red-50 rounded-lg">{error}</div>}

            <div className="max-h-64 overflow-y-auto space-y-2 border rounded-md p-2 mb-6">
              {unassignedStaff.length === 0 ? (
                <p className="text-sm text-slate-500 italic text-center py-4">All available staff in the directory are already assigned to this event.</p>
              ) : (
                unassignedStaff.map(staff => (
                  <label key={staff.id} className="flex items-center gap-3 p-3 border rounded-md hover:bg-slate-50 cursor-pointer transition-colors">
                    <input 
                      type="checkbox" 
                      className="h-4 w-4 rounded border-gray-300 text-emerald-600 focus:ring-emerald-600"
                      checked={selectedStaffIds.has(staff.id)}
                      onChange={() => toggleStaffSelection(staff.id)}
                    />
                    <div className="flex-1 flex justify-between items-center">
                      <div>
                        <p className="font-medium text-sm text-slate-900">{staff.fullName}</p>
                        <p className="text-xs text-slate-500">{staff.email}</p>
                      </div>
                      {staff.department && (
                        <span className="inline-flex items-center px-2 py-0.5 rounded text-[10px] font-bold tracking-wider bg-slate-100 text-slate-600 uppercase border border-slate-200">
                          {staff.department.replace("_", " ")}
                        </span>
                      )}
                    </div>
                  </label>
                ))
              )}
            </div>

            <div className="flex justify-end gap-3 border-t pt-4">
              <Button type="button" variant="outline" onClick={() => setIsOpen(false)}>
                Cancel
              </Button>
              <Button 
                onClick={handleAssign} 
                disabled={isSubmitting || selectedStaffIds.size === 0} 
                className="bg-emerald-600 hover:bg-emerald-700"
              >
                {isSubmitting ? <Loader2 className="h-4 w-4 mr-2 animate-spin" /> : null}
                Assign Selected
              </Button>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
