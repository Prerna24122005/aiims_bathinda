"use server";

import { prisma } from "../db/prisma";
import { getServerSession } from "next-auth";
import { authOptions } from "../auth";

/**
 * Attempts to acquire a soft lock for editing a specific medical record category.
 * A lock expires after 5 minutes of inactivity.
 */
export async function acquireLock(
  studentId: string,
  eventId: string,
  category: string,
  userId: string,
  userName: string
) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user || session.user.id !== userId) {
      return { success: false, error: "Unauthorized" };
    }

    const student = await (prisma.student as any).findUnique({
      where: { id: studentId, eventId },
      include: {
        medicalRecord: true,
        event: { select: { formConfig: true, eventDate: true, pocEmail: true } }
      }
    });

    if (!student || !student.medicalRecord) {
      return { success: false, error: "Record not found" };
    }

    const event = student.event;
    const formConfig = (event?.formConfig as any) || {};
    const sectionAssignments = formConfig.sectionAssignments || {};
    const assignedDoctors = sectionAssignments[category] || [];
    const isAdmin = session.user.role === "ADMIN";
    const isPOC = event?.pocEmail?.toLowerCase() === session.user.email?.toLowerCase();

    // 1. Verify CURRENT user is allowed to get a lock
    const isCurrentUserAssigned = assignedDoctors.length === 0 || assignedDoctors.includes(userId);
    
    if (!isAdmin && !isCurrentUserAssigned && !isPOC) {
      return { success: false, error: "Unauthorized: You are not assigned to this section" };
    }

    // POC restrictions
    if (isPOC && !isAdmin) {
      if (category !== "communityMed") {
        return { success: false, error: "Unauthorized: School representatives can only edit community medicine details" };
      }

      const eventDate = new Date(event?.eventDate || "");
      eventDate.setHours(0, 0, 0, 0);
      const today = new Date();
      today.setHours(0, 0, 0, 0);

      if (today >= eventDate) {
        return { success: false, error: "Deadline passed: School representatives can only edit details until the day before the event." };
      }
    }

    const recordData = (student.medicalRecord.data as Record<string, any>) || {};
    const categoryData = recordData[category] || {};
    const existingLock = categoryData._lock;

    const now = new Date();

    // Check if lock exists and is valid
    if (existingLock) {
      const lockTime = new Date(existingLock.lockedAt);
      const diffMinutes = (now.getTime() - lockTime.getTime()) / (1000 * 60);

      // If lock belongs to someone else AND it hasn't expired (> 5 min)
      if (existingLock.userId !== userId && diffMinutes < 5) {
        // Also verify that the person holding the lock is STILL assigned!
        const isExistingUserAssigned = assignedDoctors.length === 0 || assignedDoctors.includes(existingLock.userId);

        // If they are still assigned, block the current user. Otherwise, override their lock.
        if (isExistingUserAssigned) {
          return {
            success: false,
            lockedBy: existingLock.userName,
            lockedAt: existingLock.lockedAt
          };
        }
      }
    }

    // Acquire or refresh the lock
    const newLock = {
      userId,
      userName,
      lockedAt: now.toISOString()
    };

    const updatedCategoryData = {
      ...categoryData,
      _lock: newLock
    };

    const updatedRecordData = {
      ...recordData,
      [category]: updatedCategoryData
    };

    await prisma.medicalRecord.update({
      where: { id: student.medicalRecord.id },
      data: { data: updatedRecordData }
    });

    return { success: true };
  } catch (error) {
    console.error("Failed to acquire lock:", error);
    return { success: false, error: "Database error" };
  }
}

/**
 * Releases a soft lock if the current user holds it.
 */
export async function releaseLock(
  studentId: string,
  eventId: string,
  category: string,
  userId: string
) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user || session.user.id !== userId) {
      return { success: false };
    }

    const student = await (prisma.student as any).findUnique({
      where: { id: studentId, eventId },
      include: { medicalRecord: true }
    });

    if (!student || !student.medicalRecord) {
      return { success: false };
    }

    const recordData = (student.medicalRecord.data as Record<string, any>) || {};
    const categoryData = recordData[category];

    // Only remove lock if it exists and belongs to this user
    if (categoryData && categoryData._lock && categoryData._lock.userId === userId) {
      const { _lock, ...restCategoryData } = categoryData;

      const updatedRecordData = {
        ...recordData,
        [category]: restCategoryData
      };

      await prisma.medicalRecord.update({
        where: { id: student.medicalRecord.id },
        data: { data: updatedRecordData }
      });
    }

    return { success: true };
  } catch (error) {
    console.error("Failed to release lock:", error);
    return { success: false };
  }
}
