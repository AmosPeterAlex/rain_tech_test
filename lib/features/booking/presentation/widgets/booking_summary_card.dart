import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:rain_tech_test/features/booking/bloc/booking_state.dart';

class BookingSummaryCard extends StatelessWidget {
  final BookingState state;
  final VoidCallback onConfirm;
  final VoidCallback onReset;

  const BookingSummaryCard({
    super.key,
    required this.state,
    required this.onConfirm,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final selectedRoom = state.selectedRoom;
    final currencyFormat = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 2,
    );
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section Title
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
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Finalize Reservation & Billing',
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

          const SizedBox(height: 16),

          // Selected Room Overview Card
          if (selectedRoom != null)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              color: const Color(0xFFD4AF37), // Gold
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.bed_rounded,
                                  size: 14,
                                  color: AppTheme.primaryNavy,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  selectedRoom.roomNumber,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: AppTheme.primaryNavy,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedRoom.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              Text(
                                '${selectedRoom.type.displayName} • Floor ${selectedRoom.floor}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        currencyFormat.format(selectedRoom.pricePerNight),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryNavy,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: selectedRoom.amenities.map((amenity) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppTheme.cardBorder),
                        ),
                        child: Text(
                          amenity,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textDark,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppTheme.cardBorder,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.touch_app_rounded,
                    color: AppTheme.textMuted,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Please select an available room from the floor view above.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 16),

          // Reservation Summary Line Items
          _buildSummaryLine(
            'Check-in Date',
            state.checkInDate != null
                ? dateFormat.format(state.checkInDate!)
                : '—',
          ),
          const SizedBox(height: 8),
          _buildSummaryLine(
            'Check-out Date',
            state.checkOutDate != null
                ? dateFormat.format(state.checkOutDate!)
                : '—',
          ),
          const SizedBox(height: 8),
          _buildSummaryLine(
            'Stay Duration',
            '${state.nights} ${state.nights == 1 ? 'Night' : 'Nights'}',
          ),
          const SizedBox(height: 8),
          _buildSummaryLine(
            'Guest Count',
            '${state.guestCount} ${state.guestCount == 1 ? 'Guest' : 'Guests'}',
          ),

          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),

          // Billing Breakdown
          _buildSummaryLine(
            'Room Charges (${state.nights} nights)',
            currencyFormat.format(state.roomTotal),
            isBold: false,
          ),
          const SizedBox(height: 8),
          _buildSummaryLine(
            'GST & Taxes (12%)',
            currencyFormat.format(state.taxAmount),
            isBold: false,
          ),
          const SizedBox(height: 8),
          _buildSummaryLine(
            'Resort & Facility Fee',
            '₹0.00',
            isBold: false,
          ),

          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),

          // Grand Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                currencyFormat.format(state.grandTotal),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.primaryNavy,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Inline Warning / Error Banner (styled like screenshot's overdue alert)
          if (state.hasConflict)
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.occupiedRed,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.occupiedRedBorder),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 18,
                    color: AppTheme.occupiedRedText,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      state.conflictMessage ??
                          'Selected room has an existing reservation during this period.',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.occupiedRedText,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else if (state.validationMessage != null && !state.isDateRangeValid)
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.warningAmber,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.warningAmberBorder),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 18,
                    color: AppTheme.warningAmberText,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      state.validationMessage!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.warningAmberText,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Action Buttons
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: state.isReadyToBook ? onConfirm : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryNavy,
                disabledBackgroundColor: AppTheme.cardBorder,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline_rounded, size: 18),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      state.selectedRoom == null
                          ? 'Select a Room to Continue'
                          : 'Confirm & Complete Booking',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: state.isReadyToBook
                            ? Colors.white
                            : AppTheme.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Secondary Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onReset,
                  icon: const Icon(Icons.refresh_rounded, size: 16),
                  label: const Text('Reset Form'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Draft invoice quote generated.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.print_outlined, size: 16),
                  label: const Text('Print Quote'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryLine(
    String label,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isBold ? AppTheme.textDark : AppTheme.textMuted,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}
