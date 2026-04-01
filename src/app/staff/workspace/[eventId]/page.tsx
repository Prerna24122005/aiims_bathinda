import { Navbar } from "@/components/layout/Navbar";
import { prisma } from "@/lib/db/prisma";
import { notFound, redirect } from "next/navigation";
import { WorkspaceClient } from "@/components/staff/WorkspaceClient";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";

export default async function EventWorkspace({ params }: { params: Promise<{ eventId: string }> }) {
  const { eventId } = await params;
  const session = await getServerSession(authOptions);

  // Fetch event deep data
  const event = await (prisma.event as any).findUnique({
    where: { id: eventId },
    include: {
      eventStaff: {
        select: {
          user: {
            select: { id: true, fullName: true, email: true }
          }
        }
      },
      students: {
        include: {
          medicalRecord: {
            select: { status: true, updatedAt: true, data: true }
          }
        },
        orderBy: { firstName: "asc" }
      }
    }
  });

  if (!event) return notFound();

  const isStaff = event.eventStaff.some((s: any) => s.user.id === session?.user?.id);
  const isAdmin = session?.user?.role === "ADMIN";

  if (!isAdmin && !isStaff) {
    return redirect("/staff/dashboard");
  }

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col">
      <Navbar role={session?.user?.role || "MEDICAL_STAFF"} userName={session?.user?.name || "Dr. Staff"} />

      <WorkspaceClient
        eventId={event.id}
        schoolName={event.schoolDetails}
        eventDate={event.eventDate}
        location="Main Campus" // Fallback since it's not in schema currently
        students={event.students}
        eventStaff={event.eventStaff.map((s: any) => s.user)}
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        formConfig={event.formConfig as any}
        currentUserId={session?.user?.id || ""}
      />
    </div>
  );
}
