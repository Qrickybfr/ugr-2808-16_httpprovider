# Student Grading System (HTTP & Provider)

A sophisticated Flutter application designed for teachers to manage and track student grades. This version implements state management using the **Provider** pattern and handles networking with the **HTTP** package, connecting to a unified REST API.

---

### 💡 Project Notes & Interaction
- **One URL Strategy**: Consolidates all data operations (GET, POST, PUT, DELETE) through a single endpoint (`/todos`). 
- **Developer Hint**: Since `jsonplaceholder` is a mock API, `POST`/`PUT` requests will return a success status, but the data won't persist on their servers. The app simulates persistence locally for the session.
- **Workflow**: 
    1.  **Dashboard**: Start here to navigate.
    2.  **View All**: Displays a randomized set of 5 students to simulate a "live class" view.
    3.  **Search**: Use IDs `1-10` for reliable mock data results.

---

## Key Features
- **Student Management**: Focuses on `studentId` as the primary identifier across the system.
- **Grading Dashboard**: 
  - **View Students Graded**: Interactive list view of current records.
  - **Search by Student ID**: Dedicated detail view for filtering specific student history.
  - **Add Student Grade**: Dynamic form to input student names and assignment titles.
- **Modern UI**: Clean, icon-free listing with bold status indicators (**DONE** vs **NOT DONE**).

## Implementation Details
- **Architecture**: Model-Service-Provider (MSP) structure.
- **State Management**: `GradeProvider` handles the business logic and UI synchronization.
- **Networking**: `ApiService` encapsulates RESTful calls to `jsonplaceholder.typicode.com`.
- **Theme**: Dark-themed Material design with a deep purple accent.

## Simple Summary
This app is built for simplicityand it uses **Provider** for state management and **HTTP** for network calls. It is lightweight, easy to maintain, and perfect for quick student data management. Any teacher can quickly add, view, or delete grades with zero setup time.

## Getting Started
1. Clone the repository.
2. Run `flutter pub get` to install dependencies (provider, http).
3. Connect an emulator or device.
4. Execute `flutter run`.
