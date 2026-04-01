"use client";

import { CalendarDays, ArrowRight } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Card } from "@/components/ui/card";
import Link from "next/link";
import { RealTimeRefresher } from "@/components/shared/RealTimeRefresher";

type AssignedEventType = {
    id: string;
    schoolName: string;
    date: Date;
    location: string;
    status: string;
    studentCount: number;
    referredCount: number;
    pocName: string;
    eventHeadName: string;
};

export function PocEventsClient({ events }: { events: AssignedEventType[] }) {
    return (
        <div className="space-y-6">
            <RealTimeRefresher />
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <h2 className="text-xl font-semibold text-gray-800">Your School Camps</h2>
            </div>

            {events.length === 0 ? (
                <div className="col-span-full text-center py-16 bg-white rounded-xl border border-dashed text-slate-500 bg-slate-50/50">
                    <CalendarDays className="h-16 w-16 mx-auto mb-6 text-slate-300" />
                    <h3 className="text-xl font-bold text-slate-900 mb-2">No Events Found</h3>
                    <p className="text-slate-600 max-w-sm mx-auto">
                        You currently have no health camp events assigned to your email address.
                    </p>
                </div>
            ) : (
                <div className="flex flex-col gap-3">
                    {events.map(event => (
                        <Link href={`/poc/workspace/${event.id}`} key={event.id} className="group">
                            <Card className="flex flex-col sm:flex-row items-start sm:items-center justify-between p-2 sm:p-2 border border-slate-200 hover:border-emerald-300 hover:shadow-md transition-all duration-200 bg-white rounded-xl overflow-hidden relative">
                                <div className={`absolute left-0 top-0 bottom-0 w-1 ${event.status === "ACTIVE" ? 'bg-emerald-500' : event.status === "PAST" ? 'bg-slate-300' : 'bg-emerald-500'}`} />

                                <div className="flex flex-col sm:flex-row sm:items-center gap-4 sm:gap-6 flex-1 pl-3 w-full">
                                    <div className="min-w-[140px]">
                                        <Badge className={`px-2 py-0 text-[10px] font-semibold rounded-full border ${event.status === "ACTIVE"
                                            ? 'bg-emerald-100 text-emerald-800 border-emerald-200 hover:bg-emerald-200'
                                            : event.status === "PAST"
                                                ? 'bg-slate-100 text-slate-600 border-slate-200 hover:bg-slate-200'
                                                : 'bg-emerald-100 text-emerald-800 border-emerald-200 hover:bg-emerald-200'
                                            }`}>
                                            {event.status}
                                        </Badge>
                                        <p className="text-xs font-semibold text-slate-500 flex items-center gap-1.5 mt-0.5">
                                            {event.date.toLocaleDateString("en-US", { month: 'short', day: 'numeric', year: 'numeric' })}
                                        </p>
                                    </div>

                                    <div className="flex-1 min-w-0">
                                        <h3 className="text-lg font-bold text-slate-900 group-hover:text-emerald-700 transition-colors truncate">
                                            {event.schoolName}
                                        </h3>
                                        <div className="flex flex-wrap gap-x-4 gap-y-1 mt-0.5 font-medium uppercase tracking-tighter text-[11px]">
                                            <div className="flex items-center gap-1 text-slate-500">
                                                <span className="text-emerald-600">POC:</span>
                                                <span className="text-slate-700 truncate max-w-[120px]">{event.pocName}</span>
                                            </div>
                                            <div className="flex items-center gap-1 text-slate-500">
                                                <span className="text-amber-600">Head:</span>
                                                <span className="text-slate-700 truncate max-w-[120px]">{event.eventHeadName}</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div className="flex items-center gap-6 mt-3 sm:mt-0 w-full sm:w-auto justify-between sm:justify-end bg-slate-50 sm:bg-transparent p-3 sm:p-0 rounded-lg sm:rounded-none pr-4">
                                        {event.referredCount > 0 && (
                                            <div onClick={e => e.stopPropagation()}>
                                                <span className="inline-flex items-center cursor-default text-[10px] sm:text-xs font-bold text-red-700 bg-red-50 px-2 py-1 sm:px-2.5 sm:py-1.5 rounded-full border border-red-200">
                                                    {event.referredCount} Referred
                                                </span>
                                            </div>
                                        )}

                                        <div className="w-px h-4 sm:h-6 bg-slate-200 hidden sm:block"></div>

                                        <div className="flex items-center gap-2">
                                            <div className="flex items-center gap-1.5">
                                                <span className="text-[10px] sm:text-xs text-slate-400 font-medium uppercase tracking-wider">Students:</span>
                                                <span className="text-sm font-bold text-slate-700">{event.studentCount}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div className="hidden sm:flex items-center justify-center p-2 ml-4">
                                    <div className="bg-slate-50 p-2 rounded-full group-hover:bg-emerald-50 group-hover:text-emerald-600 text-slate-300 transition-colors">
                                        <ArrowRight className="h-5 w-5 group-hover:translate-x-1 transition-transform" />
                                    </div>
                                </div>
                            </Card>
                        </Link>
                    ))}
                </div>
            )}
        </div>
    );
}
