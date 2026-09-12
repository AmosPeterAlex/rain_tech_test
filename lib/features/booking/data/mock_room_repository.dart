import '../domain/booking_repository.dart';
import '../domain/room.dart';
import 'package:rain_tech_test/core/utils/date_validators.dart';

class MockRoomRepository implements BookingRepository {
  final List<Room> _rooms = const [
    // Floor 1 Rooms
    Room(
      id: 'r101',
      roomNumber: '101',
      name: 'Deluxe King Suite',
      type: RoomType.deluxe,
      pricePerNight: 1200.0,
      maxGuests: 2,
      floor: 1,
      amenities: ['King Bed', 'AC', 'Free High-Speed Wi-Fi', 'Balcony', 'Room Service'],
      description: 'Spacious Deluxe room with premium king-size bed, private balcony, and garden view.',
    ),
    Room(
      id: 'r102',
      roomNumber: '102',
      name: 'Standard Queen Room',
      type: RoomType.standard,
      pricePerNight: 1000.0,
      maxGuests: 2,
      floor: 1,
      amenities: ['Queen Bed', 'AC', 'Free Wi-Fi', 'Smart TV', 'Coffee Maker'],
      description: 'Comfortable standard room equipped with a plush queen bed and modern workspace.',
    ),
    Room(
      id: 'r103',
      roomNumber: '103',
      name: 'Executive Presidential Suite',
      type: RoomType.executiveSuite,
      pricePerNight: 2400.0,
      maxGuests: 3,
      floor: 1,
      amenities: ['King Bed', 'Jacuzzi', 'Mini-bar', 'City View', 'Lounge Area', '24/7 Butler'],
      description: 'Luxury executive suite featuring a private jacuzzi, stocked mini-bar, and panoramic city vistas.',
    ),
    Room(
      id: 'r104',
      roomNumber: '104',
      name: 'Grand Family Suite',
      type: RoomType.familySuite,
      pricePerNight: 3200.0,
      maxGuests: 5,
      floor: 1,
      amenities: ['2 Double Beds', 'Sofa Bed', 'Kitchenette', 'Dining Table', 'Smart TV', 'Kid Amenities'],
      description: 'Expansive multi-room family suite with separate kitchenette and living lounge.',
    ),
    Room(
      id: 'r105',
      roomNumber: '105',
      name: 'Deluxe Poolside Room',
      type: RoomType.deluxe,
      pricePerNight: 1350.0,
      maxGuests: 2,
      floor: 1,
      amenities: ['King Bed', 'Pool Access', 'AC', 'Balcony', 'Mini-bar'],
      description: 'Direct poolside terrace access with serene ambient lighting and luxury linens.',
    ),
    Room(
      id: 'r106',
      roomNumber: '106',
      name: 'Standard Solo Room',
      type: RoomType.standard,
      pricePerNight: 850.0,
      maxGuests: 1,
      floor: 1,
      amenities: ['Single Bed', 'Work Desk', 'AC', 'Free Wi-Fi'],
      description: 'Compact, efficient room tailored for solo travelers and business executives on the go.',
    ),

    // Floor 2 Rooms
    Room(
      id: 'r201',
      roomNumber: '201',
      name: 'Executive Ocean View Suite',
      type: RoomType.executiveSuite,
      pricePerNight: 2600.0,
      maxGuests: 3,
      floor: 2,
      amenities: ['King Bed', 'Ocean View', 'Workstation', 'Mini-bar', 'Espresso Machine'],
      description: 'Top-tier floor suite offering unobstructed skyline and ocean vistas with executive lounge access.',
    ),
    Room(
      id: 'r202',
      roomNumber: '202',
      name: 'Deluxe Mountain View',
      type: RoomType.deluxe,
      pricePerNight: 1400.0,
      maxGuests: 2,
      floor: 2,
      amenities: ['King Bed', 'Mountain View', 'AC', 'Rain Shower', 'Smart TV'],
      description: 'Peaceful mountain views with soundproof windows and walk-in rain shower.',
    ),
    Room(
      id: 'r203',
      roomNumber: '203',
      name: 'Royal Family Penthouse',
      type: RoomType.familySuite,
      pricePerNight: 3800.0,
      maxGuests: 6,
      floor: 2,
      amenities: ['2 King Beds', 'Twin Bed', 'Private Terrace', 'Full Kitchen', 'Jacuzzi'],
      description: 'Ultimate family luxury featuring two master suites and private rooftop terrace.',
    ),
    Room(
      id: 'r204',
      roomNumber: '204',
      name: 'Standard Twin Room',
      type: RoomType.standard,
      pricePerNight: 1100.0,
      maxGuests: 2,
      floor: 2,
      amenities: ['2 Single Beds', 'AC', 'Free Wi-Fi', 'Smart TV'],
      description: 'Convenient twin bed setup ideal for colleagues or friends traveling together.',
    ),
    Room(
      id: 'r205',
      roomNumber: '205',
      name: 'Executive Panorama Suite',
      type: RoomType.executiveSuite,
      pricePerNight: 2800.0,
      maxGuests: 4,
      floor: 2,
      amenities: ['King Bed', 'Double Sofa Bed', 'Corner Balcony', 'Jacuzzi', 'Premium Sound System'],
      description: 'Corner penthouse suite with wrap-around glass windows and private whirlpool bath.',
    ),
    Room(
      id: 'r206',
      roomNumber: '206',
      name: 'Deluxe Courtyard Haven',
      type: RoomType.deluxe,
      pricePerNight: 1450.0,
      maxGuests: 2,
      floor: 2,
      amenities: ['King Bed', 'Courtyard View', 'Smart Lighting', 'Nespresso', 'Bathtub'],
      description: 'Overlooking the lush central courtyard with relaxing natural sunlight.',
    ),
  ];

  late final List<BookingRecord> _existingBookings;

  MockRoomRepository({List<BookingRecord>? initialBookings}) {
    if (initialBookings != null) {
      _existingBookings = List.from(initialBookings);
    } else {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      _existingBookings = [
        // Room 102 booked from today+3 to today+6
        BookingRecord(
          id: 'bk-102-1',
          roomId: 'r102',
          guestName: 'Mathew Hyden',
          checkInDate: today.add(const Duration(days: 3)),
          checkOutDate: today.add(const Duration(days: 6)),
        ),
        // Room 201 booked from today+1 to today+4
        BookingRecord(
          id: 'bk-201-1',
          roomId: 'r201',
          guestName: 'Sarah Thompson',
          checkInDate: today.add(const Duration(days: 1)),
          checkOutDate: today.add(const Duration(days: 4)),
        ),
        // Room 104 booked from today+10 to today+14
        BookingRecord(
          id: 'bk-104-1',
          roomId: 'r104',
          guestName: 'James Smith',
          checkInDate: today.add(const Duration(days: 10)),
          checkOutDate: today.add(const Duration(days: 14)),
        ),
      ];
    }
  }

  @override
  Future<List<Room>> getRooms() async {
    // Return copy of room list
    return List.unmodifiable(_rooms);
  }

  @override
  Future<List<BookingRecord>> getExistingBookings() async {
    return List.unmodifiable(_existingBookings);
  }

  @override
  Future<bool> checkRoomAvailability(
    String roomId,
    DateTime checkIn,
    DateTime checkOut,
  ) async {
    final hasConflict = DateValidators.hasBookingConflict(
      roomId: roomId,
      checkIn: checkIn,
      checkOut: checkOut,
      existingBookings: _existingBookings,
    );
    return !hasConflict;
  }
}
