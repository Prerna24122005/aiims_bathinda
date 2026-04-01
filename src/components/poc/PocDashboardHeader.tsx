"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { KeyRound } from "lucide-react";
import { ChangePasswordModal } from "@/components/staff/ChangePasswordModal";

export function PocDashboardHeader() {
    const [isModalOpen, setIsModalOpen] = useState(false);

    return (
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-8 gap-4">
            <div className="flex flex-col gap-1">
                <h1 className="text-3xl font-bold tracking-tight text-slate-900">School Dashboard</h1>
                <p className="text-slate-500 max-w-2xl leading-relaxed text-sm">
                    Welcome to the AIIMS Bathinda school representative portal. Here you can view and manage upcoming and past health camp events organized for your school.
                </p>
            </div>

            <Button
                variant="outline"
                onClick={() => setIsModalOpen(true)}
                className="flex items-center gap-2 border-emerald-200 text-emerald-700 hover:bg-emerald-50 hover:text-emerald-800"
            >
                <KeyRound className="h-4 w-4" />
                Change Password
            </Button>

            <ChangePasswordModal
                isOpen={isModalOpen}
                onClose={() => setIsModalOpen(false)}
            />
        </div>
    );
}
