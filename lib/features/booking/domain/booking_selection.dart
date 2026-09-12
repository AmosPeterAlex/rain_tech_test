import 'package:equatable/equatable.dart';
import 'room.dart';

class BookingSelection extends Equatable {
  final Room? room;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int guestCount;
  final int nights;
  final double roomTotal;
  final double taxAmount;
  final double grandTotal;
  final bool isValid;
  final String? errorMessage;
  final bool hasConflict;

  const BookingSelection({
    this.room,
    this.checkInDate,
    this.checkOutDate,
    this.guestCount = 1,
    this.nights = 0,
    this.roomTotal = 0.0,
    this.taxAmount = 0.0,
    this.grandTotal = 0.0,
    this.isValid = false,
    this.errorMessage,
    this.hasConflict = false,
  });

  BookingSelection copyWith({
    Room? room,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? guestCount,
    int? nights,
    double? roomTotal,
    double taxAmount = 0.0,
    double? grandTotal,
    bool? isValid,
    String? errorMessage,
    bool? hasConflict,
    bool clearRoom = false,
  }) {
    return BookingSelection(
      room: clearRoom ? null : (room ?? this.room),
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      guestCount: guestCount ?? this.guestCount,
      nights: nights ?? this.nights,
      roomTotal: roomTotal ?? this.roomTotal,
      taxAmount: taxAmount,
      grandTotal: grandTotal ?? this.grandTotal,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage,
      hasConflict: hasConflict ?? this.hasConflict,
    );
  }

  @override
  List<Object?> get props => [
        room,
        checkInDate,
        checkOutDate,
        guestCount,
        nights,
        roomTotal,
        taxAmount,
        grandTotal,
        isValid,
        errorMessage,
        hasConflict,
      ];
}
