"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Trash2, Loader2 } from "lucide-react";
import { removeStaffFromEvent } from "@/lib/actions/admin-actions";

export function RemoveStaffButton({
  eventId,
  userId,
  staffName
}: {
  eventId: string;
  userId: string;
  staffName: string;
}) {
  const [isRemoving, setIsRemoving] = useState(false);

  const handleRemove = async () => {
    if (!confirm(`Are you sure you want to remove ${staffName} from this event?`)) {
      return;
    }

    setIsRemoving(true);
    await removeStaffFromEvent(eventId, userId);
    setIsRemoving(false);
  };

  return (
    <Button
      variant="ghost"
      onClick={handleRemove}
      disabled={isRemoving}
      className="text-red-500 border border-red-700 rounded-md hover:text-red-700 hover:bg-red-50 h-10 w-10 p-0"
      title={`Remove ${staffName}`}
    >
      {isRemoving ? <Loader2 className="h-10 w-10 animate-spin" /> : <Trash2 className="h-10 w-10" />}
    </Button>
  );
}
