import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../navigation/cubit/navigation_cubit.dart';

enum DashboardRoomStatus {
  available,
  occupied,
  dirty,
  maintenance,
  blocked,
}

class DashboardRoomItem {
  final String number;
  final int floor;
  DashboardRoomStatus status;

  DashboardRoomItem({
    required this.number,
    required this.floor,
    required this.status,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<DashboardRoomItem> _floor1Rooms;
  late List<DashboardRoomItem> _floor2Rooms;
  String? _selectedRoomNumber = '101';

  @override
  void initState() {
    super.initState();
    _initRooms();
  }

  void _initRooms() {
    // Floor 1 (rooms 101 - 116)
    _floor1Rooms = [
      DashboardRoomItem(number: '101', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '102', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '103', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '104', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '105', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '106', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '107', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '108', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '109', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '110', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '111', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '112', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '113', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '114', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '115', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '116', floor: 1, status: DashboardRoomStatus.available),
      // Second row floor 1
      DashboardRoomItem(number: '101', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '102', floor: 1, status: DashboardRoomStatus.occupied),
      DashboardRoomItem(number: '103', floor: 1, status: DashboardRoomStatus.occupied),
      DashboardRoomItem(number: '104', floor: 1, status: DashboardRoomStatus.dirty),
      DashboardRoomItem(number: '105', floor: 1, status: DashboardRoomStatus.dirty),
      DashboardRoomItem(number: '106', floor: 1, status: DashboardRoomStatus.maintenance),
      DashboardRoomItem(number: '107', floor: 1, status: DashboardRoomStatus.maintenance),
      DashboardRoomItem(number: '108', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '109', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '110', floor: 1, status: DashboardRoomStatus.occupied),
      DashboardRoomItem(number: '111', floor: 1, status: DashboardRoomStatus.occupied),
      DashboardRoomItem(number: '112', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '113', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '114', floor: 1, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '115', floor: 1, status: DashboardRoomStatus.occupied),
      DashboardRoomItem(number: '190', floor: 1, status: DashboardRoomStatus.maintenance),
    ];

    // Floor 2 (rooms 201 - 216)
    _floor2Rooms = [
      DashboardRoomItem(number: '201', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '202', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '203', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '204', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '205', floor: 2, status: DashboardRoomStatus.maintenance),
      DashboardRoomItem(number: '210', floor: 2, status: DashboardRoomStatus.blocked),
      DashboardRoomItem(number: '207', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '208', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '209', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '210', floor: 2, status: DashboardRoomStatus.maintenance),
      DashboardRoomItem(number: '211', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '212', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '213', floor: 2, status: DashboardRoomStatus.blocked),
      DashboardRoomItem(number: '214', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '215', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '216', floor: 2, status: DashboardRoomStatus.available),
      // Second row floor 2
      DashboardRoomItem(number: '201', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '202', floor: 2, status: DashboardRoomStatus.occupied),
      DashboardRoomItem(number: '203', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '204', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '205', floor: 2, status: DashboardRoomStatus.maintenance),
      DashboardRoomItem(number: '206', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '207', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '208', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '209', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '210', floor: 2, status: DashboardRoomStatus.blocked),
      DashboardRoomItem(number: '201', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '202', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '203', floor: 2, status: DashboardRoomStatus.occupied),
      DashboardRoomItem(number: '204', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '205', floor: 2, status: DashboardRoomStatus.available),
      DashboardRoomItem(number: '206', floor: 2, status: DashboardRoomStatus.dirty),
    ];
  }

  void _cycleRoomStatus(DashboardRoomItem item) {
    setState(() {
      switch (item.status) {
        case DashboardRoomStatus.available:
          item.status = DashboardRoomStatus.occupied;
          break;
        case DashboardRoomStatus.occupied:
          item.status = DashboardRoomStatus.dirty;
          break;
        case DashboardRoomStatus.dirty:
          item.status = DashboardRoomStatus.maintenance;
          break;
        case DashboardRoomStatus.maintenance:
          item.status = DashboardRoomStatus.blocked;
          break;
        case DashboardRoomStatus.blocked:
          item.status = DashboardRoomStatus.available;
          break;
      }
      _selectedRoomNumber = item.number;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Room ${item.number} status updated to ${item.status.name.toUpperCase()}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Title
          const Text(
            'Main Dashboard',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppTheme.textDark,
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 16),

          // Top Modules Grid + Operational Overview
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 1100;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 8,
                      child: _buildQuickActionsGrid(context),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: _buildOperationalOverview(),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  _buildQuickActionsGrid(context),
                  const SizedBox(height: 16),
                  _buildOperationalOverview(),
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          // Middle Section: Room Status - Interactive Floor View
          _buildInteractiveFloorView(),

          const SizedBox(height: 20),

          // Bottom Section: Going to Vacate Rooms & Quick Status Changer
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 1000;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildVacatingRoomsPanel(),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 5,
                      child: _buildQuickStatusChanger(),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  _buildVacatingRoomsPanel(),
                  const SizedBox(height: 16),
                  _buildQuickStatusChanger(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // 1. Quick Actions Grid
  Widget _buildQuickActionsGrid(BuildContext context) {
    final nav = context.read<NavigationCubit>();

    final actionItems = [
      _ActionCardData(
        title: 'Guest Check-in',
        icon: Icons.assignment_turned_in_outlined,
        color: const Color(0xFF10B981),
        onTap: () => nav.setTab(AppTab.checkIn),
      ),
      _ActionCardData(
        title: 'Guest Check-Out',
        icon: Icons.exit_to_app_rounded,
        color: const Color(0xFFF97316),
        onTap: () => nav.setTab(AppTab.checkOut),
      ),
      _ActionCardData(
        title: 'Reservations',
        icon: Icons.calendar_month_outlined,
        color: const Color(0xFF3B82F6),
        onTap: () => nav.setTab(AppTab.reservations),
      ),
      _ActionCardData(
        title: 'Housekeeping',
        icon: Icons.cleaning_services_outlined,
        color: const Color(0xFF06B6D4),
      ),
      _ActionCardData(
        title: 'Restaurant',
        icon: Icons.restaurant_outlined,
        color: const Color(0xFFF59E0B),
      ),
      _ActionCardData(
        title: 'WhatsApp',
        icon: Icons.chat_bubble_outline_rounded,
        color: const Color(0xFF22C55E),
      ),
      _ActionCardData(
        title: 'Rooms',
        icon: Icons.door_sliding_outlined,
        color: const Color(0xFF8B5CF6),
      ),
      _ActionCardData(
        title: 'Staff',
        icon: Icons.badge_outlined,
        color: const Color(0xFF6366F1),
        badgeText: '2 tasks',
      ),
      _ActionCardData(
        title: 'Floors',
        icon: Icons.layers_outlined,
        color: const Color(0xFF14B8A6),
      ),
      _ActionCardData(
        title: 'Reports',
        icon: Icons.bar_chart_rounded,
        color: const Color(0xFFEAB308),
      ),
      _ActionCardData(
        title: 'Settings',
        icon: Icons.tune_rounded,
        color: const Color(0xFF64748B),
      ),
      _ActionCardData(
        title: 'New: Group Booking',
        icon: Icons.groups_outlined,
        color: const Color(0xFF3B82F6),
        onTap: () => nav.setTab(AppTab.reservations),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 6;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 2;
        } else if (constraints.maxWidth < 850) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth < 1100) {
          crossAxisCount = 4;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 96,
          ),
          itemCount: actionItems.length,
          itemBuilder: (context, index) {
            final item = actionItems[index];
            return _buildActionCard(item);
          },
        );
      },
    );
  }

  Widget _buildActionCard(_ActionCardData data) {
    return InkWell(
      onTap: data.onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${data.title} module opened.'),
                duration: const Duration(milliseconds: 800),
              ),
            );
          },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.cardBorder),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: data.color.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      data.icon,
                      color: data.color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
              ),
            ),
            if (data.badgeText != null)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Text(
                    data.badgeText!,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF92400E),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 2. Operational Overview Card
  Widget _buildOperationalOverview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Operational Overview',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  label: 'Occupancy',
                  value: '4%',
                  hasIndicator: true,
                  bg: const Color(0xFFEEF2FF),
                  textColor: const Color(0xFF3730A3),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetricTile(
                  label: 'Pending Check-ins',
                  value: '0',
                  bg: const Color(0xFFF8FAFC),
                  textColor: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  label: 'Pending Departures',
                  value: '0',
                  bg: const Color(0xFFF8FAFC),
                  textColor: AppTheme.textDark,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetricTile(
                  label: 'Revenue Today',
                  value: '₹0',
                  bg: const Color(0xFFECFDF5),
                  textColor: const Color(0xFF065F46),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required Color bg,
    required Color textColor,
    bool hasIndicator = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppTheme.textMuted,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasIndicator) ...[
                Container(
                  width: 5,
                  height: 14,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
              Text(
                value,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Room Status — Interactive Floor View
  Widget _buildInteractiveFloorView() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Room Status - Interactive Floor View',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '50 rooms across your property',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
              Text(
                'Selected Room: $_selectedRoomNumber',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryNavy,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          _buildFloorRow('Floor 1', _floor1Rooms),
                          const SizedBox(height: 14),
                          _buildFloorRow('Floor 2', _floor2Rooms),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    _buildOccupancyDoughnut(),
                  ],
                );
              }
              return Column(
                children: [
                  _buildFloorRow('Floor 1', _floor1Rooms),
                  const SizedBox(height: 14),
                  _buildFloorRow('Floor 2', _floor2Rooms),
                  const SizedBox(height: 16),
                  _buildOccupancyDoughnut(),
                ],
              );
            },
          ),

          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Status Legend
          Wrap(
            spacing: 16,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildLegendTag(const Color(0xFF4ADE80), 'Available'),
              _buildLegendTag(const Color(0xFF60A5FA), 'Occupied'),
              _buildLegendTag(const Color(0xFFF87171), 'Dirty'),
              _buildLegendTag(const Color(0xFFFB923C), 'Maintenance'),
              _buildLegendTag(const Color(0xFF94A3B8), 'Blocked'),
              const Text(
                'Clicking a room tile opens quick-edit / cycles status',
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloorRow(String floorLabel, List<DashboardRoomItem> rooms) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 54,
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Text(
              floorLabel,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: rooms.map((room) {
              Color bg;
              Color text = Colors.white;

              switch (room.status) {
                case DashboardRoomStatus.available:
                  bg = const Color(0xFF86EFAC); // Mint Green
                  text = const Color(0xFF14532D);
                  break;
                case DashboardRoomStatus.occupied:
                  bg = const Color(0xFF60A5FA); // Blue
                  text = Colors.white;
                  break;
                case DashboardRoomStatus.dirty:
                  bg = const Color(0xFFF87171); // Red
                  text = Colors.white;
                  break;
                case DashboardRoomStatus.maintenance:
                  bg = const Color(0xFFFB923C); // Orange
                  text = Colors.white;
                  break;
                case DashboardRoomStatus.blocked:
                  bg = const Color(0xFFCBD5E1); // Grey
                  text = const Color(0xFF334155);
                  break;
              }

              final isSelected = _selectedRoomNumber == room.number;

              return InkWell(
                onTap: () => _cycleRoomStatus(room),
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: 36,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isSelected ? AppTheme.primaryNavy : Colors.transparent,
                      width: isSelected ? 2 : 0.5,
                    ),
                  ),
                  child: Text(
                    room.number,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: text,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildOccupancyDoughnut() {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  value: 0.04,
                  strokeWidth: 8,
                  backgroundColor: const Color(0xFFE2E8F0),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                ),
              ),
              const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '200',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textDark,
                    ),
                  ),
                  Text(
                    'Rooms Total',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '4% Occupied',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF047857),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendTag(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }

  // 4. Going to Vacate Rooms Panel
  Widget _buildVacatingRoomsPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.bed_rounded, size: 18, color: AppTheme.primaryNavy),
              SizedBox(width: 8),
              Text(
                'Going to Vacate Rooms',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Room 101 Card
              Expanded(
                child: _buildVacateCard(
                  roomNo: 'Room 101',
                  subtitle: 'Departing - Guest Check-Out Scheduled',
                  icon: Icons.hotel_rounded,
                ),
              ),
              const SizedBox(width: 10),
              // Room 102 Card
              Expanded(
                child: _buildVacateCard(
                  roomNo: 'Room 102',
                  subtitle: 'Departing - Guest Checkout: 11:00 AM',
                  icon: Icons.meeting_room_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Alert chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.warningAmber,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.warningAmberBorder),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: AppTheme.warningAmberText,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Room 101 cleaning overdue (Check-out scheduled)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.warningAmberText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVacateCard({
    required String roomNo,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            child: Icon(icon, color: AppTheme.primaryNavy, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomNo,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 5. Quick Room Status Changer & Actions
  Widget _buildQuickStatusChanger() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Room Status Changer & Actions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.cardBorder),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedRoomNumber,
                      isExpanded: true,
                      hint: const Text('Room #'),
                      items: ['101', '102', '103', '104', '105', '201', '202', '203'].map((no) {
                        return DropdownMenuItem(
                          value: no,
                          child: Text(
                            'Room $no',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedRoomNumber = val);
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 6,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Room $_selectedRoomNumber marked clean & ready!'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.cleaning_services_rounded, size: 16),
                  label: const Text(
                    'Cleaning done, ready',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('All dirty rooms queued for cleaning.'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF1F2),
                    foregroundColor: const Color(0xFFBE123C),
                    side: const BorderSide(color: Color(0xFFFECDD3)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    'Set all Dirty to Cleaning',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Loading all maintenance rooms...'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    'View All Maintenance',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionCardData {
  final String title;
  final IconData icon;
  final Color color;
  final String? badgeText;
  final VoidCallback? onTap;

  _ActionCardData({
    required this.title,
    required this.icon,
    required this.color,
    this.badgeText,
    this.onTap,
  });
}
