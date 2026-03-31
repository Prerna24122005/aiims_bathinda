"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Trash2, Loader2, AlertTriangle } from "lucide-react";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { checkStaffDeletion, deleteMedicalStaff } from "@/lib/actions/admin-actions";

type DeleteUserButtonProps = {
    userId: string;
    userName: string;
};

export function DeleteUserButton({ userId, userName }: DeleteUserButtonProps) {
    const [isOpen, setIsOpen] = useState(false);
    const [isChecking, setIsChecking] = useState(false);
    const [isDeleting, setIsDeleting] = useState(false);
    const [warningData, setWarningData] = useState<{ hasUpcoming: boolean; count: number } | null>(null);

    const handleOpenChange = async (open: boolean) => {
        if (open) {
            setIsOpen(true);
            setIsChecking(true);
            const res = await checkStaffDeletion(userId);
            if (res.success) {
                setWarningData({ hasUpcoming: res.hasUpcoming || false, count: res.upcomingCount || 0 });
            } else {
                alert("Failed to check staff assignments.");
                setIsOpen(false);
            }
            setIsChecking(false);
        } else {
            setIsOpen(false);
            setWarningData(null);
        }
    };

    const handleConfirmDelete = async () => {
        setIsDeleting(true);
        const res = await deleteMedicalStaff(userId);
        if (res.success) {
            setIsOpen(false);
            alert(`${userName} has been removed successfully.`);
        } else {
            alert("Failed to delete user.");
        }
        setIsDeleting(false);
    };

    return (
        <>
            <Button
                variant="ghost"
                size="icon"
                onClick={() => handleOpenChange(true)}
                className="text-red-500 hover:text-red-700 hover:bg-red-50 transition-colors"
            >
                <Trash2 className="h-4 w-4" />
            </Button>

            <Dialog open={isOpen} onOpenChange={handleOpenChange}>
                <DialogContent className="sm:max-w-[425px]">
                    <DialogHeader>
                        <DialogTitle>Remove Medical Staff</DialogTitle>
                        <DialogDescription>
                            You are about to remove <strong>{userName}</strong> from the directory.
                        </DialogDescription>
                    </DialogHeader>

                    <div className="py-4">
                        {isChecking ? (
                            <div className="flex items-center justify-center text-slate-500 py-4 gap-2">
                                <Loader2 className="h-5 w-5 animate-spin" /> Checking active assignments...
                            </div>
                        ) : warningData?.hasUpcoming ? (
                            <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 flex gap-3 text-amber-800">
                                <AlertTriangle className="h-5 w-5 shrink-0 text-amber-600 mt-0.5" />
                                <div className="text-sm">
                                    <p className="font-semibold mb-1">Upcoming Event Warning</p>
                                    <p>This staff member is currently assigned to <strong>{warningData.count}</strong> upcoming/active event(s).</p>
                                    <p className="mt-2 text-amber-700/80">Continuing will forcibly unassign them from these events, but their historical records on past events will be kept intact.</p>
                                </div>
                            </div>
                        ) : (
                            <p className="text-sm text-slate-600">
                                They have no active assignments. Their data on past completed events will remain intact for historical records. Are you sure you want to proceed?
                            </p>
                        )}
                    </div>

                    <DialogFooter className="gap-2 sm:gap-0">
                        <Button variant="outline" onClick={() => handleOpenChange(false)} disabled={isChecking || isDeleting}>
                            Cancel
                        </Button>
                        <Button
                            variant="destructive"
                            onClick={handleConfirmDelete}
                            disabled={isChecking || isDeleting}
                        >
                            {isDeleting ? <><Loader2 className="mr-2 h-4 w-4 animate-spin" /> Removing...</> : "Yes, Remove Staff"}
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>
        </>
    );
}
