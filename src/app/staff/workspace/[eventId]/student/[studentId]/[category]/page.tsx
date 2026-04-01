import { prisma } from "@/lib/db/prisma";
import { notFound } from "next/navigation";
import { CategoryEditFormClient } from "@/components/staff/forms/CategoryEditForm";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";

export default async function CategoryEditForm({ params }: { params: Promise<{ eventId: string, studentId: string, category: string }> }) {
  const { eventId, studentId, category } = await params;
  const session = await getServerSession(authOptions);

  const event = await (prisma.event as any).findUnique({
    where: { id: eventId },
    select: { eventDate: true, pocEmail: true, formConfig: true }
  });
  if (!event) return notFound();

  const formConfig = ((event as any)?.formConfig as Record<string, any>) || {};
  const customCategories = Array.isArray(formConfig.customCategories) ? formConfig.customCategories : [];

  // Verify valid category
  const validCategories = ["demographics", "ent", "communityMed", "dental", "optical", "skin", ...customCategories.map((c: any) => c.id)];
  if (!validCategories.includes(category)) return notFound();

  // Fetch student and their medical record
  const student = await prisma.student.findUnique({
    where: { id: studentId, eventId },
    include: {
      medicalRecord: true
    }
  });



  if (!student) return notFound();

  // Extract the specific category JSON data if it exists
  const recordData = (student.medicalRecord?.data as Record<string, any>) || {};
  const categoryData = recordData[category] || {};

  // Extract the compulsory fields for this category
  const requiredFields = formConfig[category] || [];
  const customCategoryConfig = customCategories.find((c: any) => c.id === category) || null;

  // Dynamic status check
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const evDate = new Date(event?.eventDate || new Date());
  evDate.setHours(0, 0, 0, 0);

  let dynamicStatus = "UPCOMING";
  if (evDate.getTime() === today.getTime()) {
    dynamicStatus = "ACTIVE";
  } else if (evDate < today) {
    dynamicStatus = "PAST";
  }

  const sectionAssignments = formConfig.sectionAssignments || {};
  const currentUserId = session?.user?.id || "";
  const isAdmin = session?.user?.role === "ADMIN";
  const isAssignedDoctor = (sectionAssignments[category] || []).includes(currentUserId);
  const isPOC = event.pocEmail?.toLowerCase() === session?.user?.email?.toLowerCase();
  const isEventHead = formConfig.eventHeadId === currentUserId;

  let isSectionLockedForUser = !isAdmin && !isAssignedDoctor && !isPOC && !isEventHead;
  let readOnlyReason = "";

  if (isPOC && !isAdmin) {
    if (category !== "communityMed" && category !== "demographics") {
      isSectionLockedForUser = true;
      readOnlyReason = "School representatives can only edit the General Information and Community Medicine sections.";
    } else if (dynamicStatus !== "UPCOMING") {
      // For communityMed, POC can edit till day before the event (UPCOMING)
      isSectionLockedForUser = true;
      readOnlyReason = "The editing window for school representatives has closed (deadline was 1 day prior to the event).";
    } else {
      isSectionLockedForUser = false; // POC can edit communityMed in UPCOMING status
    }
  } else if (!isAdmin && !isAssignedDoctor && !isEventHead) {
    readOnlyReason = "You are not assigned to this medical section. You can view the data but cannot make edits.";
  }

  const isReadOnly = dynamicStatus === "PAST" || isSectionLockedForUser;

  if (dynamicStatus === "PAST") {
    readOnlyReason = "This event has already passed. The medical record is frozen and cannot be edited.";
  }

  return (
    <CategoryEditFormClient
      eventId={eventId}
      studentId={studentId}
      category={category}
      initialData={categoryData}
      requiredFields={requiredFields}
      isReadOnly={isReadOnly}
      readOnlyReason={readOnlyReason}
      userName={session?.user?.name || "Staff"}
      userId={session?.user?.id || ""}
      customCategoryBlock={customCategoryConfig}
      student={student}
      isPOC={isPOC}
    />
  );
}
