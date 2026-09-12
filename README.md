# Raintech Hotel — Room Booking (Flutter Web)

**Candidate:** Amos P Alex  
**Stack:** Flutter Web (`flutter_bloc`, `equatable`, `intl`)  
**Design Reference:** Raintech Hotel Management System Dashboard

---

## 🏨 Overview
This project is a high-performance, single-page Hotel Room Booking application built in Flutter Web. It translates the visual identity and layout patterns of the Raintech Hotel dashboard into an interactive guest reservation flow with robust date validation, dynamic pricing calculation, and real-time reservation conflict detection.

---

## 📐 Architecture & Folder Structure

The application follows clean architecture principles with feature-based modularity:

```
lib/
├── main.dart                                   # App entry point, Provider setup & theme
├── core/
│   ├── theme/
│   │   └── app_theme.dart                      # Design tokens: palette, typography, shadows
│   └── utils/
│       └── date_validators.dart                # Pure validation, conflict & pricing math
└── features/
    └── booking/
        ├── domain/
        │   ├── room.dart                       # Room entity & RoomType definitions
        │   ├── booking_selection.dart          # Selection models & metadata
        │   └── booking_repository.dart         # Repository interface & BookingRecord
        ├── data/
        │   └── mock_room_repository.dart       # Mock inventory across Floor 1 & Floor 2
        ├── bloc/
        │   ├── booking_cubit.dart              # Cubit state manager
        │   └── booking_state.dart              # Immutable state with Equatable
        └── presentation/
            ├── booking_screen.dart             # Responsive page orchestrator
            └── widgets/
                ├── header_bar.dart             # Raintech hotel branding, search & actions
                ├── date_picker_row.dart        # Date selectors, guest count & category filters
                ├── room_grid.dart              # Interactive floor view (Floor 1 & 2)
                ├── booking_summary_card.dart   # Pricing breakdown & inline warning banner
                └── booking_success_dialog.dart # Reservation confirmation receipt
```

---

## 🎨 Design Reference & Visual Language

- **Color System:**
  - Canvas: Warm light-beige background (`#F5EFE6`).
  - Surface: Crisp white rounded cards with soft borders (`#E6DFD5`) and subtle diffused box shadows.
  - Primary: Deep Executive Navy (`#132B45`) for primary actions, header badges, and selected highlights.
  - Luxury Gold Accent: (`#D4AF37` / `#FBBF24`) for room badges and active highlights.
  - Status Indicators: Mint Green (`#2E7D32`) for available rooms, Coral Red (`#C62828`) for booked conflicts, and Amber (`#D97706`) for validation warnings.
- **Interactive Floor View:**
  - Rooms organized by **Floor 1** and **Floor 2** in an interactive grid view matching the dashboard's "Room Status — Interactive Floor View".
  - Color-coded badges for room categories (`Standard`, `Deluxe`, `Executive Suite`, `Family Suite`).
  - Real-time conflict checks flag occupied/reserved rooms for the selected date range.
- **Summary & Checkout Panel:**
  - Styled after the "Finalize Check-in & Payment" panel from the reference screenshots.
  - Automatic line-item breakdown: room charges, 12% GST tax calculation, stay duration, and grand total.
  - Inline amber warning banners for validation feedback (e.g., past dates, same-day checkout, booking conflicts, guest count exceeding capacity).

---

## 🧪 Pure Functions & Business Logic

All calculation and date validation rules are isolated in pure functions within `lib/core/utils/date_validators.dart`:
- `calculateNights(checkIn, checkOut)`: Computes calendar day difference (returns 0 for same-day or invalid ranges).
- `calculateTotal(pricePerNight, nights, {taxRate})`: Calculates room charge, tax rate (12% GST), and grand total.
- `validateDates(checkIn, checkOut, {referenceNow})`: Ensures check-in is not in the past, checkout is strictly after check-in, and maximum duration limits.
- `hasBookingConflict(roomId, checkIn, checkOut, existingBookings)`: Interval overlap verification: `checkIn < existingEnd && checkOut > existingStart`.

---

## 🚀 Getting Started

### 1. Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.13+ or higher)
- Google Chrome (or any modern web browser)

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run on Web
```bash
flutter run -d chrome
```

### 4. Run Automated Tests
```bash
flutter test
```

### 5. Run Analyzer
```bash
flutter analyze
```

---

## 📋 Features Checklist

- [x] **Project Scaffolding:** Clean feature-based directory structure with `flutter_bloc` & `equatable`.
- [x] **Domain Models:** `Room`, `RoomType`, `BookingSelection`, `BookingRecord`.
- [x] **Mock Inventory:** Multi-floor room data (Floor 1 & Floor 2) with amenities, pricing, and capacities.
- [x] **Pure Math & Date Logic:** Zero-dependency calculation algorithms with unit test coverage.
- [x] **State Management:** `BookingCubit` handling reactive selection, validation, filtering, and conflicts.
- [x] **Unit & Bloc Tests:** 100% passing test suite for edge cases, pricing mathematics, state emissions, and conflict checks.
- [x] **Raintech Hotel UI:** High-fidelity implementation matching provided dashboard screenshots.
- [x] **Bonus Features:** Booking conflict detection against reservations and dynamic guest/category filters.
