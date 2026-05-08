# Health Camp Platform

A comprehensive web application for managing health camps in schools, built with modern technologies for efficient administration and real-time medical record management.

##  Project Overview

The Health Camp Platform is designed to streamline the organization and management of health camps conducted in schools by medical institutions like AIIMS Bathinda. It enables seamless coordination between school point of contacts (POCs), medical staff, administrators, and students to manage medical examinations, record health data, and generate reports.

### Key Objectives
- Centralized management of school health camps
- Digital medical record keeping for students
- Real-time staff assignment and event management
- Secure medical data handling and audit logging
- Analytics and reporting capabilities

---

##  Features

### Admin Dashboard
- **Event Management**: Create, manage, and track health camp events
- **Staff Assignment**: Assign medical staff to events with conflict detection
- **Student Roster Management**: View and manage student medical records
- **Event Head Assignment**: Designate event leaders
- **Analytics Dashboard**: View event statistics, completion rates, and trends
- **Request Management**: Handle and approve school health camp requests
- **Staff Directory**: Manage medical staff and their departments

### Staff Workspace
- **Student Medical Records**: Complete comprehensive medical examinations for students
- **Form Configuration**: Flexible form fields based on event requirements
- **Record Status Tracking**: Track pending, in-progress, and completed records
- **Referral Management**: Generate referral slips for students requiring specialist consultation
- **Lab Test & Prescription Management**: Add lab investigations and medical prescriptions
- **Audit Logging**: Complete history of record modifications

### School POC Dashboard
- **Event Overview**: View assigned health camps
- **Student List Management**: Manage school's student roster
- **Record Monitoring**: Monitor medical examination progress
- **Report Generation**: Access student medical reports
- **Referral Tracking**: Track referred students

### Security & Access Control
- **Role-Based Access Control**: Admin, Medical Staff, and School POC roles
- **Authentication**: Secure login with NextAuth.js
- **Password Management**: Reset and change password functionality
- **Audit Trail**: Complete logging of all user actions and data modifications

---

##  Tech Stack

### Frontend
- **Framework**: Next.js 16 (React 19)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **UI Components**: Shadcn/ui + Custom components
- **State Management**: React hooks
- **Icons**: Lucide React
- **Charts**: Recharts, D3.js

### Backend
- **Runtime**: Node.js with Next.js API routes
- **Database**: PostgreSQL
- **ORM**: Prisma
- **Authentication**: NextAuth.js
- **Email**: Nodemailer
- **Password Hashing**: bcryptjs

### Development Tools
- **Build Tool**: Next.js
- **Linting**: ESLint
- **Type Checking**: TypeScript
- **Package Manager**: npm

---

##  Prerequisites

Before setting up the project, ensure you have:

- **Node.js**: v18 or higher
- **npm**: v9 or higher (or yarn/pnpm)
- **PostgreSQL**: v12 or higher
- **Git**: For version control
- **.env file**: With necessary environment variables

---

##  Installation & Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd aiims_bathinda
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Set Up Environment Variables
Create a `.env.local` file in the root directory with the following variables:

```env
# Database
DATABASE_URL="postgresql://user:password@localhost:5432/health_camp_db"

# NextAuth Configuration
NEXTAUTH_SECRET="your-secret-key-here"
NEXTAUTH_URL="http://localhost:3000"

# Email Configuration (for password reset)
EMAIL_HOST="smtp.gmail.com"
EMAIL_PORT="587"
EMAIL_USER="your-email@gmail.com"
EMAIL_PASSWORD="your-app-password"
EMAIL_FROM="noreply@healthcamp.com"

# Application
NEXT_PUBLIC_APP_NAME="Health Camp Platform"
NODE_ENV="development"
```

### 4. Set Up the Database

#### Initialize Prisma and Create Database
```bash
# Generate Prisma client
npx prisma generate

# Create the database schema
npx prisma migrate dev --name init

# (Optional) Seed the database with sample data
npx prisma db seed
```

### 5. Run the Development Server
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser to access the application.


## User Roles & Permissions

### 1. **Administrator**
- Create and manage health camp events
- Assign medical staff to events
- Monitor all medical records and examination progress
- Access analytics and reporting
- Manage school POCs and staff members
- Approve health camp requests

### 2. **Medical Staff**
- View assigned events and student rosters
- Complete medical examinations for students
- Add observations, referrals, prescriptions, and lab tests
- Generate medical reports
- Track record completion status
- Cannot delete or modify already submitted records

### 3. **School POC (Point of Contact)**
- Submit health camp requests
- View assigned events and student information
- Monitor medical examination progress
- Access generated reports
- Upload student lists



**Version**: 0.1.0
