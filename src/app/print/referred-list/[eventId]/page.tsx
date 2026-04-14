import { prisma } from "@/lib/db/prisma";
import { notFound } from "next/navigation";

export default async function ReferredListPrintPage(props: {
    params: Promise<{ eventId: string }>
}) {
    const { eventId } = await props.params;

    const event = await prisma.event.findUnique({
        where: { id: eventId }
    });

    if (!event) return notFound();

    const students = await prisma.student.findMany({
        where: {
            eventId: eventId,
            medicalRecord: {
                isNot: null
            }
        },
        include: {
            medicalRecord: true
        },
        orderBy: [
            { classSec: 'asc' },
            { firstName: 'asc' }
        ]
    });

    // Filter students who are referred in at least one section
    const referredStudents = students.filter(student => {
        const recordData = (student.medicalRecord?.data as Record<string, any>) || {};
        return Object.values(recordData).some((section: any) => section.status_nor === 'R');
    });

    return (
        <div className="bg-white min-h-screen p-8 text-black font-mono">
            {/* Header */}
            <div className="text-center border-b-2 border-black pb-4 mb-6">
                <h1 className="text-xl font-bold uppercase underline">AIIMS BHATINDA - REFERRED STUDENTS LIST</h1>
                <p className="text-xs mt-1">{event.schoolDetails}</p>
                <div className="flex justify-between text-[10px] mt-2 font-bold">
                    <span>Event Date: {new Date(event.eventDate).toLocaleDateString()}</span>
                    <span>Total Referred: {referredStudents.length}</span>
                </div>
            </div>

            {/* Table */}
            <table className="w-full border-collapse border border-black text-[10px]">
                <thead>
                    <tr className="bg-slate-100 uppercase">
                        <th className="border border-black p-1 text-left">Class</th>
                        <th className="border border-black p-1 text-left">Student Name</th>
                        <th className="border border-black p-1 text-left">Gender</th>
                        <th className="border border-black p-1 text-left">Age</th>
                        <th className="border border-black p-1 text-left">Referred Sections & Remarks</th>
                    </tr>
                </thead>
                <tbody>
                    {referredStudents.map((student) => {
                        const recordData = (student.medicalRecord?.data as Record<string, any>) || {};
                        const referredSections = Object.entries(recordData)
                            .filter(([_, data]: [string, any]) => data.status_nor === 'R')
                            .map(([key, data]: [string, any]) => {
                                const sectionName = key.replace(/_/g, ' ').toUpperCase();
                                return `${sectionName}${data.doctorRemarks ? `: ${data.doctorRemarks}` : ''}`;
                            });

                        return (
                            <tr key={student.id} className="break-inside-avoid">
                                <td className="border border-black p-1 align-top">{student.classSec}</td>
                                <td className="border border-black p-1 align-top font-bold">{student.firstName} {student.lastName}</td>
                                <td className="border border-black p-1 align-top">{student.gender}</td>
                                <td className="border border-black p-1 align-top">{student.age}</td>
                                <td className="border border-black p-1 align-top">
                                    <ul className="list-disc pl-3">
                                        {referredSections.map((info, idx) => (
                                            <li key={idx} className="mb-0.5">{info}</li>
                                        ))}
                                    </ul>
                                </td>
                            </tr>
                        );
                    })}
                </tbody>
            </table>

            {/* Footer */}
            <div className="mt-8 pt-4 border-t border-black text-right">
                <p className="text-[10px] font-bold">Generated on: {new Date().toLocaleString()}</p>
                <p className="text-[8px] italic mt-1 font-bold">Confidential Medical Record - For Internal Use Only</p>
            </div>

            {/* Auto Print Trigger */}
            <script dangerouslySetInnerHTML={{ __html: `window.print()` }} />

            <style dangerouslySetInnerHTML={{ __html: `
                @media print {
                    @page { margin: 10mm; size: landscape; }
                    body { -webkit-print-color-adjust: exact; }
                }
            ` }} />
        </div>
    );
}
