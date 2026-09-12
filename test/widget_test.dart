import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rain_tech_test/main.dart';

void main() {
  testWidgets('Smoke test: Renders Raintech Hotel Booking screen and header', (
    WidgetTester tester,
  ) async {
    // Set viewport size for desktop layout
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const RaintechHotelBookingApp());
    await tester.pumpAndSettle();

    // Verify header branding
    expect(find.text('Raintech'), findsOneWidget);
    expect(find.text('HOTEL MANAGEMENT'), findsOneWidget);

    // Verify sections
    expect(find.text('Stay Dates & Guest Preferences'), findsOneWidget);
    expect(find.text('Room Status — Interactive Floor View'), findsOneWidget);
    expect(find.text('Finalize Reservation & Billing'), findsOneWidget);

    // Verify floor badges
    expect(find.text('Floor 1'), findsOneWidget);
    expect(find.text('Floor 2'), findsOneWidget);

    // Verify room tiles are present
    expect(find.text('Room 101'), findsOneWidget);
    expect(find.text('Room 102'), findsOneWidget);
  });
}
