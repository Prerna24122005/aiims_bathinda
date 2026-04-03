"use client";

import { useState } from "react";
import { Activity, Search } from "lucide-react";
import { useRouter } from "next/navigation";
import { Input } from "@/components/ui/input";

type ObservationStudent = {
    id: string;
    name: string;
    classSec: string;
    depts: string[];
};

interface PocObservationListClientProps {
    students: ObservationStudent[];
    eventId: string;
}

export function PocObservationListClient({ students, eventId }: PocObservationListClientProps) {
    const router = useRouter();
    const [selectedDept, setSelectedDept] = useState<string>("ALL");
    const [search, setSearch] = useState("");

    const DEPTS = ["ENT", "Dental", "Optical", "Skin", "Comm. Med"];

    const filteredStudents = students.filter((stud) => {
        const matchesDept = selectedDept === "ALL" || stud.depts.includes(selectedDept);
        const matchesSearch = stud.name.toLowerCase().includes(search.toLowerCase()) || 
                             stud.classSec.toLowerCase().includes(search.toLowerCase());
        return matchesDept && matchesSearch;
    });

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
                            ? 'bg-white text-amber-600 shadow-sm'
                            : 'text-slate-500 hover:text-slate-700 hover:bg-slate-200/50'
                            }`}
                    >
                        {dept}
                    </button>
                ))}
            </div>

            <div className="relative w-full md:w-80 group">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400 group-focus-within:text-emerald-500 transition-colors" />
                <Input
                    value={search}
                    onChange={(e) => setSearch(e.target.value)}
                    placeholder="Search student by name or class..."
                    className="pl-10 h-10 bg-white border-slate-200 focus:ring-emerald-500/20 transition-all text-sm font-medium rounded-xl shadow-sm"
                />
            </div>
        </div>

            <div className="bg-white rounded-2xl shadow-sm border overflow-hidden transition-all duration-200 hover:shadow-md">
                <div className="overflow-x-auto">
                    <table className="w-full text-sm text-center">
                        <thead className="text-xs text-slate-500 bg-slate-50/80 uppercase border-b backdrop-blur-sm">
                            <tr>
                                <th className="px-6 py-4 font-bold text-center">Student Name</th>
                                <th className="px-6 py-4 font-bold text-center">Class/Sec</th>
                                <th className="px-6 py-4 font-bold text-center">Observation Sections</th>
                                <th className="px-6 py-4 font-bold text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {filteredStudents.length > 0 ? filteredStudents.map((stud) => (
                                <tr
                                    key={stud.id}
                                    onClick={() => router.push(`/poc/workspace/${eventId}/student/${stud.id}?from=observation`)}
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
                                                <span key={d} className="text-[9px] font-black bg-amber-50 text-amber-700 px-2.5 py-1 rounded-lg uppercase tracking-widest border border-amber-200/30">
                                                    {d}
                                                </span>
                                            ))}
                                        </div>
                                    </td>
                                    <td className="px-6 py-4 text-center">
                                        <span className="text-emerald-600 font-bold group-hover:text-emerald-700 transition flex items-center justify-center gap-2 uppercase text-[10px] tracking-widest">
                                            Open <Activity className="h-4 w-4" />
                                        </span>
                                    </td>
                                </tr>
                            )) : (
                                <tr>
                                    <td colSpan={4} className="py-20 text-center text-slate-500">
                                        <div className="flex flex-col items-center">
                                            <div className="inline-flex items-center justify-center h-14 w-14 rounded-full bg-slate-50 text-slate-300 mb-4 border border-slate-100">
                                                <Search className="h-7 w-7" />
                                            </div>
                                            <h3 className="text-sm font-bold text-slate-900 uppercase tracking-widest">No Observations Found</h3>
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
