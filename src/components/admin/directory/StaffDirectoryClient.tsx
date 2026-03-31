"use client";

import { useState } from "react";
import { Users, Mail, LayoutGrid, List, Search } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { AddUserButton } from "@/components/admin/directory/AddUserButton";
import { DeleteUserButton } from "@/components/admin/directory/DeleteUserButton";

type StaffType = {
  id: string;
  fullName: string;
  email: string;
  role: string;
};

export function StaffDirectoryClient({
  medicalStaff
}: {
  medicalStaff: StaffType[];
}) {
  const [searchQuery, setSearchQuery] = useState("");
  const [viewMode, setViewMode] = useState<"grid" | "list">("list");

  const filteredStaff = medicalStaff.filter(staff => {
    const srch = searchQuery.toLowerCase();
    if (!srch) return true;
    return (
      staff.fullName.toLowerCase().includes(srch) ||
      staff.email.toLowerCase().includes(srch)
    );
  });

  return (
    <div className="space-y-6">
      <div className="flex flex-col lg:flex-row justify-between items-start lg:items-center gap-4 bg-white p-4 rounded-xl shadow-sm border border-slate-100">
        <h2 className="text-xl font-bold text-slate-900 flex items-center gap-2">
          <Users className="h-5 w-5 text-emerald-600" /> Medical Staff Directory
        </h2>

        <div className="flex flex-col sm:flex-row items-center gap-3 w-full lg:w-auto">
          <div className="relative w-full sm:w-auto">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
            <Input
              type="text"
              placeholder="Search by name or email..."
              className="pl-10 w-full sm:w-64 bg-slate-50 border-slate-200 focus-visible:ring-emerald-500 rounded-full"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>

          <div className="w-px h-8 bg-slate-200 hidden sm:block mx-1"></div>

          <div className="flex bg-slate-100 p-1 rounded-full border border-slate-200 w-full sm:w-auto justify-center">
            <Button
              variant="ghost"
              size="sm"
              onClick={() => setViewMode("grid")}
              className={`rounded-full px-4 flex items-center gap-2 ${viewMode === "grid" ? 'bg-white shadow-sm text-emerald-600 font-medium' : 'text-slate-500 hover:text-slate-900'}`}
            >
              <LayoutGrid className="h-4 w-4" />
              <span className="hidden sm:inline">Grid</span>
            </Button>
            <Button
              variant="ghost"
              size="sm"
              onClick={() => setViewMode("list")}
              className={`rounded-full px-4 flex items-center gap-2 ${viewMode === "list" ? 'bg-white shadow-sm text-emerald-600 font-medium' : 'text-slate-500 hover:text-slate-900'}`}
            >
              <List className="h-4 w-4" />
              <span className="hidden sm:inline">List</span>
            </Button>
          </div>

          <div className="w-px h-8 bg-slate-200 hidden sm:block mx-1"></div>

          <AddUserButton />
        </div>
      </div>

      {filteredStaff.length === 0 ? (
        <Card className="p-16 text-center text-slate-500 border-dashed border-2 bg-slate-50/50">
          <Users className="h-16 w-16 mx-auto mb-6 text-slate-300" />
          <h3 className="text-xl font-bold text-slate-900 mb-2">
            {medicalStaff.length === 0 ? "Directory Empty" : "No Staff Found"}
          </h3>
          <p className="text-slate-600 max-w-sm mx-auto">
            {medicalStaff.length === 0
              ? "No medical staff available. Add users so you can assign them to events."
              : "We couldn't find any staff members matching your search."}
          </p>
        </Card>
      ) : viewMode === "grid" ? (
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          {filteredStaff.map(staff => (
            <Card key={staff.id} className="group overflow-hidden border border-slate-200 hover:border-emerald-300 hover:shadow-xl transition-all duration-300 bg-white rounded-xl">
              <CardHeader className="p-6 text-center pb-0">
                <div className="mx-auto h-20 w-20 rounded-full bg-gradient-to-br from-emerald-100 to-emerald-50 border-4 border-white shadow-sm flex items-center justify-center mb-4 group-hover:scale-105 transition-transform duration-300">
                  <span className="text-3xl font-bold text-emerald-700">{staff.fullName.charAt(0)}</span>
                </div>
                <CardTitle className="text-xl font-bold text-slate-900 group-hover:text-emerald-600 transition-colors">
                  {staff.fullName}
                </CardTitle>
              </CardHeader>
              <CardContent className="p-6 pt-4">
                <div className="flex items-center gap-2">
                  <div className="bg-slate-50 rounded-lg p-3 border border-slate-100 flex items-center justify-center gap-2 group-hover:bg-emerald-50/50 transition-colors flex-1">
                    <Mail className="h-4 w-4 text-slate-400 group-hover:text-emerald-500 transition-colors" />
                    <span className="text-sm font-medium text-slate-600 truncate">{staff.email}</span>
                  </div>
                  <DeleteUserButton userId={staff.id} userName={staff.fullName} />
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      ) : (
        <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
          <div className="grid grid-cols-[minmax(250px,1fr)_minmax(200px,1fr)_160px] items-center px-6 py-4 bg-slate-50 border-b border-slate-100 text-xs font-semibold uppercase tracking-wider text-slate-500">
            <div>Staff Member</div>
            <div>Email Address</div>
            <div className="text-center">Actions</div>
          </div>
          <div className="divide-y divide-slate-100">
            {filteredStaff.map(staff => (
              <div key={staff.id} className="grid grid-cols-[minmax(250px,1fr)_minmax(200px,1fr)_160px] items-center px-6 py-4 hover:bg-slate-50/80 transition-colors group">
                <div className="flex items-center gap-4">
                  <div className="h-10 w-10 rounded-full bg-emerald-100 text-emerald-700 font-bold flex items-center justify-center shadow-sm border border-emerald-50 group-hover:bg-emerald-600 group-hover:text-white transition-colors">
                    {staff.fullName.charAt(0)}
                  </div>
                  <span className="font-bold text-slate-900 group-hover:text-emerald-600 transition-colors">
                    {staff.fullName}
                  </span>
                </div>
                <div className="flex items-center gap-2 text-slate-600">
                  <Mail className="h-4 w-4 text-slate-400" />
                  <span className="truncate">{staff.email}</span>
                </div>
                <div className="flex items-center justify-center">
                  <DeleteUserButton userId={staff.id} userName={staff.fullName} />
                </div>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
