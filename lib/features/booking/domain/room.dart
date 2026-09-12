import 'package:equatable/equatable.dart';

enum RoomType {
  standard,
  deluxe,
  executiveSuite,
  familySuite;

  String get displayName {
    switch (this) {
      case RoomType.standard:
        return 'Standard Room';
      case RoomType.deluxe:
        return 'Deluxe Room';
      case RoomType.executiveSuite:
        return 'Executive Suite';
      case RoomType.familySuite:
        return 'Family Suite';
    }
  }

  String get shortCode {
    switch (this) {
      case RoomType.standard:
        return 'STD';
      case RoomType.deluxe:
        return 'DLX';
      case RoomType.executiveSuite:
        return 'EXE';
      case RoomType.familySuite:
        return 'FAM';
    }
  }
}

class Room extends Equatable {
  final String id;
  final String roomNumber;
  final String name;
  final RoomType type;
  final double pricePerNight;
  final int maxGuests;
  final int floor;
  final List<String> amenities;
  final String description;

  const Room({
    required this.id,
    required this.roomNumber,
    required this.name,
    required this.type,
    required this.pricePerNight,
    required this.maxGuests,
    required this.floor,
    this.amenities = const [],
    this.description = '',
  });

  Room copyWith({
    String? id,
    String? roomNumber,
    String? name,
    RoomType? type,
    double? pricePerNight,
    int? maxGuests,
    int? floor,
    List<String>? amenities,
    String? description,
  }) {
    return Room(
      id: id ?? this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      name: name ?? this.name,
      type: type ?? this.type,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      maxGuests: maxGuests ?? this.maxGuests,
      floor: floor ?? this.floor,
      amenities: amenities ?? this.amenities,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        roomNumber,
        name,
        type,
        pricePerNight,
        maxGuests,
        floor,
        amenities,
        description,
      ];
}
