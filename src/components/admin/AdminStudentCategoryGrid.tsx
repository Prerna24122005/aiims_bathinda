"use client";

import { useState } from 'react';
import { Badge } from "@/components/ui/badge";
import { ArrowLeft, Clock, CheckCircle2, Activity, FileText, Syringe, Eye, Ear, Hand, Hammer, Syringe as Injection } from "lucide-react";
import Link from "next/link";
import { CategoryEditFormClient } from "@/components/staff/forms/CategoryEditForm";
import dynamic from 'next/dynamic';
import { ToothIcon } from "@/components/shared/ToothIcon";

// Map icon names to Lucide components
const CategoryIcon = ({ name, className }: { name: string, className?: string }) => {
    switch (name) {
        case 'FileText': return <FileText className={className} />;
        case 'Syringe': return <Injection className={className} />;
        case 'Eye': return <Eye className={className} />;
        case 'Ear': return <Ear className={className} />;
        case 'Hand': return <Hand className={className} />;
        case 'Activity': return <Activity className={className} />;
        case 'AlertCircle': return <Activity className={className} />;
        case 'Tooth': return <ToothIcon className={className} />;
        default: return <FileText className={className} />;
    }
};

interface CategoryStatus {
    id: string;
    title: string;
    iconName: string;
    status: string;
    data: any;
}

export function AdminStudentCategoryGrid({
    categoriesStatus,
    eventId,
    studentId,
    student,
    backTo,
    completionPercentage,
    globalStatus,
    userId,
    userName,
    formConfig
}: {
    categoriesStatus: CategoryStatus[];
    eventId: string;
    studentId: string;
    student: any;
    backTo: string;
    completionPercentage: number;
    globalStatus: string;
    userId: string;
    userName: string;
    formConfig?: any;
}) {
    const [activeTab, setActiveTab ] = useState<string>(categoriesStatus[0]?.id || "");
    const activeCat = categoriesStatus.find(c => c.id === activeTab) || categoriesStatus[0];

    const baseColors = 'bg-white text-slate-500 border-slate-200 hover:bg-slate-50';

    return (
        <div className="flex flex-col min-h-screen bg-slate-50/50">
            {/* STICKY COMPACT HEADER */}
            <div className="bg-white border-b sticky top-0 z-30 shadow-md backdrop-blur-md bg-white/95">
                <div className="max-w-4xl mx-auto px-4 sm:px-6 py-4">
                    <div className="flex items-start justify-between gap-6 mb-5">
                        <div className="flex items-center gap-4">
                            <Link href={backTo}>
                                <div className="h-10 w-10 flex items-center justify-center rounded-full border border-slate-200 hover:border-emerald-300 hover:bg-emerald-50 text-emerald-600 transition-all shadow-sm">
                                    <ArrowLeft className="h-5 w-5" />
                                </div>
                            </Link>
                            <div>
                                <h1 className="text-2xl sm:text-3xl font-black text-slate-900 leading-tight flex items-center gap-3">
                                    {student.firstName} {student.lastName}
                                    <Badge variant="outline" className={
                                        globalStatus === "COMPLETED" ? "bg-green-50 text-green-700 border-green-200" :
                                            globalStatus === "IN_PROGRESS" ? "bg-amber-50 text-amber-700 border-amber-200" :
                                                "bg-slate-100 text-slate-700 border-slate-200"
                                    }>
                                        {globalStatus.replace('_', ' ')}
                                    </Badge>
                                </h1>
                                <p className="text-xs font-bold text-slate-500 mt-1 uppercase tracking-wider flex flex-wrap gap-x-4">
                                    <span>Class: <span className="text-slate-900">{student.classSec}</span></span>
                                    <span>Age: <span className="text-slate-900">{student.age}</span></span>
                                    <span>Gender: <span className="text-slate-900">{student.gender}</span></span>
                                    {(() => {
                                        const recordData = (student?.medicalRecord?.data as Record<string, any>) || {};
                                        const genData = recordData.general_examination_merged || {};
                                        const h = parseFloat(genData.height);
                                        const w = parseFloat(genData.weight);
                                        const bmiStr = (h && w) ? (w / Math.pow(h / 100, 2)).toFixed(1) : "NA";
                                        return (
                                            <span className="text-emerald-600 font-black">BMI: <span className="text-emerald-700">{bmiStr}</span></span>
                                        );
                                    })()}
                                </p>
                            </div>
                        </div>

                        <div className="hidden md:block w-1/4">
                            <div className="flex justify-between text-[10px] font-black text-slate-400 mb-1 uppercase tracking-tighter">
                                <span>Audit Status</span>
                                <span className={completionPercentage === 100 ? 'text-green-600' : 'text-emerald-600'}>{completionPercentage}%</span>
                            </div>
                            <div className="w-full bg-slate-100 rounded-full h-2 overflow-hidden shadow-inner">
                                <div className={`h-full rounded-full transition-all duration-1000 ${completionPercentage === 100 ? 'bg-green-600' : 'bg-emerald-600'}`} style={{ width: `${completionPercentage}%` }}></div>
                            </div>
                        </div>
                    </div>

                    {/* CATEGORY ICON GRID */}
                    <div className="flex flex-wrap items-center gap-2 pt-2 border-t border-slate-100">
                        {categoriesStatus.map((cat) => {
                            const isActive = activeTab === cat.id;
                            
                            return (
                                <div 
                                    key={cat.id} 
                                    title={cat.title}
                                    onClick={() => setActiveTab(cat.id)}
                                    className={`relative group h-12 w-12 sm:h-13 sm:w-13 flex items-center justify-center rounded-xl border-2 transition-all cursor-pointer shadow-sm
                                        ${baseColors} 
                                        ${isActive ? 'ring-2 ring-emerald-500 scale-110 z-10 border-emerald-500 bg-emerald-50 text-emerald-600 shadow-md' : 'hover:scale-105 active:scale-95'}
                                        ${(cat.data?.status_nor === 'R' || cat.data?.status_nor === 'O') ? 'border-red-500 border-[3px] shadow-[0_0_10px_rgba(239,68,68,0.3)] animate-pulse-subtle' : ''}
                                    `}
                                >
                                    <CategoryIcon name={cat.iconName} className={`h-6 w-6 sm:h-6.5 sm:w-6.5 ${isActive ? 'text-emerald-600' : ''} ${(cat.data?.status_nor === 'R' || cat.data?.status_nor === 'O') ? 'text-red-600' : ''}`} />
                                    
                                    {/* Completion status badges hidden for a clean read-only Admin look */}

                                    {/* Red indicator for R/O status */}
                                    {(cat.data?.status_nor === 'R' || cat.data?.status_nor === 'O') && (
                                        <div className="absolute -top-1 -right-1 bg-red-600 rounded-full border border-white px-1 shadow-sm flex items-center justify-center min-w-[14px] h-[14px]">
                                            <span className="text-[8px] font-black text-white">{cat.data.status_nor}</span>
                                        </div>
                                    )}

                                    {/* Section Name Tooltip */}
                                    <div className="absolute -bottom-10 left-1/2 -translate-x-1/2 bg-slate-900/90 text-white text-[10px] font-black px-2 py-1 rounded backdrop-blur-sm opacity-0 group-hover:opacity-100 pointer-events-none transition-opacity whitespace-nowrap z-40 shadow-xl border border-white/10 uppercase tracking-tighter">
                                        {cat.title}
                                    </div>
                                </div>
                            );
                        })}
                    </div>
                </div>
            </div>

            {/* SCROLLABLE CONTENT AREA - SHOWING THE ACTIVE FORM */}
            <main className="flex-1 w-full max-w-4xl mx-auto px-4 sm:px-6 py-6 pb-20">
                {activeTab ? (
                    <div className="bg-white rounded-3xl shadow-xl border border-slate-200 overflow-hidden min-h-[400px]">
                        <CategoryEditFormClient
                            eventId={eventId}
                            studentId={studentId}
                            category={activeTab}
                            initialData={activeCat?.data || {}}
                            isReadOnly={true}
                            readOnlyReason="You are viewing this medical record in high-level audit mode (Read-Only)."
                            userId={userId}
                            userName={userName}
                            student={student}
                            isPOC={false}
                            isEmbedded={true}
                            requiredFields={formConfig?.[activeTab] || []}
                            customCategoryBlock={(() => {
                                const customCategories = Array.isArray(formConfig?.customCategories) ? formConfig.customCategories : [];
                                return customCategories.find((c: any) => c.id === activeTab);
                            })()}
                        />
                    </div>
                ) : (
                    <div className="bg-white rounded-3xl p-12 text-center border-2 border-dashed border-slate-200 flex flex-col items-center justify-center min-h-[400px]">
                        <Activity className="h-16 w-16 text-slate-200 mb-4" />
                        <h3 className="text-xl font-black text-slate-400 uppercase tracking-widest leading-none">Select a category</h3>
                        <p className="text-slate-400/60 font-bold mt-2">Choose a medical section from above to review</p>
                    </div>
                )}
            </main>
        </div>
    );
}

