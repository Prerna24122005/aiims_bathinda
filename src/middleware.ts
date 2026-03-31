import { withAuth } from "next-auth/middleware";
import { NextResponse } from "next/server";

export default withAuth(
  function middleware(req) {
    const { pathname } = req.nextUrl;
    const { token } = req.nextauth;

    // Route Protection Logic
    if (pathname.startsWith("/admin") && token?.role !== "ADMIN") {
      return NextResponse.redirect(new URL("/staff/dashboard", req.url));
    }

    if (pathname.startsWith("/staff") && token?.role === "ADMIN") {
      // Admins likely want to go to their own dashboard, not staff dashboard
      return NextResponse.redirect(new URL("/admin/dashboard", req.url));
    }

    return NextResponse.next();
  },
  {
    callbacks: {
      authorized: ({ token }) => !!token,
    },
  }
);

export const config = {
  matcher: ["/admin/:path*", "/staff/:path*"],
};
