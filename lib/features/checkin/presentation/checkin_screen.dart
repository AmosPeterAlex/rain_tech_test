import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CheckInGuestItem {
  final String roomNo;
  final double rent;
  final double gst;
  final String name;
  final int adults;
  final int kids;
  final int seniorCitizens;
  final String checkoutDate;
  final String idProof;

  CheckInGuestItem({
    required this.roomNo,
    required this.rent,
    required this.gst,
    required this.name,
    required this.adults,
    required this.kids,
    required this.seniorCitizens,
    required this.checkoutDate,
    required this.idProof,
  });
}

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  String _selectedCustomer = 'Mathew Hyden (+91 9876543210)';
  final String _roomNo = '101';
  final double _rent = 1200.0;
  final double _gst = 112.0;
  final int _adults = 2;
  final int _kids = 0;
  final String _guestName = 'Mathew Hyden';
  final String _checkoutDate = '02/04/2026';
  final String _idProofFile = 'mathewhyden_aadhaar.pdf';

  late List<CheckInGuestItem> _guestList;

  @override
  void initState() {
    super.initState();
    _guestList = [
      CheckInGuestItem(roomNo: '102', rent: 1200.0, gst: 112.0, name: 'Mathew Hyden', adults: 2, kids: 0, seniorCitizens: 2, checkoutDate: '02/04/2026', idProof: 'Mathewhyden_id.pdf'),
      CheckInGuestItem(roomNo: '103', rent: 1300.0, gst: 115.0, name: 'Sarah Thompson', adults: 2, kids: 3, seniorCitizens: 3, checkoutDate: '03/04/2026', idProof: 'sarahthompson_pass.pdf'),
      CheckInGuestItem(roomNo: '104', rent: 1400.0, gst: 110.0, name: 'James Smith', adults: 2, kids: 4, seniorCitizens: 4, checkoutDate: '04/04/2026', idProof: 'jamessmith_id.pdf'),
      CheckInGuestItem(roomNo: '105', rent: 1500.0, gst: 122.0, name: 'Emily Clark', adults: 2, kids: 5, seniorCitizens: 5, checkoutDate: '05/04/2026', idProof: 'emilyclark_pan.pdf'),
      CheckInGuestItem(roomNo: '106', rent: 1600.0, gst: 125.0, name: 'Michael Brown', adults: 2, kids: 6, seniorCitizens: 0, checkoutDate: '06/04/2026', idProof: 'michaelbrown_dl.pdf'),
      CheckInGuestItem(roomNo: '107', rent: 1700.0, gst: 150.0, name: 'Jessica Lee', adults: 2, kids: 7, seniorCitizens: 7, checkoutDate: '07/04/2026', idProof: 'jessicalee_id.pdf'),
      CheckInGuestItem(roomNo: '108', rent: 1800.0, gst: 132.0, name: 'David Wilson', adults: 2, kids: 8, seniorCitizens: 0, checkoutDate: '08/04/2026', idProof: 'davidwilson_id.pdf'),
      CheckInGuestItem(roomNo: '109', rent: 1900.0, gst: 135.0, name: 'Sophia Martinez', adults: 2, kids: 9, seniorCitizens: 0, checkoutDate: '09/04/2026', idProof: 'sophiamartinez_id.pdf'),
      CheckInGuestItem(roomNo: '110', rent: 2000.0, gst: 138.0, name: 'Daniel Garcia', adults: 2, kids: 10, seniorCitizens: 0, checkoutDate: '10/04/2026', idProof: 'danielgarcia_id.pdf'),
      CheckInGuestItem(roomNo: '111', rent: 2100.0, gst: 140.0, name: 'Olivia Rodriguez', adults: 2, kids: 11, seniorCitizens: 0, checkoutDate: '11/04/2026', idProof: 'oliviarodriguez_id.pdf'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Screen Header with Search Bar
          _buildCheckInHeader(),

          const SizedBox(height: 18),

          // Top Row: 1. Select Booking & Guest (left) | 2. Review & Update Details (right)
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 1050;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildSelectBookingCard(),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 8,
                      child: _buildReviewUpdateDetailsCard(),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  _buildSelectBookingCard(),
                  const SizedBox(height: 16),
                  _buildReviewUpdateDetailsCard(),
                ],
              );
            },
          ),

          const SizedBox(height: 18),

          // Bottom Row: Live Table (left/middle) | 3. Finalize Check-in & Payment (right)
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 1050;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 8,
                      child: _buildGuestTableCard(),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: _buildFinalizePaymentCard(),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  _buildGuestTableCard(),
                  const SizedBox(height: 16),
                  _buildFinalizePaymentCard(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInHeader() {
    return Row(
      children: [
        const Text(
          'Guest Check-in',
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

  // 1. Select Booking & Guest Card
  Widget _buildSelectBookingCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navy Section Header
          _buildPanelHeader('1. Select Booking & Guest'),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchInput('Search Booking ID / Guest Name'),
                const SizedBox(height: 12),
                const Text(
                  'Select Customer',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textMuted),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppTheme.cardBorder),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCustomer,
                            isExpanded: true,
                            items: [
                              'Mathew Hyden (+91 9876543210)',
                              'Sarah Thompson (+91 9876543211)',
                              'James Smith (+91 9876543212)',
                            ].map((c) {
                              return DropdownMenuItem(
                                value: c,
                                child: Text(c, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedCustomer = val);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Add Guest dialog opened')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        backgroundColor: AppTheme.primaryNavy,
                      ),
                      child: const Text('+ Add Guest', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking Date', style: TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.w500)),
                        SizedBox(height: 3),
                        Text('02/04/2026', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking Time', style: TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.w500)),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Text('07:00 PM', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                            SizedBox(width: 4),
                            Icon(Icons.access_time_rounded, size: 14, color: AppTheme.textMuted),
                          ],
                        ),
                      ],
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

  // 2. Review & Update Details Card
  Widget _buildReviewUpdateDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPanelHeader('2. Review & Update Details'),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                // Top fields: Room No, Rent, GST, Tenant Name, Adults, Kids
                Row(
                  children: [
                    // Room No Badge
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Room No.', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textMuted)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5D5B8), // Gold banner
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFCBB799)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.bed_rounded, size: 14, color: AppTheme.primaryNavy),
                              const SizedBox(width: 4),
                              Text(_roomNo, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.primaryNavy)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: _buildLabeledInput('Rent', _rent.toStringAsFixed(2)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: _buildLabeledInput('GST', '${_gst.toStringAsFixed(2)} %'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: _buildLabeledInput('Tenant Name', _guestName),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: _buildLabeledInput('No-of Adults', '0$_adults'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: _buildLabeledInput('No-of Kids', '0$_kids'),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Middle Row: Checkout Date, Update ID Proof, Update Adults/Kids, Additional Charges
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          _buildLabeledInput('Checkout Date', _checkoutDate, icon: Icons.calendar_month_rounded),
                          const SizedBox(height: 8),
                          // Upload button
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.upload_file_rounded, size: 16),
                            label: const Text('Upload ID', style: TextStyle(fontSize: 11)),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 38),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          _buildLabeledInput('Update ID Proof', _idProofFile, icon: Icons.description_outlined),
                          const SizedBox(height: 8),
                          _buildLabeledInput('Guest Count', '02'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          _buildLabeledInput('Update No. of Adults/Kids', 'Mathew Hade'),
                          const SizedBox(height: 8),
                          _buildLabeledInput('Update Guest Name', 'Mathew Hyden'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Additional Charges Box
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppTheme.cardBorder),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Additional Charges', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child: Text('Room Charge', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 9, color: AppTheme.textMuted))),
                                Text('2 beds', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child: Text('Extra Charges', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 9, color: AppTheme.textMuted))),
                                Text('₹200', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child: Text('Tax', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 9, color: AppTheme.textMuted))),
                                Text('₹2500.00', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Action Bar: Delete, Edit, Update, Confirm Guest Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_outline_rounded, size: 14),
                      label: const Text('Delete', style: TextStyle(fontSize: 11)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_outlined, size: 14),
                      label: const Text('Edit', style: TextStyle(fontSize: 11)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.update_rounded, size: 14),
                      label: const Text('Update', style: TextStyle(fontSize: 11)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Guest details confirmed!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryNavy,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      child: const Text('Confirm Guest Details', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
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

  // Live Check-in Guest Table
  Widget _buildGuestTableCard() {
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
              headingTextStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppTheme.textDark, letterSpacing: 0.3),
              dataTextStyle: const TextStyle(fontSize: 11, color: AppTheme.textDark, fontWeight: FontWeight.w500),
              horizontalMargin: 12,
              columnSpacing: 14,
              columns: const [
                DataColumn(label: Text('ROOM NO.')),
                DataColumn(label: Text('RENT (₹)')),
                DataColumn(label: Text('GST')),
                DataColumn(label: Text('NAME')),
                DataColumn(label: Text('NO:OF ADULTS')),
                DataColumn(label: Text('NO:OF KIDS')),
                DataColumn(label: Text('SENIOR CITIZEN')),
                DataColumn(label: Text('CHECKOUT DATE')),
                DataColumn(label: Text('ID PROOF')),
                DataColumn(label: Text('ACTION')),
              ],
              rows: _guestList.map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text(item.roomNo, style: const TextStyle(fontWeight: FontWeight.w700))),
                    DataCell(Text('₹${item.rent.toStringAsFixed(2)}')),
                    DataCell(Text('₹${item.gst.toStringAsFixed(2)}')),
                    DataCell(Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600))),
                    DataCell(Text('0${item.adults}')),
                    DataCell(Text('0${item.kids}')),
                    DataCell(Text('0${item.seniorCitizens}')),
                    DataCell(Text(item.checkoutDate)),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(child: Text(item.idProof, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: AppTheme.textMuted))),
                          const SizedBox(width: 4),
                          const Icon(Icons.description_outlined, size: 14, color: AppTheme.textMuted),
                        ],
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.more_vert_rounded, size: 16, color: AppTheme.textMuted),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Action menu for Room ${item.roomNo}')),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Finalize Check-in & Payment Card
  Widget _buildFinalizePaymentCard() {
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
          _buildPanelHeader('3. Finalize Check-in & Payment'),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPriceRow('Room Charge', '₹2500.00'),
                const SizedBox(height: 6),
                _buildPriceRow('Extra Charges', '₹2500.00'),
                const SizedBox(height: 6),
                _buildPriceRow('Tax', '₹0.00'),
                const Divider(height: 20),
                _buildPriceRow('Total Amount:', '₹2500.00', isLarge: true),
                const SizedBox(height: 8),
                _buildPriceRow('Total Paid:', '₹2500.00', isSubLarge: true),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Check-in Completed Successfully!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryNavy,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Complete Check-in', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 8)),
                        child: const Text('Get Data', style: TextStyle(fontSize: 10)),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.payment_rounded, size: 12),
                        label: const Text('M-Pay', style: TextStyle(fontSize: 10)),
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 8)),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.print_outlined, size: 12),
                        label: const Text('Print', style: TextStyle(fontSize: 10)),
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 8)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
                  child: const Text('Print Registration Card', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
                        child: const Text('Download Folio', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryNavy,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: const Text('Complete Check-in', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                      ),
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

  Widget _buildSearchInput(String hint) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 11, color: AppTheme.textLight),
          prefixIcon: const Icon(Icons.search_rounded, size: 16, color: AppTheme.textMuted),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildLabeledInput(String label, String value, {IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.textMuted),
        ),
        const SizedBox(height: 3),
        Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textDark),
                ),
              ),
              if (icon != null) Icon(icon, size: 14, color: AppTheme.textMuted),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isLarge = false, bool isSubLarge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isLarge ? 14 : (isSubLarge ? 12 : 11),
            fontWeight: isLarge ? FontWeight.w800 : (isSubLarge ? FontWeight.w700 : FontWeight.w500),
            color: isLarge ? AppTheme.textDark : AppTheme.textMuted,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isLarge ? 17 : (isSubLarge ? 13 : 11),
            fontWeight: isLarge ? FontWeight.w900 : FontWeight.w700,
            color: isLarge ? AppTheme.primaryNavy : AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}
