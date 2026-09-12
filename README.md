# Raintech Hotel Management Suite (Flutter Web)

**Candidate:** Amos P Alex  
**Stack:** Flutter Web (`flutter_bloc`, `equatable`, `intl`)  
**Design Reference:** Raintech Hotel Management System Product Suite

---

## 🏨 Overview
This project is a complete Flutter Web implementation of the **Raintech Hotel Management System**, faithfully recreating all 3 product interfaces from the design specifications:
1. 📊 **Main Dashboard**: Real-time operations overview, quick action cards, 50-room interactive floor plan with live status cycling, vacating rooms schedule, and status changer toolbar.
2. 🛎️ **Guest Check-in**: 3-step guest arrival workflow with ID document preview, guest details update, interactive in-house guest data table, and payment finalization.
3. 🚪 **Guest Check-out**: Multi-room departure management, itemized bill review (room charges, mini-bar, room service, restaurant charges), payment method processing, and invoice generation.
4. 📅 **Room Booking & Reservations**: Dedicated room reservation engine with pure date validations, 12% GST calculation, and conflict checking.

---

## 🏛 Architecture & Folder Structure

```
lib/
├── main.dart                                   # App entry point, MultiBlocProvider & Theme setup
├── core/
│   ├── theme/
│   │   └── app_theme.dart                      # Design tokens (colors, radii, shadows, typography)
│   └── utils/
│       └── date_validators.dart                # Pure validation, pricing, and overlap algorithms
└── features/
    ├── navigation/
    │   ├── cubit/
    │   │   └── navigation_cubit.dart           # Active screen navigation state
    │   └── presentation/
    │       └── app_shell.dart                  # Top navigation bar & global screen switcher
    ├── dashboard/
    │   └── presentation/
    │       └── dashboard_screen.dart           # Main Dashboard (Screenshot 2)
    ├── checkin/
    │   └── presentation/
    │       └── checkin_screen.dart             # Guest Check-in (Screenshot 1)
    ├── checkout/
    │   └── presentation/
    │       └── checkout_screen.dart            # Guest Check-out (Screenshot 3)
    └── booking/
        ├── domain/
        │   ├── room.dart                       # Room entity & RoomType definitions
        │   ├── booking_selection.dart          # Selection models & metadata
        │   └── booking_repository.dart         # Repository interface & BookingRecord
        ├── data/
        │   └── mock_room_repository.dart       # Mock inventory across Floor 1 & Floor 2
        ├── bloc/
        │   ├── booking_cubit.dart              # Reactive business logic manager
        │   └── booking_state.dart              # Immutable state with Equatable
        └── presentation/
            ├── booking_screen.dart             # Dedicated booking & reservation screen
            └── widgets/
                ├── header_bar.dart             # Top header bar
                ├── date_picker_row.dart        # Date selectors & category filter chips
                ├── room_grid.dart              # Interactive floor view (Floors 1 & 2)
                ├── booking_summary_card.dart   # Billing breakdown & warning banners
                └── booking_success_dialog.dart # Reservation confirmation receipt
```

---

## 🖥️ Screen Features Breakdown

### 1. Main Dashboard (`dashboard_screen.dart` — Screenshot 2)
- **12 Action Cards Grid:** Direct one-click navigation to Check-in, Check-out, Reservations, Housekeeping, Restaurant, WhatsApp, Rooms, Staff (with "2 tasks" badge), Floors, Reports, Settings, and Group Booking.
- **Operational Overview:** Live metrics for Occupancy (`4%`), Pending Check-ins (`0`), Pending Departures (`0`), and Revenue Today (`₹0`).
- **Interactive Floor View (50 Rooms):** Color-coded status tiles across Floor 1 and Floor 2 (`Available`, `Occupied`, `Dirty`, `Maintenance`, `Blocked`) with dynamic status cycling on click and a `200 Rooms Total / 4% Occupied` doughnut meter.
- **Going to Vacate Rooms:** Room 101 & 102 departure cards with warning alert chip for overdue cleaning.
- **Quick Room Status Changer:** Dropdown room selector with "Cleaning done, ready to serve", "Set all Dirty to Cleaning", and "View All Maintenance".

### 2. Guest Check-in (`checkin_screen.dart` — Screenshot 1)
- **1. Select Booking & Guest:** Search bar, customer dropdown with `+ Add Guest`, booking date and time.
- **2. Review & Update Details:** Room No gold badge (`101`), Rent (`₹1200.00`), GST (`112.00%`), Tenant Name, Adults/Kids counter, checkout date picker, ID proof file attachment with `Upload ID`, and action bar (`Delete`, `Edit`, `Update`, `Confirm Guest Details`).
- **In-House Guest Data Table:** Tabular list for Rooms 102–111 with rent, GST, guest name, adults/kids, senior citizen count, checkout date, ID proof link, and action menu.
- **3. Finalize Check-in & Payment:** Pricing summary (Room charge, Extra charges, Tax, Total), "Complete Check-in" primary navy button, and secondary actions (`Get Data`, `M-Pay`, `Print`, `Print Registration Card`, `Download Folio`).

### 3. Guest Check-out (`checkout_screen.dart` — Screenshot 3)
- **1. Identify Departing Guest:** Guest lookup, room number stepper, guest info badge (`Room 101`), and multi-room departure selector (Room 101 & 103 checkboxes).
- **2. Review & Finalize Bill:** Multi-room billing cards for [Room 101] and [Room 103] with itemized additional charges (Mini-bar, Room Service, Restaurant Bill), invoice printing, and combined total (`₹8200.00`).
- **3. Payment & Check-out:** Payment method picker (`Credit Card`, `Cash`, `M-Pay`), payment amount input, "Process Payment & Check-out" button, "Combine and Proceed with Selected Rooms" button, and invoice printing/emailing.

---

## 🧪 Testing & Quality Assurance

- **Pure Date & Price Math Tests:** `test/date_validators_test.dart`
- **Cubit State Transitions & Overlap Detection:** `test/booking_cubit_test.dart`
- **Multi-Screen Navigation & Widget Smoke Tests:** `test/widget_test.dart`

```bash
# Run all tests
flutter test

# Run code analyzer
flutter analyze
```

**Results:** 25 / 25 automated tests passing with 0 warnings/errors.

---

## 🚀 How to Run Locally

```bash
flutter pub get
flutter run -d chrome
```
