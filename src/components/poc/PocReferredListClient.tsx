"use client";

import { useState } from "react";
import { Badge } from "@/components/ui/badge";
import { ArrowRight, Search, Download, Printer, FileText } from "lucide-react";
import { useRouter } from "next/navigation";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";

type ReferredStudent = {
    id: string;
    name: string;
    classSec: string;
    depts: string[];
};

interface PocReferredListClientProps {
    students: ReferredStudent[];
    eventId: string;
}

export function PocReferredListClient({ students, eventId }: PocReferredListClientProps) {
    const router = useRouter();
    const [selectedDept, setSelectedDept] = useState<string>("ALL");
    const [search, setSearch] = useState("");

    const DEPTS = [
        "ENT Examination", 
        "Dental Examination", 
        "Ophthalmology Examination", 
        "Dermatology Examination", 
        "Systemic Examination"
    ];

    const filteredStudents = students.filter((stud) => {
        const matchesDept = selectedDept === "ALL" || stud.depts.includes(selectedDept);
        const matchesSearch = stud.name.toLowerCase().includes(search.toLowerCase()) || 
                             stud.classSec.toLowerCase().includes(search.toLowerCase());
        return matchesDept && matchesSearch;
    });

    const handleExportCSV = () => {
        const headers = ["Student Name", "Class/Sec", "Referred Sections"];
        const rows = filteredStudents.map(s => [
            `"${s.name}"`,
            `"${s.classSec}"`,
            `"${s.depts.join("; ")}"`
        ]);
        const csvContent = [headers, ...rows].map(e => e.join(",")).join("\n");
        const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement("a");
        const url = URL.createObjectURL(blob);
        link.setAttribute("href", url);
        link.setAttribute("download", `referred_students_export.csv`);
        link.style.visibility = 'hidden';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    };

    return (
        <div className="flex flex-col gap-6">
        <div className="flex flex-col gap-4">
            <div className="flex bg-slate-100 p-1 rounded-lg overflow-x-auto w-full self-start">
                <button
                    onClick={() => setSelectedDept("ALL")}
                    className={`px-4 py-1.5 text-sm font-black rounded-md whitespace-nowrap transition-all flex-1 sm:flex-none uppercase tracking-widest ${selectedDept === "ALL"
                        ? 'bg-white text-slate-900 shadow-sm'
                        : 'text-slate-500 hover:text-slate-700 hover:bg-slate-200/50'
                        }`}
                >
                    All Sections
                </button>
                {DEPTS.map(dept => (
                    <button
                        key={dept}
                        onClick={() => setSelectedDept(dept)}
                        className={`px-4 py-1.5 text-sm font-black rounded-md whitespace-nowrap transition-all flex-1 sm:flex-none uppercase tracking-widest ${selectedDept === dept
                            ? 'bg-white text-red-600 shadow-sm'
                            : 'text-slate-500 hover:text-slate-700 hover:bg-slate-200/50'
                            }`}
                    >
                        {dept}
                    </button>
                ))}
            </div>

            <div className="flex flex-col md:flex-row items-center gap-4">
                <div className="relative w-full md:w-80 group">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400 group-focus-within:text-emerald-500 transition-colors" />
                    <Input
                        value={search}
                        onChange={(e) => setSearch(e.target.value)}
                        placeholder="Search student by name or class..."
                        className="pl-10 h-10 bg-white border-slate-200 focus:ring-emerald-500/20 transition-all text-sm font-medium rounded-xl shadow-sm"
                    />
                </div>
                <Button 
                    onClick={handleExportCSV}
                    variant="outline" 
                    className="w-full md:w-auto flex items-center gap-2 uppercase text-[10px] font-black tracking-widest bg-white border-slate-200 hover:bg-slate-50 text-slate-600 rounded-xl h-10"
                >
                    <Download className="h-3.5 w-3.5" /> Export CSV
                </Button>
                <Button 
                    onClick={() => window.open(`/print/referred-list/${eventId}`, '_blank')}
                    variant="outline" 
                    className="w-full md:w-auto flex items-center gap-2 uppercase text-[10px] font-black tracking-widest bg-indigo-600 border-indigo-600 hover:bg-indigo-700 text-white rounded-xl h-10 shadow-lg shadow-indigo-100"
                >
                    <Printer className="h-3.5 w-3.5" /> Print PDF List
                </Button>
            </div>
        </div>

            <div className="bg-white rounded-2xl shadow-sm border overflow-hidden transition-all duration-200 hover:shadow-md">
                <div className="overflow-x-auto">
                    <table className="w-full text-sm text-center">
                        <thead className="text-xs text-slate-500 bg-slate-50/80 uppercase border-b backdrop-blur-sm">
                            <tr>
                                <th className="px-6 py-4 font-bold text-center">Student Name</th>
                                <th className="px-6 py-4 font-bold text-center">Class/Sec</th>
                                <th className="px-6 py-4 font-bold text-center">Referred Sections</th>
                                <th className="px-6 py-4 font-bold text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {filteredStudents.length > 0 ? filteredStudents.map((stud) => (
                                <tr
                                    key={stud.id}
                                    onClick={() => router.push(`/poc/workspace/${eventId}/student/${stud.id}?from=referred`)}
                                    className="transition-colors group cursor-pointer hover:bg-slate-50/80"
                                >
                                    <td className="px-6 py-4 font-bold text-slate-900 text-center">
                                        {stud.name}
                                    </td>
                                    <td className="px-6 py-4 text-slate-600 font-bold text-center">
                                        <span className="bg-slate-100/80 text-slate-500 px-2.5 py-1 rounded-md text-[10px] uppercase tracking-widest leading-none border border-slate-200/50">
                                            {stud.classSec}
                                        </span>
                                    </td>
                                    <td className="px-6 py-4 text-center">
                                        <div className="flex flex-wrap justify-center gap-1.5">
                                            {stud.depts.map((d) => (
                                                <span key={d} className="text-[9px] font-black bg-red-50 text-red-700 px-2.5 py-1 rounded-lg uppercase tracking-widest border border-red-200/30">
                                                    {d}
                                                </span>
                                            ))}
                                        </div>
                                    </td>
                                    <td className="px-6 py-4 text-center">
                                        <div className="flex items-center justify-center gap-2">
                                            <Button
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    window.open(`/print/${stud.id}?mode=full`, '_blank');
                                                }}
                                                variant="ghost"
                                                size="sm"
                                                className="h-8 px-2 flex items-center gap-1.5 uppercase text-[9px] font-black tracking-tighter text-emerald-600 hover:text-emerald-700 hover:bg-emerald-50 rounded-lg border border-transparent hover:border-emerald-200 transition-all"
                                                title="Complete Report"
                                            >
                                                <FileText className="h-3.5 w-3.5" /> Report
                                            </Button>
                                            <Button
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    window.open(`/print/${stud.id}?mode=referred`, '_blank');
                                                }}
                                                variant="ghost"
                                                size="sm"
                                                className="h-8 px-2 flex items-center gap-1.5 uppercase text-[9px] font-black tracking-tighter text-red-600 hover:text-red-700 hover:bg-red-50 rounded-lg border border-transparent hover:border-red-200 transition-all"
                                                title="Print Referral Only"
                                            >
                                                <Printer className="h-3.5 w-3.5" /> Referral
                                            </Button>
                                        </div>
                                    </td>
                                </tr>
                            )) : (
                                <tr>
                                    <td colSpan={4} className="py-20 text-center text-slate-500">
                                        <div className="flex flex-col items-center">
                                            <div className="inline-flex items-center justify-center h-14 w-14 rounded-full bg-slate-50 text-slate-300 mb-4 border border-slate-100">
                                                <Search className="h-7 w-7" />
                                            </div>
                                            <h3 className="text-sm font-bold text-slate-900 uppercase tracking-widest">No Referrals Found</h3>
                                            <p className="text-[10px] text-slate-500 uppercase mt-1">Try adjusting your filters or search.</p>
                                        </div>
                                    </td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}
