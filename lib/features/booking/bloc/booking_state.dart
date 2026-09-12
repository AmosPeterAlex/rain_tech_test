import 'package:equatable/equatable.dart';
import '../domain/booking_repository.dart';
import '../domain/room.dart';
import '../../../core/utils/date_validators.dart';

enum BookingStatus {
  initial,
  loading,
  ready,
  bookingSuccess,
  error,
}

class BookingState extends Equatable {
  final BookingStatus status;
  final List<Room> allRooms;
  final List<BookingRecord> existingBookings;
  final Room? selectedRoom;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int guestCount;
  final RoomType? selectedTypeFilter;
  final int? minGuestsFilter;
  final int nights;
  final double roomTotal;
  final double taxAmount;
  final double grandTotal;
  final bool isDateRangeValid;
  final String? validationMessage;
  final bool hasConflict;
  final String? conflictMessage;
  final String? errorMessage;
  final String searchQuery;

  const BookingState({
    this.status = BookingStatus.initial,
    this.allRooms = const [],
    this.existingBookings = const [],
    this.selectedRoom,
    this.checkInDate,
    this.checkOutDate,
    this.guestCount = 1,
    this.selectedTypeFilter,
    this.minGuestsFilter,
    this.nights = 0,
    this.roomTotal = 0.0,
    this.taxAmount = 0.0,
    this.grandTotal = 0.0,
    this.isDateRangeValid = false,
    this.validationMessage,
    this.hasConflict = false,
    this.conflictMessage,
    this.errorMessage,
    this.searchQuery = '',
  });

  /// Check if the current room has a conflict with the selected dates
  bool isRoomBooked(Room room) {
    if (checkInDate == null || checkOutDate == null || !isDateRangeValid) {
      return false;
    }
    return DateValidators.hasBookingConflict(
      roomId: room.id,
      checkIn: checkInDate!,
      checkOut: checkOutDate!,
      existingBookings: existingBookings,
    );
  }

  /// Filter rooms based on type, guest count, and search query
  List<Room> get filteredRooms {
    return allRooms.where((room) {
      // Filter by room type
      if (selectedTypeFilter != null && room.type != selectedTypeFilter) {
        return false;
      }
      // Filter by guest capacity
      if (room.maxGuests < guestCount) {
        return false;
      }
      // Filter by min guests if specified
      if (minGuestsFilter != null && room.maxGuests < minGuestsFilter!) {
        return false;
      }
      // Filter by search query
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        final matchNumber = room.roomNumber.toLowerCase().contains(query);
        final matchName = room.name.toLowerCase().contains(query);
        final matchType = room.type.displayName.toLowerCase().contains(query);
        if (!matchNumber && !matchName && !matchType) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  /// Whether the booking can be confirmed
  bool get isReadyToBook {
    return selectedRoom != null &&
        isDateRangeValid &&
        !hasConflict &&
        nights > 0 &&
        status != BookingStatus.loading;
  }

  BookingState copyWith({
    BookingStatus? status,
    List<Room>? allRooms,
    List<BookingRecord>? existingBookings,
    Room? selectedRoom,
    bool clearSelectedRoom = false,
    DateTime? checkInDate,
    bool clearCheckInDate = false,
    DateTime? checkOutDate,
    bool clearCheckOutDate = false,
    int? guestCount,
    RoomType? selectedTypeFilter,
    bool clearTypeFilter = false,
    int? minGuestsFilter,
    bool clearMinGuestsFilter = false,
    int? nights,
    double? roomTotal,
    double? taxAmount,
    double? grandTotal,
    bool? isDateRangeValid,
    String? validationMessage,
    bool clearValidationMessage = false,
    bool? hasConflict,
    String? conflictMessage,
    bool clearConflictMessage = false,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? searchQuery,
  }) {
    return BookingState(
      status: status ?? this.status,
      allRooms: allRooms ?? this.allRooms,
      existingBookings: existingBookings ?? this.existingBookings,
      selectedRoom:
          clearSelectedRoom ? null : (selectedRoom ?? this.selectedRoom),
      checkInDate:
          clearCheckInDate ? null : (checkInDate ?? this.checkInDate),
      checkOutDate:
          clearCheckOutDate ? null : (checkOutDate ?? this.checkOutDate),
      guestCount: guestCount ?? this.guestCount,
      selectedTypeFilter: clearTypeFilter
          ? null
          : (selectedTypeFilter ?? this.selectedTypeFilter),
      minGuestsFilter: clearMinGuestsFilter
          ? null
          : (minGuestsFilter ?? this.minGuestsFilter),
      nights: nights ?? this.nights,
      roomTotal: roomTotal ?? this.roomTotal,
      taxAmount: taxAmount ?? this.taxAmount,
      grandTotal: grandTotal ?? this.grandTotal,
      isDateRangeValid: isDateRangeValid ?? this.isDateRangeValid,
      validationMessage: clearValidationMessage
          ? null
          : (validationMessage ?? this.validationMessage),
      hasConflict: hasConflict ?? this.hasConflict,
      conflictMessage: clearConflictMessage
          ? null
          : (conflictMessage ?? this.conflictMessage),
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allRooms,
        existingBookings,
        selectedRoom,
        checkInDate,
        checkOutDate,
        guestCount,
        selectedTypeFilter,
        minGuestsFilter,
        nights,
        roomTotal,
        taxAmount,
        grandTotal,
        isDateRangeValid,
        validationMessage,
        hasConflict,
        conflictMessage,
        errorMessage,
        searchQuery,
      ];
}
