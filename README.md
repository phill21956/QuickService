# QuickService

A simple Flutter application that allows users to browse service providers, search by name, and book a service by selecting a date, time slot, and duration.  
This project was completed as part of a 2-hour Flutter developer technical assessment.

---

## 🕒 Time Spent
Approximately **2 hours**.

---

## 🧩 State Management Approach (GetX)
I used **GetX** for state management due to its simplicity, minimal boilerplate, and reactive programming model.  
GetX allowed clean separation between UI and logic, while enabling fast UI updates without unnecessary rebuilds.

- `ProviderController` manages provider list, search filtering, and loading state.  
- `BookingController` manages date selection, time slots, unavailable slots, duration, and dynamic price calculation.

---

## 📱 Features Implemented

### ✅ Provider List Screen
- Displays list of 8–10 mock service providers  
- Circular profile image  
- Rating, hourly rate, and verification badge  
- Search bar with case-insensitive filtering  
- Loading state with delay  
- Book button navigates to booking screen  
- Clean UI, responsive layout  

### ✅ Booking Screen
- Provider summary card  
- Date selector (next 7 days)  
- Time slot selector (6 slots, 2–3 unavailable slots)  
- Duration selector  
- Dynamic total price  
- Confirm booking button (enabled when date + time selected)  
- Success dialog with booking summary  
- All logic handled via GetX  

---

## 📂 Project Structure
lib/
├─ controllers/
│ ├─ provider_controller.dart
│ └─ booking_controller.dart
│
├─ models/
│ └─ provider_model.dart
│
├─ screens/
│ ├─ provider_list_screen.dart
│ └─ booking_screen.dart
│
├─ widgets/
│ └─ provider_card.dart
├─ utils/
│ └─ colorConstant.dart
│ └─ date_util.dart
│ └─ loader.dart
│
└─ main.dart

---

### ✅ Setup Instructions
- Clone repository
- Run `flutter pub get` 
- Run `flutter run`

  ---

