/**
 * Centralized navigation logic for student records.
 * Returns a direct form section URL if the staff is assigned to only one section,
 * otherwise returns the standard student summary dashboard URL.
 */
export function getStudentNavigationUrl(
  studentId: string,
  eventId: string,
  currentUserId: string,
  formConfig: any,
  isAdmin: boolean,
  isReferredView: boolean = false,
  forceSummaryView: boolean = false
): string {
  const baseUrl = `/staff/workspace/${eventId}/student/${studentId}`;

  // Always go to summary if explicitly forced or in specialized clinical views (Referred/Observation)
  if (forceSummaryView || isReferredView) return baseUrl;

  // Admins and Event Heads (effectively assigned to all) go to summary
  const eventHeadId = formConfig?.eventHeadId;
  const isEventHead = eventHeadId === currentUserId;
  
  if (isAdmin || isEventHead) return baseUrl;

  // Check section assignments
  const assignments = formConfig?.sectionAssignments || {};
  const userAssignedSectionIds = Object.keys(assignments).filter(sectionId => 
    (assignments[sectionId] || []).includes(currentUserId)
  );

  // If assigned to EXACTLY one section, go directly to that section's form
  if (userAssignedSectionIds.length === 1) {
    return `${baseUrl}/${userAssignedSectionIds[0]}`;
  }

  // Normal multi-assignment or no assignment (read-only) case
  return baseUrl;
}
