import 'package:equatable/equatable.dart';
import 'room.dart';

class BookingRecord extends Equatable {
  final String id;
  final String roomId;
  final String guestName;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  const BookingRecord({
    required this.id,
    required this.roomId,
    required this.guestName,
    required this.checkInDate,
    required this.checkOutDate,
  });

  @override
  List<Object?> get props => [
        id,
        roomId,
        guestName,
        checkInDate,
        checkOutDate,
      ];
}

abstract class BookingRepository {
  Future<List<Room>> getRooms();
  Future<List<BookingRecord>> getExistingBookings();
  Future<bool> checkRoomAvailability(
    String roomId,
    DateTime checkIn,
    DateTime checkOut,
  );
}
