import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rain_tech_test/core/utils/date_validators.dart';
import 'package:rain_tech_test/features/booking/bloc/booking_cubit.dart';
import 'package:rain_tech_test/features/booking/bloc/booking_state.dart';
import 'package:rain_tech_test/features/booking/data/mock_room_repository.dart';
import 'package:rain_tech_test/features/booking/domain/booking_repository.dart';
import 'package:rain_tech_test/features/booking/domain/room.dart';

void main() {
  group('BookingCubit Unit & Bloc Tests', () {
    final fixedNow = DateTime(2026, 4, 1, 10, 0, 0);
    late MockRoomRepository mockRepository;

    final existingBookings = [
      BookingRecord(
        id: 'bk-test-1',
        roomId: 'r101',
        guestName: 'Mathew Hyden',
        checkInDate: DateTime(2026, 4, 5),
        checkOutDate: DateTime(2026, 4, 8),
      ),
    ];

    setUp(() {
      mockRepository = MockRoomRepository(initialBookings: existingBookings);
    });

    test('initial state is correct', () {
      final cubit = BookingCubit(
        repository: mockRepository,
        nowProvider: () => fixedNow,
      );

      expect(cubit.state.status, BookingStatus.initial);
      expect(cubit.state.allRooms, isEmpty);
      expect(cubit.state.selectedRoom, isNull);
      expect(cubit.state.isReadyToBook, isFalse);
    });

    blocTest<BookingCubit, BookingState>(
      'loadInitialData emits [loading, ready] with rooms and default dates',
      build: () => BookingCubit(
        repository: mockRepository,
        nowProvider: () => fixedNow,
      ),
      act: (cubit) => cubit.loadInitialData(),
      expect: () => [
        const BookingState(status: BookingStatus.loading),
        predicate<BookingState>((state) {
          return state.status == BookingStatus.ready &&
              state.allRooms.isNotEmpty &&
              state.checkInDate == DateTime(2026, 4, 1) &&
              state.checkOutDate == DateTime(2026, 4, 3) &&
              state.nights == 2 &&
              state.isDateRangeValid == true;
        }),
      ],
    );

    blocTest<BookingCubit, BookingState>(
      'selectRoom updates selected room and recalculates total price',
      build: () => BookingCubit(
        repository: mockRepository,
        nowProvider: () => fixedNow,
      ),
      seed: () {
        final today = DateValidators.normalizeDate(fixedNow);
        return BookingState(
          status: BookingStatus.ready,
          checkInDate: today,
          checkOutDate: today.add(const Duration(days: 3)),
          nights: 3,
          isDateRangeValid: true,
          allRooms: [
            const Room(
              id: 'r102',
              roomNumber: '102',
              name: 'Standard Queen',
              type: RoomType.standard,
              pricePerNight: 1000.0,
              maxGuests: 2,
              floor: 1,
            ),
          ],
        );
      },
      act: (cubit) {
        const room = Room(
          id: 'r102',
          roomNumber: '102',
          name: 'Standard Queen',
          type: RoomType.standard,
          pricePerNight: 1000.0,
          maxGuests: 2,
          floor: 1,
        );
        cubit.selectRoom(room);
      },
      expect: () => [
        predicate<BookingState>((state) {
          return state.selectedRoom?.roomNumber == '102' &&
              state.roomTotal == 3000.0 &&
              state.taxAmount == 360.0 && // 12% of 3000
              state.grandTotal == 3360.0 &&
              state.hasConflict == false &&
              state.isReadyToBook == true;
        }),
      ],
    );

    blocTest<BookingCubit, BookingState>(
      'selectRoom detects conflict for overlapping dates',
      build: () => BookingCubit(
        repository: mockRepository,
        nowProvider: () => fixedNow,
      ),
      seed: () {
        return BookingState(
          status: BookingStatus.ready,
          checkInDate: DateTime(2026, 4, 6),
          checkOutDate: DateTime(2026, 4, 7),
          nights: 1,
          isDateRangeValid: true,
          existingBookings: existingBookings,
        );
      },
      act: (cubit) {
        const room101 = Room(
          id: 'r101',
          roomNumber: '101',
          name: 'Deluxe King',
          type: RoomType.deluxe,
          pricePerNight: 1200.0,
          maxGuests: 2,
          floor: 1,
        );
        cubit.selectRoom(room101);
      },
      expect: () => [
        predicate<BookingState>((state) {
          return state.selectedRoom?.roomNumber == '101' &&
              state.hasConflict == true &&
              state.conflictMessage != null &&
              state.isReadyToBook == false;
        }),
      ],
    );

    blocTest<BookingCubit, BookingState>(
      'filterByType and guest capacity filters correctly',
      build: () => BookingCubit(
        repository: mockRepository,
        nowProvider: () => fixedNow,
      ),
      seed: () {
        return const BookingState(
          status: BookingStatus.ready,
          allRooms: [
            Room(
              id: '1',
              roomNumber: '101',
              name: 'Room 1',
              type: RoomType.standard,
              pricePerNight: 1000,
              maxGuests: 2,
              floor: 1,
            ),
            Room(
              id: '2',
              roomNumber: '102',
              name: 'Room 2',
              type: RoomType.deluxe,
              pricePerNight: 1500,
              maxGuests: 2,
              floor: 1,
            ),
            Room(
              id: '3',
              roomNumber: '103',
              name: 'Room 3',
              type: RoomType.familySuite,
              pricePerNight: 3000,
              maxGuests: 5,
              floor: 1,
            ),
          ],
        );
      },
      act: (cubit) {
        cubit.filterByType(RoomType.familySuite);
      },
      expect: () => [
        predicate<BookingState>((state) {
          final filtered = state.filteredRooms;
          return filtered.length == 1 && filtered.first.roomNumber == '103';
        }),
      ],
    );

    blocTest<BookingCubit, BookingState>(
      'confirmBooking transitions to bookingSuccess when valid',
      build: () => BookingCubit(
        repository: mockRepository,
        nowProvider: () => fixedNow,
      ),
      seed: () {
        return const BookingState(
          status: BookingStatus.ready,
          isDateRangeValid: true,
          hasConflict: false,
          nights: 2,
          selectedRoom: Room(
            id: '1',
            roomNumber: '101',
            name: 'Room 1',
            type: RoomType.standard,
            pricePerNight: 1000,
            maxGuests: 2,
            floor: 1,
          ),
        );
      },
      act: (cubit) => cubit.confirmBooking(),
      expect: () => [
        predicate<BookingState>((state) {
          return state.status == BookingStatus.bookingSuccess;
        }),
      ],
    );
  });
}
