"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { KeyRound } from "lucide-react";
import { ChangePasswordModal } from "@/components/staff/ChangePasswordModal";

export function AdminChangePasswordButton() {
    const [isOpen, setIsOpen] = useState(false);

    return (
        <>
            <Button
                variant="outline"
                onClick={() => setIsOpen(true)}
                className="flex items-center gap-2 border-emerald-200 text-emerald-700 hover:bg-emerald-50 hover:text-emerald-800"
            >
                <KeyRound className="h-4 w-4" />
                Change Password
            </Button>

            <ChangePasswordModal
                isOpen={isOpen}
                onClose={() => setIsOpen(false)}
            />
        </>
    );
}
