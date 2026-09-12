import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:rain_tech_test/features/booking/bloc/booking_state.dart';

class BookingSuccessDialog extends StatelessWidget {
  final BookingState state;
  final VoidCallback onNewBooking;

  const BookingSuccessDialog({
    super.key,
    required this.state,
    required this.onNewBooking,
  });

  @override
  Widget build(BuildContext context) {
    final selectedRoom = state.selectedRoom!;
    final dateFormat = DateFormat('dd/MM/yyyy');
    final currencyFormat = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 2,
    );
    final bookingId = 'BK-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 480,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.cardBorder),
          boxShadow: AppTheme.elevatedShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: AppTheme.availableGreen,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppTheme.availableGreenText,
                  size: 36,
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Reservation Confirmed!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppTheme.textDark,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Booking ID: $bookingId',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryNavy,
              ),
            ),

            const SizedBox(height: 20),

            // Receipt Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.cardBorder),
              ),
              child: Column(
                children: [
                  _buildDialogRow('Room', 'Room ${selectedRoom.roomNumber} (${selectedRoom.type.displayName})'),
                  const SizedBox(height: 8),
                  _buildDialogRow('Floor', 'Floor ${selectedRoom.floor}'),
                  const SizedBox(height: 8),
                  _buildDialogRow('Check-in', state.checkInDate != null ? dateFormat.format(state.checkInDate!) : '—'),
                  const SizedBox(height: 8),
                  _buildDialogRow('Check-out', state.checkOutDate != null ? dateFormat.format(state.checkOutDate!) : '—'),
                  const SizedBox(height: 8),
                  _buildDialogRow('Duration', '${state.nights} ${state.nights == 1 ? 'Night' : 'Nights'}'),
                  const SizedBox(height: 8),
                  _buildDialogRow('Guests', '${state.guestCount} Guests'),
                  const Divider(height: 20),
                  _buildDialogRow(
                    'Grand Total Paid',
                    currencyFormat.format(state.grandTotal),
                    isHighlight: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.print_outlined, size: 16),
                    label: const Text('Print Receipt'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onNewBooking();
                    },
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('New Booking'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryNavy,
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

  Widget _buildDialogRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
            color: isHighlight ? AppTheme.textDark : AppTheme.textMuted,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlight ? 14 : 12,
            fontWeight: isHighlight ? FontWeight.w800 : FontWeight.w600,
            color: isHighlight ? AppTheme.primaryNavy : AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}
