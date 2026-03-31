import { Navbar } from "@/components/layout/Navbar";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Users, FileText, CalendarPlus, CheckCircle, XCircle, ArrowRight } from "lucide-react";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { getPendingRequests, getMedicalStaff } from "@/lib/actions/admin-actions";
import { prisma } from "@/lib/db/prisma";
import Link from "next/link";

import { RequestsTabClient } from "@/components/admin/RequestsTabClient";
import { EventsTabClient } from "@/components/admin/EventsTabClient";
import { CreateEventButton } from "@/components/admin/CreateEventButton";
import { StaffDirectoryClient } from "@/components/admin/directory/StaffDirectoryClient";
import { RealTimeRefresher } from "@/components/shared/RealTimeRefresher";

export default async function AdminDashboard() {
  const session = await getServerSession(authOptions);

  // Fetch real data from PostgreSQL
  const pendingRequests = await getPendingRequests();
  const medicalStaff = await getMedicalStaff();

  // Fetch active events for the All Events tab
  const allEvents = await prisma.event.findMany({
    orderBy: { eventDate: "asc" },
    include: {
      eventStaff: {
        include: { user: true }
      },
      _count: {
        select: { eventStaff: true, students: true }
      }
    }
  });

  // Map and Enrich
  const enrichedEvents = allEvents.map((event: any) => {
    const eventHeadId = (event.formConfig as any)?.eventHeadId;
    const eventHead = (event.eventStaff as any[]).find((s: any) => s.user.id === eventHeadId)?.user?.fullName || "Not Assigned";
    
    return {
      ...event,
      pocName: event.pocName, 
      eventHeadName: eventHead
    };
  });

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col">
      <RealTimeRefresher />
      <Navbar role={session?.user?.role || "ADMIN"} userName={session?.user?.name || "Admin User"} />

      <main className="flex-1 w-full max-w-7xl mx-auto p-4 md:p-8">
        <div className="flex justify-between items-center mb-6">
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-slate-900">Admin Portal</h1>
            <p className="text-slate-500">Manage health camps, users, and incoming requests.</p>
          </div>
          <CreateEventButton
            medicalStaff={medicalStaff}
          />
        </div>

        <Tabs defaultValue="requests" className="space-y-4">
          <TabsList className="bg-white border w-full justify-start h-14 p-0 rounded-md overflow-hidden">
            <TabsTrigger value="requests" className="h-full px-8 text-base data-[state=active]:!text-emerald-600 data-[state=active]:!font-semibold flex gap-2 rounded-none transition-all">
              <FileText className="h-5 w-5" /> Camp Requests
              {pendingRequests.length > 0 && (
                <Badge variant="destructive" className="ml-1 rounded-full px-1.5 h-5 bg-emerald-600 hover:bg-emerald-700 text-white border-0">
                  {pendingRequests.length}
                </Badge>
              )}
            </TabsTrigger>
            <TabsTrigger value="events" className="h-full px-8 text-base data-[state=active]:!text-emerald-600 data-[state=active]:!font-semibold flex gap-2 rounded-none transition-all">
              <CalendarPlus className="h-5 w-5" /> All Events
            </TabsTrigger>
            <TabsTrigger value="users" className="h-full px-8 text-base data-[state=active]:!text-emerald-600 data-[state=active]:!font-semibold flex gap-2 rounded-none transition-all">
              <Users className="h-5 w-5" /> Directory
            </TabsTrigger>
          </TabsList>

          <TabsContent value="requests" className="space-y-4 pt-4">
            <h2 className="text-xl font-semibold mb-4">Incoming Camp Requests</h2>
            <RequestsTabClient
              requests={pendingRequests}
              medicalStaff={medicalStaff}
            />
          </TabsContent>

          <TabsContent value="events" className="pt-4">
            <EventsTabClient events={enrichedEvents as any} />
          </TabsContent>

          <TabsContent value="users" className="pt-4">
            <StaffDirectoryClient 
              medicalStaff={medicalStaff as any} 
            />
          </TabsContent>
        </Tabs>
      </main>
    </div>
  );
}
