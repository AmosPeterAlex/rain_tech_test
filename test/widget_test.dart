import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rain_tech_test/main.dart';

void main() {
  testWidgets('Smoke test: Renders Dashboard, Check-in, Check-out, and navigates seamlessly', (
    WidgetTester tester,
  ) async {
    // Set viewport size for desktop web layout
    tester.view.physicalSize = const Size(1440, 950);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const RaintechHotelBookingApp());
    await tester.pumpAndSettle();

    // 1. Verify App Shell and Main Dashboard
    expect(find.text('Raintech'), findsAtLeastNWidgets(1));
    expect(find.text('HOTEL MANAGEMENT'), findsAtLeastNWidgets(1));
    expect(find.text('Main Dashboard'), findsOneWidget);
    expect(find.text('Operational Overview'), findsOneWidget);
    expect(find.text('Room Status - Interactive Floor View'), findsOneWidget);
    expect(find.text('Going to Vacate Rooms'), findsOneWidget);

    // 2. Navigate to Guest Check-in
    await tester.tap(find.byIcon(Icons.login_rounded));
    await tester.pumpAndSettle();

    expect(find.text('1. Select Booking & Guest'), findsOneWidget);
    expect(find.text('2. Review & Update Details'), findsOneWidget);
    expect(find.text('3. Finalize Check-in & Payment'), findsOneWidget);
    expect(find.text('Mathew Hyden'), findsAtLeastNWidgets(1));

    // 3. Navigate to Guest Check-out
    await tester.tap(find.byIcon(Icons.logout_rounded));
    await tester.pumpAndSettle();

    expect(find.text('1. Identify Departing Guest'), findsOneWidget);
    expect(find.text('2. Review & Finalize Bill'), findsOneWidget);
    expect(find.text('3. Payment & Check-out'), findsOneWidget);
    expect(find.text('[Room 101]'), findsOneWidget);

    // 4. Navigate to Reservations / Booking Engine
    await tester.tap(find.byIcon(Icons.bed_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Stay Dates & Guest Preferences'), findsOneWidget);
    expect(find.text('Room Status — Interactive Floor View'), findsOneWidget);
    expect(find.text('Finalize Reservation & Billing'), findsOneWidget);
  });
}
