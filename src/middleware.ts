import { withAuth } from "next-auth/middleware";
import { NextResponse } from "next/server";

export default withAuth(
  function middleware(req) {
    const { pathname } = req.nextUrl;
    const { token } = req.nextauth;

    // Route Protection Logic
    if (pathname.startsWith("/admin") && token?.role !== "ADMIN") {
      if (token?.role === "SCHOOL_POC") return NextResponse.redirect(new URL("/poc/dashboard", req.url));
      return NextResponse.redirect(new URL("/staff/dashboard", req.url));
    }

    if (pathname.startsWith("/staff")) {
      if (token?.role === "ADMIN") {
        return NextResponse.redirect(new URL("/admin/dashboard", req.url));
      }
      if (token?.role === "SCHOOL_POC") {
        return NextResponse.redirect(new URL("/poc/dashboard", req.url));
      }
    }

    if (pathname.startsWith("/poc") && token?.role !== "SCHOOL_POC") {
      if (token?.role === "ADMIN") return NextResponse.redirect(new URL("/admin/dashboard", req.url));
      return NextResponse.redirect(new URL("/staff/dashboard", req.url));
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
  matcher: ["/admin/:path*", "/staff/:path*", "/poc/:path*"],
};
