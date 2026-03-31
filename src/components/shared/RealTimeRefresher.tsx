"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";

interface RealTimeRefresherProps {
  /**
   * Interval in milliseconds for polling.
   * Default is 5000ms (5 seconds).
   */
  interval?: number;
}

/**
 * RealTimeRefresher component that periodically refreshes the current route.
 * This triggers a re-fetch of server component data in Next.js.
 */
export function RealTimeRefresher({ interval = 5000 }: RealTimeRefresherProps) {
  const router = useRouter();

  useEffect(() => {
    if (interval <= 0) return;

    const timer = setInterval(() => {
      router.refresh();
    }, interval);

    return () => {
      clearInterval(timer);
    };
  }, [router, interval]);

  return null;
}
