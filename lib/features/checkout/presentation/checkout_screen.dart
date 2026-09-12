import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String _selectedPaymentMethod = 'Credit Card';
  bool _room101Selected = true;
  bool _room103Selected = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Screen Header with Search Bar
          _buildCheckOutHeader(),

          const SizedBox(height: 18),

          // 3 Column / Section Layout matching Screenshot 3
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 1100;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildIdentifyGuestCard(),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 5,
                      child: _buildReviewFinalizeBillCard(),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: _buildPaymentCheckoutCard(),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  _buildIdentifyGuestCard(),
                  const SizedBox(height: 16),
                  _buildReviewFinalizeBillCard(),
                  const SizedBox(height: 16),
                  _buildPaymentCheckoutCard(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCheckOutHeader() {
    return Row(
      children: [
        const Text(
          'Guest Check-out',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Container(
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search Booking ID / Guest Name',
                hintStyle: TextStyle(fontSize: 12, color: AppTheme.textLight),
                prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppTheme.textMuted),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 1. Identify Departing Guest Card
  Widget _buildIdentifyGuestCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPanelHeader('1. Identify Departing Guest'),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildField(
                        'Find Guest',
                        'Search Guest',
                        hasDropdown: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: _buildField(
                        'Identify by Room',
                        '1',
                        hasStepper: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppTheme.cardBorder),
                        ),
                        alignment: Alignment.centerLeft,
                        child: const Text('Select Guest from List', style: TextStyle(fontSize: 11, color: AppTheme.textDark)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryNavy,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: const Text('Find Room/Guest', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Guest Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Guest Name', style: TextStyle(fontSize: 10, color: AppTheme.textMuted, fontWeight: FontWeight.w600)),
                        SizedBox(height: 2),
                        Text('Mathew Hyden', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Room No.', style: TextStyle(fontSize: 10, color: AppTheme.textMuted, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5D5B8),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFCBB799)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.bed_rounded, size: 12, color: AppTheme.primaryNavy),
                              SizedBox(width: 4),
                              Text('101', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppTheme.primaryNavy)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Room Table with Checkboxes
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.cardBorder),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        color: const Color(0xFFF1EBE4),
                        child: const Row(
                          children: [
                            SizedBox(width: 40, child: Text('Room', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700))),
                            Expanded(child: Text('Stay Dates', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700))),
                            Text('Actions', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      _buildRoomSelectionRow('101', '02/04/2026-04/04/2026', _room101Selected, (val) {
                        setState(() => _room101Selected = val ?? false);
                      }),
                      const Divider(height: 1),
                      _buildRoomSelectionRow('103', '02/04/2026-04/04/2026', _room103Selected, (val) {
                        setState(() => _room103Selected = val ?? false);
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.search_rounded, size: 14),
                  label: const Text('Add/Change Selected Rooms', style: TextStyle(fontSize: 11)),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 38),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomSelectionRow(String roomNo, String dates, bool isSelected, ValueChanged<bool?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 40, child: Text(roomNo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700))),
          Expanded(child: Text(dates, style: const TextStyle(fontSize: 10, color: AppTheme.textDark))),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: isSelected,
                onChanged: onChanged,
                activeColor: AppTheme.primaryNavy,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text('Select for Check-out', style: TextStyle(fontSize: 9, color: AppTheme.textMuted)),
            ],
          ),
        ],
      ),
    );
  }

  // 2. Review & Finalize Bill Card
  Widget _buildReviewFinalizeBillCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPanelHeader('2. Review & Finalize Bill'),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Room 101 Bill Section
                _buildRoomBillSection(
                  title: '[Room 101]',
                  subtitle: '(Nights: 2, Rate: ₹1200.00, Total: ₹2400.00)',
                  items: [
                    _BillItem(title: 'Mini-bar (Water x2)', date: '03/04/2026', amount: '₹100.00'),
                    _BillItem(title: 'Room Service', date: '03/04/2026', amount: '₹1200.00'),
                    _BillItem(title: 'Restaurant Bill (Room 101)', date: '03/04/2026', amount: '₹850.00'),
                  ],
                  total: '₹4550.00',
                  roomCode: '101',
                ),

                const SizedBox(height: 16),

                // Room 103 Bill Section
                _buildRoomBillSection(
                  title: '[Room 103]',
                  subtitle: '(Nights: 2, Rate: ₹1200.00, Total: ₹2400.00)',
                  items: [
                    _BillItem(title: 'Mini-bar (Chips)', date: '03/04/2026', amount: '₹50.00'),
                    _BillItem(title: 'Restaurant Bill (Room 103)', date: '03/04/2026', amount: '₹1200.00'),
                  ],
                  total: '₹3650.00',
                  roomCode: '103',
                  hasDraftButtons: true,
                ),

                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 12),

                // Combined Total Footer
                Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  children: [
                    const Text(
                      'Selected Rooms Combined Total: ',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textDark),
                    ),
                    const Text(
                      '₹8200.00',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppTheme.primaryNavy),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomBillSection({
    required String title,
    required String subtitle,
    required List<_BillItem> items,
    required String total,
    required String roomCode,
    bool hasDraftButtons = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                ],
              ),
              if (hasDraftButtons) ...[
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.print_outlined, size: 12),
                      label: const Text('Print Draft Invoice', style: TextStyle(fontSize: 10)),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6)),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.sync_alt_rounded, size: 12),
                      label: const Text('Adjust Charges', style: TextStyle(fontSize: 10)),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6)),
                    ),
                  ],
                ),
              ],
            ],
          ),

          const SizedBox(height: 10),

          // Additional Charges Filter Row
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppTheme.cardBorder),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search/Add Additional Charges',
                      hintStyle: TextStyle(fontSize: 10, color: AppTheme.textLight),
                      prefixIcon: Icon(Icons.search_rounded, size: 14, color: AppTheme.textMuted),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              _buildAddChip('Mini-bar'),
              const SizedBox(width: 6),
              _buildAddChip('Laundry'),
              const SizedBox(width: 6),
              _buildAddChip('+'),
            ],
          ),

          const SizedBox(height: 10),

          // Charges Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  color: const Color(0xFFF1EBE4),
                  child: const Row(
                    children: [
                      Expanded(child: Text('Room Charges & External Bills', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700))),
                      SizedBox(width: 80, child: Text('Date', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700))),
                      SizedBox(width: 70, child: Text('Amount', textAlign: TextAlign.end, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700))),
                    ],
                  ),
                ),
                ...items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      children: [
                        Expanded(child: Text(item.title, style: const TextStyle(fontSize: 11, color: AppTheme.textDark))),
                        SizedBox(width: 80, child: Text(item.date, style: const TextStyle(fontSize: 10, color: AppTheme.textMuted))),
                        SizedBox(width: 70, child: Text(item.amount, textAlign: TextAlign.end, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textDark))),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Subtotal & Action buttons
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              Text('Room $roomCode Total: $total', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.primaryNavy)),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.print_outlined, size: 12),
                    label: Text('Print Room $roomCode Invoice', style: const TextStyle(fontSize: 10)),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6)),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.sync_alt_rounded, size: 12),
                    label: Text('Adjust Charges (Room $roomCode)', style: const TextStyle(fontSize: 10)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryNavy,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE8E1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
    );
  }

  // 3. Payment & Check-out Card
  Widget _buildPaymentCheckoutCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPanelHeader('3. Payment & Check-out'),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPriceRow('Total Amount Due', '₹8200.00', isLarge: true),
                const SizedBox(height: 6),
                _buildPriceRow('(Selected Rooms)', '₹0.00'),
                const SizedBox(height: 16),
                const Text('Payment Method', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textMuted)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedPaymentMethod,
                          isExpanded: true,
                          items: ['Credit Card', 'Cash', 'M-Pay'].map((m) {
                            return DropdownMenuItem(
                              value: m,
                              child: Text(m, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedPaymentMethod = val);
                          },
                        ),
                      ),
                      const Divider(height: 12),
                      const Text('Cash', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                      const SizedBox(height: 4),
                      const Text('M-Pay', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Payment Amount', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textMuted)),
                const SizedBox(height: 4),
                Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppTheme.cardBorder),
                  ),
                  child: const Text('₹8200.00', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                ),
                const SizedBox(height: 16),
                // Process Payment button
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Room 101 Check-out...')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryNavy,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Column(
                    children: [
                      Text('Process Payment & Check-out', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      SizedBox(height: 2),
                      Text('Proceed with Room 101 Check-out\nComplete Check-out', textAlign: TextAlign.center, style: TextStyle(fontSize: 9, color: Color(0xFFCBD5E1))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Combine and Proceed button
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Combined Check-out for Rooms 101 & 103 Completed!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryNavy,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Column(
                    children: [
                      Text('Payment & Check-out', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      SizedBox(height: 2),
                      Text('Combine and Proceed with\nSelected Rooms Check-out', textAlign: TextAlign.center, style: TextStyle(fontSize: 9, color: Color(0xFFCBD5E1))),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
                  child: const Text('Print Final Invoice', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
                  child: const Text('Email Final Invoice', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanelHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: AppTheme.primaryNavy,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }

  Widget _buildField(String label, String value, {bool hasDropdown = false, bool hasStepper = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.textMuted)),
        const SizedBox(height: 3),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              if (hasDropdown) const Icon(Icons.arrow_drop_down_rounded, size: 18, color: AppTheme.textMuted),
              if (hasStepper) const Icon(Icons.unfold_more_rounded, size: 16, color: AppTheme.textMuted),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isLarge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isLarge ? 13 : 11,
              fontWeight: isLarge ? FontWeight.w800 : FontWeight.w500,
              color: isLarge ? AppTheme.textDark : AppTheme.textMuted,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: isLarge ? 16 : 11,
            fontWeight: isLarge ? FontWeight.w900 : FontWeight.w700,
            color: isLarge ? AppTheme.primaryNavy : AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}

class _BillItem {
  final String title;
  final String date;
  final String amount;

  _BillItem({
    required this.title,
    required this.date,
    required this.amount,
  });
}
