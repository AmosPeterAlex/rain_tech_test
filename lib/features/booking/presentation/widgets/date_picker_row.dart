import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/room.dart';

class DatePickerRow extends StatelessWidget {
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int guestCount;
  final int nights;
  final RoomType? selectedRoomType;
  final ValueChanged<DateTime> onCheckInSelected;
  final ValueChanged<DateTime> onCheckOutSelected;
  final ValueChanged<int> onGuestCountChanged;
  final ValueChanged<RoomType?> onRoomTypeSelected;

  const DatePickerRow({
    super.key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guestCount,
    required this.nights,
    required this.selectedRoomType,
    required this.onCheckInSelected,
    required this.onCheckOutSelected,
    required this.onGuestCountChanged,
    required this.onRoomTypeSelected,
  });

  Future<void> _pickDate(
    BuildContext context, {
    required bool isCheckIn,
  }) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = firstDate.add(const Duration(days: 365));

    final initialDate = isCheckIn
        ? (checkInDate ?? firstDate)
        : (checkOutDate ?? (checkInDate?.add(const Duration(days: 1)) ?? firstDate.add(const Duration(days: 1))));

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryNavy,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppTheme.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isCheckIn) {
        onCheckInSelected(picked);
      } else {
        onCheckOutSelected(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Stay Dates & Guest Preferences',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
              ),
              if (nights > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.availableGreen,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.availableGreenBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.nights_stay_rounded,
                        size: 14,
                        color: AppTheme.availableGreenText,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$nights ${nights == 1 ? 'Night' : 'Nights'} Selected',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.availableGreenText,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Inputs Row (Check-in, Check-out, Guests)
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 650;

              if (isNarrow) {
                return Column(
                  children: [
                    _buildDateField(
                      context,
                      label: 'Check-in Date',
                      date: checkInDate,
                      dateFormat: dateFormat,
                      isCheckIn: true,
                    ),
                    const SizedBox(height: 12),
                    _buildDateField(
                      context,
                      label: 'Check-out Date',
                      date: checkOutDate,
                      dateFormat: dateFormat,
                      isCheckIn: false,
                    ),
                    const SizedBox(height: 12),
                    _buildGuestDropdown(),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: _buildDateField(
                      context,
                      label: 'Check-in Date',
                      date: checkInDate,
                      dateFormat: dateFormat,
                      isCheckIn: true,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    flex: 4,
                    child: _buildDateField(
                      context,
                      label: 'Check-out Date',
                      date: checkOutDate,
                      dateFormat: dateFormat,
                      isCheckIn: false,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    flex: 3,
                    child: _buildGuestDropdown(),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 18),
          const Divider(height: 1),
          const SizedBox(height: 14),

          // Room Type Filter Chips
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Room Category:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textMuted,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(
                        label: 'All Rooms',
                        isSelected: selectedRoomType == null,
                        onTap: () => onRoomTypeSelected(null),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        label: 'Standard',
                        isSelected: selectedRoomType == RoomType.standard,
                        onTap: () => onRoomTypeSelected(RoomType.standard),
                        tagColor: AppTheme.standardTagBg,
                        textColor: AppTheme.standardTagText,
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        label: 'Deluxe',
                        isSelected: selectedRoomType == RoomType.deluxe,
                        onTap: () => onRoomTypeSelected(RoomType.deluxe),
                        tagColor: AppTheme.deluxeTagBg,
                        textColor: AppTheme.deluxeTagText,
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        label: 'Executive Suite',
                        isSelected: selectedRoomType == RoomType.executiveSuite,
                        onTap: () => onRoomTypeSelected(RoomType.executiveSuite),
                        tagColor: AppTheme.suiteTagBg,
                        textColor: AppTheme.suiteTagText,
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        label: 'Family Suite',
                        isSelected: selectedRoomType == RoomType.familySuite,
                        onTap: () => onRoomTypeSelected(RoomType.familySuite),
                        tagColor: AppTheme.familyTagBg,
                        textColor: AppTheme.familyTagText,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(
    BuildContext context, {
    required String label,
    required DateTime? date,
    required DateFormat dateFormat,
    required bool isCheckIn,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textMuted,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _pickDate(context, isCheckIn: isCheckIn),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date != null ? dateFormat.format(date) : 'Select date',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: date != null
                        ? AppTheme.textDark
                        : AppTheme.textLight,
                  ),
                ),
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 18,
                  color: AppTheme.primaryNavy,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuestDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total Guests',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textMuted,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: guestCount,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppTheme.primaryNavy,
              ),
              items: [1, 2, 3, 4, 5, 6].map((count) {
                return DropdownMenuItem<int>(
                  value: count,
                  child: Text(
                    '$count ${count == 1 ? 'Guest' : 'Guests'}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  onGuestCountChanged(val);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    Color? tagColor,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryNavy
              : (tagColor ?? AppTheme.background),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryNavy : AppTheme.cardBorder,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected
                ? Colors.white
                : (textColor ?? AppTheme.textDark),
          ),
        ),
      ),
    );
  }
}
