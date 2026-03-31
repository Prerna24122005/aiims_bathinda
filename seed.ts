import * as bcryptjs from "bcryptjs";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  console.log("Seeding database with minimal test data...");

  // 1. Create Core Users
  const users = [
    {
      "email": "admin@healthcamp.org",
      "passwordHash": "$2b$10$FHwsYr.rhOj9Jamcvc2izuxfoX1Hd/.RHXJMrTK4P4QiGju5oAvyC", // admin123
      "fullName": "System Admin",
      "role": "ADMIN",
      "isActive": true
    },
    {
      "email": "prerna@gmail.com",
      "passwordHash": "$2b$10$g6twnc3.aRQTvlxK0S3njuY5j2IO76enmoimlZy1pjONsCpPSYfWa", // prerna123
      "fullName": "Prerna Gupta",
      "role": "MEDICAL_STAFF",
      "isActive": true
    },
    {
      "email": "dr.sarah@healthcamp.org",
      "passwordHash": "$2b$10$CIctCidB3Ek9I2NgSSrlb.8Thl1n3wy0RNXj0BT/VtXg7Ky9jCfsa", // sarah123
      "fullName": "Dr. Sarah",
      "role": "MEDICAL_STAFF",
      "isActive": true
    }
  ];

  for (const user of users) {
    await prisma.user.upsert({
      where: { email: user.email },
      update: {},
      create: user as any,
    });
  }

  // 2. Create Sample HealthCampRequests
  const requests = [
    {
      "schoolName": "Greenwood High School",
      "pocName": "Jane Doe",
      "pocEmail": "director@gmail.com",
      "pocPhone": "555-0100",
      "tentativeDate": new Date("2026-10-24"),
      "tentativeStudents": 400,
      "status": "ACCEPTED",
    },
    {
      "schoolName": "Sophia Girls School",
      "pocName": "Pihu Gupta",
      "pocEmail": "pihu@gmail.com",
      "pocPhone": "+918619252566",
      "tentativeDate": new Date("2026-03-28"),
      "tentativeStudents": 150,
      "status": "PENDING",
    }
  ];

  for (const request of requests) {
    await prisma.healthCampRequest.create({
      data: request as any,
    });
  }

  // 3. Create Sample Events
  const admin = await prisma.user.findUnique({ where: { email: "admin@healthcamp.org" } });

  const events = [
    {
      "schoolDetails": "Greenwood High School",
      "eventDate": new Date("2026-10-24"),
      "pocName": "Jane Doe",
      "pocPhone": "555-0100",
      "pocEmail": "director@gmail.com",
      "status": "ACTIVE",
      "formConfig": {
        "ent": ["hearing", "earExam"],
        "communityMed": ["height", "weight", "doctorRemarks"]
      },
      "createdBy": admin?.id
    },
    {
      "schoolDetails": "IIT ROPAR",
      "eventDate": new Date("2026-11-15"),
      "pocName": "Mitali",
      "pocPhone": "2344555",
      "pocEmail": "mitali@gmail.com",
      "status": "UPCOMING",
      "formConfig": {
        "vitalsSystemic": ["height", "weight", "signDoctor"]
      },
      "createdBy": admin?.id
    }
  ];

  for (const event of events) {
    await prisma.event.create({
      data: event as any,
    });
  }

  // 3.5 Create School POC Users from events
  const allEvents = await prisma.event.findMany();
  for (const event of allEvents) {
    if ((event as any).pocEmail) {
      const password = (event as any).pocEmail.split('@')[0];
      const passwordHash = await bcryptjs.hash(password, 10);
      await prisma.user.upsert({
        where: { email: (event as any).pocEmail },
        update: {},
        create: {
          email: (event as any).pocEmail,
          passwordHash: passwordHash,
          fullName: event.pocName,
          role: "SCHOOL_POC" as any,
        },
      });
    }
  }

  // 4. Create EventStaff Assignments
  const prerna = await prisma.user.findUnique({ where: { email: "prerna@gmail.com" } });
  const sarah = await prisma.user.findUnique({ where: { email: "dr.sarah@healthcamp.org" } });
  const greenwood = await prisma.event.findFirst({ where: { schoolDetails: "Greenwood High School" } });

  if (greenwood && prerna && sarah) {
    await prisma.eventStaff.create({
      data: { eventId: greenwood.id, userId: prerna.id }
    });
    await prisma.eventStaff.create({
      data: { eventId: greenwood.id, userId: sarah.id }
    });
  }

  // 5. Create Students
  if (greenwood) {
    const students = [
      { firstName: "Alice", lastName: "Johnson", classSec: "10-A", age: 15, gender: "FEMALE", eventId: greenwood.id },
      { firstName: "Bob", lastName: "Smith", classSec: "10-B", age: 14, gender: "MALE", eventId: greenwood.id }
    ];
    for (const student of students) {
      await prisma.student.create({ data: student as any });
    }
  }

  // 6. Create Sample Medical Record
  const alice = await prisma.student.findFirst({ where: { firstName: "Alice" } });
  if (alice && greenwood) {
    await prisma.medicalRecord.create({
      data: {
        studentId: alice.id,
        eventId: greenwood.id,
        status: "IN_PROGRESS",
        data: {
          ent: { hearing: "Normal", earExam: "Healthy" },
          communityMed: { height: "160", weight: "50" }
        }
      }
    });
  }

  console.log("Seeding finished successfully.");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
