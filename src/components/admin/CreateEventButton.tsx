"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { CalendarPlus } from "lucide-react";
import { CreateEventModal } from "./CreateEventModal";

type StaffType = {
  id: string;
  fullName: string;
  email: string;
};

export function CreateEventButton({
  medicalStaff,
}: {
  medicalStaff: StaffType[];
}) {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <>
      <Button className="bg-emerald-600 hover:bg-emerald-700" onClick={() => setIsOpen(true)}>
        <CalendarPlus className="mr-2 h-4 w-4" /> Create Event
      </Button>

      {isOpen && (
        <CreateEventModal
          medicalStaff={medicalStaff}
          onClose={() => setIsOpen(false)}
        />
      )}
    </>
  );
}
