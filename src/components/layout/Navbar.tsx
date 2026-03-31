"use client";

import Link from 'next/link';
import { LogOut, HeartPulse } from 'lucide-react';
import { signOut } from 'next-auth/react';
import { Button } from '@/components/ui/button';

export function Navbar({ role, userName }: { role: string; userName: string }) {
  return (
    <nav className="border-b bg-white shadow-sm">
      <div className="flex h-16 items-center px-4 md:px-6">
        <Link href={role === 'ADMIN' ? '/admin/dashboard' : '/staff/dashboard'} className="font-extrabold text-2xl text-slate-900 tracking-tight flex items-center gap-2">
          <HeartPulse className="h-7 w-7 text-emerald-600" />
          HealthCamp<span className="text-emerald-600">Pro</span>
        </Link>
        <div className="ml-auto flex items-center space-x-4">
          <div className="flex flex-col items-end mr-4 hidden md:flex">
            <div className="text-sm font-bold text-slate-900">
              {userName}
            </div>
            <div className={`text-[10px] font-black uppercase tracking-wider px-1.5 py-0.5 rounded ${role === 'ADMIN' ? 'bg-red-100 text-red-700' : 'bg-emerald-100 text-emerald-700'
              }`}>
              {role.replace('_', ' ')}
            </div>
          </div>
          <div className="h-9 w-9 rounded-full bg-slate-100 text-slate-700 font-bold flex items-center justify-center border border-slate-200">
            {userName.charAt(0).toUpperCase()}
          </div>
          <Button variant="ghost" size="sm" onClick={() => signOut({ callbackUrl: '/' })} className="text-slate-500 hover:text-red-600 hover:bg-red-50">
            <LogOut className="h-4 w-4 mr-2" />
            Logout
          </Button>
        </div>
      </div>
    </nav>
  );
}
