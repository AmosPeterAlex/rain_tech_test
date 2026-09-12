import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/booking_repository.dart';
import '../domain/room.dart';
import '../../../core/utils/date_validators.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository _repository;
  final DateTime Function() _nowProvider;

  BookingCubit({
    required BookingRepository repository,
    DateTime Function()? nowProvider,
  })  : _repository = repository,
        _nowProvider = nowProvider ?? DateTime.now,
        super(const BookingState());

  /// Loads rooms and existing bookings from the repository
  Future<void> loadInitialData() async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final rooms = await _repository.getRooms();
      final bookings = await _repository.getExistingBookings();

      final today = DateValidators.normalizeDate(_nowProvider());
      final defaultCheckIn = today;
      final defaultCheckOut = today.add(const Duration(days: 2));

      final validation = DateValidators.validateDates(
        defaultCheckIn,
        defaultCheckOut,
        referenceNow: _nowProvider(),
      );

      final nights = DateValidators.calculateNights(
        defaultCheckIn,
        defaultCheckOut,
      );

      emit(state.copyWith(
        status: BookingStatus.ready,
        allRooms: rooms,
        existingBookings: bookings,
        checkInDate: defaultCheckIn,
        checkOutDate: defaultCheckOut,
        guestCount: 1,
        nights: nights,
        isDateRangeValid: validation.isValid,
        validationMessage: validation.errorMessage,
        clearValidationMessage: validation.isValid,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: 'Failed to load booking data: $e',
      ));
    }
  }

  /// Selects or deselects a room
  void selectRoom(Room? room) {
    if (room == null) {
      emit(state.copyWith(
        clearSelectedRoom: true,
        roomTotal: 0.0,
        taxAmount: 0.0,
        grandTotal: 0.0,
        hasConflict: false,
        clearConflictMessage: true,
      ));
      return;
    }

    // Check conflict for the selected room
    bool conflict = false;
    String? conflictMsg;
    if (state.checkInDate != null &&
        state.checkOutDate != null &&
        state.isDateRangeValid) {
      conflict = DateValidators.hasBookingConflict(
        roomId: room.id,
        checkIn: state.checkInDate!,
        checkOut: state.checkOutDate!,
        existingBookings: state.existingBookings,
      );
      if (conflict) {
        conflictMsg =
            'Room ${room.roomNumber} is already booked for these selected dates. Please choose another date or room.';
      }
    }

    // Check capacity
    String? validationMsg = state.validationMessage;
    if (room.maxGuests < state.guestCount) {
      validationMsg =
          'Room ${room.roomNumber} accommodates up to ${room.maxGuests} guests, but ${state.guestCount} guests are selected.';
    }

    final pricing = DateValidators.calculateTotal(
      room.pricePerNight,
      state.nights,
    );

    emit(state.copyWith(
      selectedRoom: room,
      hasConflict: conflict,
      conflictMessage: conflictMsg,
      clearConflictMessage: !conflict,
      validationMessage: validationMsg,
      roomTotal: pricing.roomTotal,
      taxAmount: pricing.taxAmount,
      grandTotal: pricing.grandTotal,
    ));
  }

  /// Updates check-in and check-out dates
  void selectDateRange(DateTime? checkIn, DateTime? checkOut) {
    final validation = DateValidators.validateDates(
      checkIn,
      checkOut,
      referenceNow: _nowProvider(),
    );

    final nights = DateValidators.calculateNights(checkIn, checkOut);

    bool conflict = false;
    String? conflictMsg;

    if (state.selectedRoom != null &&
        checkIn != null &&
        checkOut != null &&
        validation.isValid) {
      conflict = DateValidators.hasBookingConflict(
        roomId: state.selectedRoom!.id,
        checkIn: checkIn,
        checkOut: checkOut,
        existingBookings: state.existingBookings,
      );
      if (conflict) {
        conflictMsg =
            'Room ${state.selectedRoom!.roomNumber} is unavailable for selected dates.';
      }
    }

    final pricePerNight = state.selectedRoom?.pricePerNight ?? 0.0;
    final pricing = DateValidators.calculateTotal(pricePerNight, nights);

    emit(state.copyWith(
      checkInDate: checkIn,
      clearCheckInDate: checkIn == null,
      checkOutDate: checkOut,
      clearCheckOutDate: checkOut == null,
      nights: nights,
      isDateRangeValid: validation.isValid,
      validationMessage: validation.errorMessage,
      clearValidationMessage: validation.isValid,
      hasConflict: conflict,
      conflictMessage: conflictMsg,
      clearConflictMessage: !conflict,
      roomTotal: pricing.roomTotal,
      taxAmount: pricing.taxAmount,
      grandTotal: pricing.grandTotal,
    ));
  }

  /// Updates guest count
  void updateGuestCount(int count) {
    if (count < 1) return;

    String? validationMsg;
    Room? currentRoom = state.selectedRoom;

    if (currentRoom != null && currentRoom.maxGuests < count) {
      validationMsg =
          'Room ${currentRoom.roomNumber} only holds up to ${currentRoom.maxGuests} guests.';
    }

    emit(state.copyWith(
      guestCount: count,
      validationMessage: validationMsg,
      clearValidationMessage: validationMsg == null,
    ));
  }

  /// Filters by room type
  void filterByType(RoomType? type) {
    emit(state.copyWith(
      selectedTypeFilter: type,
      clearTypeFilter: type == null,
    ));
  }

  /// Updates search query
  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  /// Clears active filters
  void clearFilters() {
    emit(state.copyWith(
      clearTypeFilter: true,
      clearMinGuestsFilter: true,
      searchQuery: '',
    ));
  }

  /// Confirms and completes booking
  void confirmBooking() {
    if (!state.isReadyToBook) {
      emit(state.copyWith(
        validationMessage:
            state.validationMessage ?? 'Please select a valid room and date range.',
      ));
      return;
    }

    emit(state.copyWith(status: BookingStatus.bookingSuccess));
  }

  /// Resets booking flow to new booking
  void resetBooking() {
    final today = DateValidators.normalizeDate(_nowProvider());
    final defaultCheckIn = today;
    final defaultCheckOut = today.add(const Duration(days: 2));
    final nights = DateValidators.calculateNights(
      defaultCheckIn,
      defaultCheckOut,
    );

    emit(state.copyWith(
      status: BookingStatus.ready,
      clearSelectedRoom: true,
      checkInDate: defaultCheckIn,
      checkOutDate: defaultCheckOut,
      guestCount: 1,
      nights: nights,
      roomTotal: 0.0,
      taxAmount: 0.0,
      grandTotal: 0.0,
      isDateRangeValid: true,
      clearValidationMessage: true,
      hasConflict: false,
      clearConflictMessage: true,
      clearTypeFilter: true,
      searchQuery: '',
    ));
  }

  /// Dismisses success dialog/state
  void dismissSuccess() {
    emit(state.copyWith(status: BookingStatus.ready));
  }
}
