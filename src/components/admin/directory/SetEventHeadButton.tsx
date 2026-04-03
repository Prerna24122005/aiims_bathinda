"use client";

import { Button } from "@/components/ui/button";
import { useState } from "react";
import { Loader2, Crown } from "lucide-react";
import { setEventHead } from "@/lib/actions/admin-actions";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

export function SetEventHeadButton({
  eventId,
  medicalStaff
}: {
  eventId: string,
  medicalStaff: { id: string, fullName: string, email: string, department?: string | null }[]
}) {
  const [isUpdating, setIsUpdating] = useState(false);
  const [open, setOpen] = useState(false);
  const [selectedUserId, setSelectedUserId] = useState<string>("");
  const [search, setSearch] = useState("");

  const filteredStaff = medicalStaff.filter(s => {
    if (!search) return true;
    const q = search.toLowerCase();
    const dept = s.department?.replace("_", " ") || "";
    return s.fullName.toLowerCase().includes(q) || dept.toLowerCase().includes(q);
  });

  const handleMakeHead = async () => {
    if (!selectedUserId) return;
    setIsUpdating(true);
    const result = await setEventHead(eventId, selectedUserId);
    setIsUpdating(false);

    if (!result.success) {
      alert(result.error || "Failed to make event head");
    } else {
      setOpen(false);
      setSelectedUserId("");
    }
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger
        className="inline-flex h-8 items-center justify-center rounded-md px-3 text-sm font-medium text-amber-600 hover:text-amber-700 hover:bg-amber-50 hover:border-transparent transition-colors disabled:opacity-50 disabled:pointer-events-none"
      >
        <Crown className="mr-1 h-3 w-3" /> Make Head
      </DialogTrigger>
      <DialogContent showCloseButton={true}>
        <DialogHeader className="space-y-2">
          <DialogTitle className="text-xl font-semibold">
            Assign Event Head
          </DialogTitle>
          <DialogDescription className="text-sm text-muted-foreground">
            Choose one doctor from assigned staff to lead this event.
          </DialogDescription>
        </DialogHeader>

        <div className="py-2">
          {(!medicalStaff || medicalStaff.length === 0) ? (
            <p className="text-sm text-red-500">No medical staff available.</p>
          ) : (
            <div className="border rounded-md overflow-hidden bg-white">
              <div className="p-2 border-b border-slate-100">
                <input
                  type="text"
                  placeholder="Search by name or department..."
                  className="w-full px-3 py-1.5 text-sm border border-slate-200 rounded-md focus:outline-none focus:ring-1 focus:ring-amber-500 focus:border-amber-500"
                  value={search}
                  onChange={(e) => setSearch(e.target.value)}
                />
              </div>
              <div className="space-y-2 p-3 max-h-[320px] overflow-y-auto bg-slate-50/30">
                {filteredStaff.length === 0 ? (
                  <div className="p-8 text-center text-sm text-slate-500 bg-white border border-dashed rounded-lg italic">No staff found matching your search.</div>
                ) : (
                  filteredStaff.map((staff) => (
                    <label
                      key={staff.id}
                      className={`flex items-center justify-between cursor-pointer p-3 rounded-lg border transition-all shadow-sm bg-white hover:border-amber-400 group ${selectedUserId === staff.id ? 'border-amber-500 ring-1 ring-amber-500/10 bg-amber-50/50' : 'border-slate-200'}`}
                    >
                      <div className="flex items-center space-x-3 pr-2">
                        <div className="flex-shrink-0">
                          <input
                            type="radio"
                            name="eventHead"
                            className="w-4 h-4 text-amber-600 border-gray-300 focus:ring-amber-500"
                            checked={selectedUserId === staff.id}
                            onChange={() => setSelectedUserId(staff.id)}
                          />
                        </div>
                        <div className="flex flex-col min-w-0">
                          <span className="text-sm font-bold text-gray-900 leading-none mb-1 group-hover:text-amber-700 transition-colors truncate">{staff.fullName}</span>
                          <span className="text-[10px] text-gray-500 font-medium truncate opacity-70">{staff.email}</span>
                        </div>
                      </div>
                      {staff.department && (
                        <div className="flex-shrink-0">
                          <span className="inline-flex items-center px-2 py-0.5 rounded-full text-[9px] font-extrabold bg-slate-100 text-slate-600 uppercase border border-slate-200 tracking-wider">
                            {staff.department.replace("_", " ")}
                          </span>
                        </div>
                      )}
                    </label>
                  ))
                )}
              </div>
            </div>
          )}
        </div>

        <DialogFooter showCloseButton={true}>
          <Button
            onClick={handleMakeHead}
            disabled={isUpdating || !selectedUserId}
            className="bg-amber-600 hover:bg-amber-700 text-white"
          >
            {isUpdating ? <Loader2 className="h-4 w-4 animate-spin mr-2" /> : <Crown className="h-4 w-4 mr-2" />}
            Confirm Assignment
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
