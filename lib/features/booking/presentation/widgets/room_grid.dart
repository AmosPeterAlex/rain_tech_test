import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/room.dart';

class RoomGrid extends StatelessWidget {
  final List<Room> rooms;
  final Room? selectedRoom;
  final bool Function(Room) isRoomBooked;
  final ValueChanged<Room> onRoomSelected;

  const RoomGrid({
    super.key,
    required this.rooms,
    required this.selectedRoom,
    required this.isRoomBooked,
    required this.onRoomSelected,
  });

  @override
  Widget build(BuildContext context) {
    final floor1Rooms = rooms.where((r) => r.floor == 1).toList();
    final floor2Rooms = rooms.where((r) => r.floor == 2).toList();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryNavy,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Flexible(
                      child: Text(
                        'Room Status — Interactive Floor View',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  '${rooms.length} rooms available matching criteria',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMuted,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          if (rooms.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    size: 48,
                    color: AppTheme.textLight,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No rooms match your active filters or capacity requirements.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            )
          else ...[
            // Floor 1 Section
            if (floor1Rooms.isNotEmpty) ...[
              _buildFloorSection(
                context,
                floorLabel: 'Floor 1',
                floorRooms: floor1Rooms,
              ),
              const SizedBox(height: 18),
            ],

            // Floor 2 Section
            if (floor2Rooms.isNotEmpty) ...[
              _buildFloorSection(
                context,
                floorLabel: 'Floor 2',
                floorRooms: floor2Rooms,
              ),
              const SizedBox(height: 18),
            ],

            const Divider(height: 1),
            const SizedBox(height: 14),

            // Legend
            Wrap(
              spacing: 20,
              runSpacing: 8,
              children: [
                _buildLegendItem(
                  color: AppTheme.availableGreenText,
                  label: 'Available',
                  icon: Icons.check_circle_outline_rounded,
                ),
                _buildLegendItem(
                  color: AppTheme.primaryNavy,
                  label: 'Selected Room',
                  icon: Icons.radio_button_checked_rounded,
                ),
                _buildLegendItem(
                  color: AppTheme.occupiedRedText,
                  label: 'Booked / Unavailable',
                  icon: Icons.block_rounded,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFloorSection(
    BuildContext context, {
    required String floorLabel,
    required List<Room> floorRooms,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Floor Label Badge
        Container(
          width: 68,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.stairs_rounded,
                size: 18,
                color: AppTheme.textMuted,
              ),
              const SizedBox(height: 4),
              Text(
                floorLabel,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 14),

        // Floor Rooms Grid
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate cross axis count based on available width
              int crossAxisCount = 3;
              if (constraints.maxWidth < 500) {
                crossAxisCount = 1;
              } else if (constraints.maxWidth < 800) {
                crossAxisCount = 2;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 165,
                ),
                itemCount: floorRooms.length,
                itemBuilder: (context, index) {
                  final room = floorRooms[index];
                  final isSelected = selectedRoom?.id == room.id;
                  final isBooked = isRoomBooked(room);

                  return _buildRoomTile(
                    room: room,
                    isSelected: isSelected,
                    isBooked: isBooked,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRoomTile({
    required Room room,
    required bool isSelected,
    required bool isBooked,
  }) {
    // Dynamic styling based on state
    Color tileBg;
    Color borderColor;
    Color textColor;
    Color subTextColor;

    if (isSelected) {
      tileBg = AppTheme.primaryNavy;
      borderColor = const Color(0xFFD4AF37); // Luxury gold accent
      textColor = Colors.white;
      subTextColor = const Color(0xFFD1D5DB);
    } else if (isBooked) {
      tileBg = AppTheme.occupiedRed.withValues(alpha: 0.6);
      borderColor = AppTheme.occupiedRedBorder;
      textColor = AppTheme.textDark;
      subTextColor = AppTheme.occupiedRedText;
    } else {
      tileBg = Colors.white;
      borderColor = AppTheme.cardBorder;
      textColor = AppTheme.textDark;
      subTextColor = AppTheme.textMuted;
    }

    return InkWell(
      onTap: () => onRoomSelected(room),
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: tileBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? AppTheme.elevatedShadow
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row: Room number badge + Type Pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.15)
                        : (isBooked
                            ? AppTheme.occupiedRed
                            : const Color(0xFFE8E5DD)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.meeting_room_rounded,
                        size: 13,
                        color: isSelected
                            ? Colors.white
                            : (isBooked
                                ? AppTheme.occupiedRedText
                                : AppTheme.primaryNavy),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Room ${room.roomNumber}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : (isBooked
                                  ? AppTheme.occupiedRedText
                                  : AppTheme.textDark),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildTypeTag(room.type, isSelected),
              ],
            ),

            // Room Name & Capacity
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 13,
                      color: subTextColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Max ${room.maxGuests} ${room.maxGuests == 1 ? 'Guest' : 'Guests'}',
                      style: TextStyle(
                        fontSize: 11,
                        color: subTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    if (isBooked)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.occupiedRed,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Booked',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.occupiedRedText,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            // Bottom Row: Price per night & Amenities preview
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹${room.pricePerNight.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: isSelected
                            ? const Color(0xFFFBBF24) // Gold
                            : AppTheme.primaryNavy,
                      ),
                    ),
                    Text(
                      '/ night',
                      style: TextStyle(
                        fontSize: 10,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
                if (isSelected)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.check_rounded,
                          size: 12,
                          color: AppTheme.primaryNavy,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Selected',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primaryNavy,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Flexible(
                    child: Text(
                      room.amenities.take(2).join(' • '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 10,
                        color: subTextColor,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeTag(RoomType type, bool isSelected) {
    Color bg;
    Color text;

    if (isSelected) {
      bg = Colors.white.withValues(alpha: 0.2);
      text = Colors.white;
    } else {
      switch (type) {
        case RoomType.deluxe:
          bg = AppTheme.deluxeTagBg;
          text = AppTheme.deluxeTagText;
          break;
        case RoomType.executiveSuite:
          bg = AppTheme.suiteTagBg;
          text = AppTheme.suiteTagText;
          break;
        case RoomType.familySuite:
          bg = AppTheme.familyTagBg;
          text = AppTheme.familyTagText;
          break;
        case RoomType.standard:
          bg = AppTheme.standardTagBg;
          text = AppTheme.standardTagText;
          break;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        type.shortCode,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: text,
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required IconData icon,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textMuted,
          ),
        ),
      ],
    );
  }
}
