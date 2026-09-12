import 'package:flutter_test/flutter_test.dart';
import 'package:rain_tech_test/core/utils/date_validators.dart';
import 'package:rain_tech_test/features/booking/domain/booking_repository.dart';

void main() {
  group('DateValidators - Pure Unit Tests', () {
    final fixedNow = DateTime(2026, 4, 1, 10, 0, 0); // Reference Date

    group('calculateNights', () {
      test('should return correct night count for valid date ranges', () {
        final checkIn = DateTime(2026, 4, 2);
        final checkOut = DateTime(2026, 4, 5);

        final nights = DateValidators.calculateNights(checkIn, checkOut);
        expect(nights, 3);
      });

      test('should return 0 when check-in and check-out are the same day', () {
        final checkIn = DateTime(2026, 4, 2, 14, 0);
        final checkOut = DateTime(2026, 4, 2, 18, 0);

        final nights = DateValidators.calculateNights(checkIn, checkOut);
        expect(nights, 0);
      });

      test('should return 0 when check-out is before check-in', () {
        final checkIn = DateTime(2026, 4, 5);
        final checkOut = DateTime(2026, 4, 2);

        final nights = DateValidators.calculateNights(checkIn, checkOut);
        expect(nights, 0);
      });

      test('should return 0 when either date is null', () {
        expect(
          DateValidators.calculateNights(null, DateTime(2026, 4, 5)),
          0,
        );
        expect(
          DateValidators.calculateNights(DateTime(2026, 4, 2), null),
          0,
        );
        expect(DateValidators.calculateNights(null, null), 0);
      });
    });

    group('calculateTotal', () {
      test('should calculate room total, 12% tax, and grand total accurately', () {
        final result = DateValidators.calculateTotal(1200.0, 3, taxRate: 0.12);

        expect(result.nights, 3);
        expect(result.roomTotal, 3600.0);
        expect(result.taxAmount, 432.0); // 12% of 3600
        expect(result.grandTotal, 4032.0);
      });

      test('should return zero when nights is 0 or negative', () {
        final resultZero = DateValidators.calculateTotal(1200.0, 0);
        expect(resultZero, BookingCalculation.zero);

        final resultNeg = DateValidators.calculateTotal(1200.0, -1);
        expect(resultNeg, BookingCalculation.zero);
      });

      test('should handle decimal pricing correctly', () {
        final result = DateValidators.calculateTotal(1350.50, 2, taxRate: 0.12);
        expect(result.roomTotal, 2701.0);
        expect(result.taxAmount, 324.12);
        expect(result.grandTotal, 3025.12);
      });
    });

    group('validateDates', () {
      test('should return valid result for upcoming valid date range', () {
        final checkIn = DateTime(2026, 4, 2);
        final checkOut = DateTime(2026, 4, 4);

        final result = DateValidators.validateDates(
          checkIn,
          checkOut,
          referenceNow: fixedNow,
        );

        expect(result.isValid, isTrue);
        expect(result.errorMessage, isNull);
      });

      test('should reject past check-in date', () {
        final checkIn = DateTime(2026, 3, 28);
        final checkOut = DateTime(2026, 4, 3);

        final result = DateValidators.validateDates(
          checkIn,
          checkOut,
          referenceNow: fixedNow,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('cannot be in the past'));
      });

      test('should reject same-day check-in and check-out', () {
        final checkIn = DateTime(2026, 4, 2);
        final checkOut = DateTime(2026, 4, 2);

        final result = DateValidators.validateDates(
          checkIn,
          checkOut,
          referenceNow: fixedNow,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('at least 1 night'));
      });

      test('should reject check-out before check-in', () {
        final checkIn = DateTime(2026, 4, 5);
        final checkOut = DateTime(2026, 4, 2);

        final result = DateValidators.validateDates(
          checkIn,
          checkOut,
          referenceNow: fixedNow,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('earlier than check-in'));
      });

      test('should reject stay longer than 60 nights', () {
        final checkIn = DateTime(2026, 4, 1);
        final checkOut = DateTime(2026, 6, 15);

        final result = DateValidators.validateDates(
          checkIn,
          checkOut,
          referenceNow: fixedNow,
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('60 nights'));
      });
    });

    group('hasBookingConflict', () {
      final existingBookings = [
        BookingRecord(
          id: 'b1',
          roomId: 'r101',
          guestName: 'Mathew Hyden',
          checkInDate: DateTime(2026, 4, 4),
          checkOutDate: DateTime(2026, 4, 8),
        ),
      ];

      test('should detect overlap when dates fall inside existing booking', () {
        final conflict = DateValidators.hasBookingConflict(
          roomId: 'r101',
          checkIn: DateTime(2026, 4, 5),
          checkOut: DateTime(2026, 4, 7),
          existingBookings: existingBookings,
        );
        expect(conflict, isTrue);
      });

      test('should detect overlap when requested booking overlaps the start', () {
        final conflict = DateValidators.hasBookingConflict(
          roomId: 'r101',
          checkIn: DateTime(2026, 4, 2),
          checkOut: DateTime(2026, 4, 5),
          existingBookings: existingBookings,
        );
        expect(conflict, isTrue);
      });

      test('should detect overlap when requested booking overlaps the end', () {
        final conflict = DateValidators.hasBookingConflict(
          roomId: 'r101',
          checkIn: DateTime(2026, 4, 6),
          checkOut: DateTime(2026, 4, 10),
          existingBookings: existingBookings,
        );
        expect(conflict, isTrue);
      });

      test('should allow checkout date matching existing checkin date (boundary safe)', () {
        // Checking out on April 4 when existing guest checks in on April 4
        final conflict = DateValidators.hasBookingConflict(
          roomId: 'r101',
          checkIn: DateTime(2026, 4, 1),
          checkOut: DateTime(2026, 4, 4),
          existingBookings: existingBookings,
        );
        expect(conflict, isFalse);
      });

      test('should allow checkin date matching existing checkout date (boundary safe)', () {
        // Checking in on April 8 when existing guest checks out on April 8
        final conflict = DateValidators.hasBookingConflict(
          roomId: 'r101',
          checkIn: DateTime(2026, 4, 8),
          checkOut: DateTime(2026, 4, 11),
          existingBookings: existingBookings,
        );
        expect(conflict, isFalse);
      });

      test('should return false for a different room even with overlapping dates', () {
        final conflict = DateValidators.hasBookingConflict(
          roomId: 'r102',
          checkIn: DateTime(2026, 4, 5),
          checkOut: DateTime(2026, 4, 7),
          existingBookings: existingBookings,
        );
        expect(conflict, isFalse);
      });
    });
  });
}
