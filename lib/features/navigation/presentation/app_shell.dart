import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../cubit/navigation_cubit.dart';
import '../../dashboard/presentation/dashboard_screen.dart';
import '../../checkin/presentation/checkin_screen.dart';
import '../../checkout/presentation/checkout_screen.dart';
import '../../booking/presentation/booking_screen.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, AppTab>(
      builder: (context, activeTab) {
        final now = DateTime.now();
        final formattedDate = DateFormat('EEE, MMM d, yyyy | h:mm a').format(now);

        return Scaffold(
          backgroundColor: AppTheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Navigation App Bar
                      _buildTopNavBar(context, activeTab, formattedDate),

                      const SizedBox(height: 18),

                      // Active Screen Body
                      _buildScreenBody(activeTab),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopNavBar(BuildContext context, AppTab activeTab, String formattedDate) {
    final nav = context.read<NavigationCubit>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 900;
          final hideDate = constraints.maxWidth < 1400;

          return Row(
            children: [
              // Logo & Hotel Name
              InkWell(
                onTap: () => nav.setTab(AppTab.dashboard),
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryNavy,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.hotel_rounded, color: Colors.white, size: 18),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Raintech',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textDark,
                            letterSpacing: -0.2,
                          ),
                        ),
                        Text(
                          'HOTEL MANAGEMENT',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textMuted,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // Navigation Tabs
              if (!isCompact) ...[
                _buildNavTab(
                  label: 'Dashboard',
                  icon: Icons.dashboard_outlined,
                  isSelected: activeTab == AppTab.dashboard,
                  onTap: () => nav.setTab(AppTab.dashboard),
                ),
                const SizedBox(width: 4),
                _buildNavTab(
                  label: 'Check-in',
                  icon: Icons.login_rounded,
                  isSelected: activeTab == AppTab.checkIn,
                  onTap: () => nav.setTab(AppTab.checkIn),
                ),
                const SizedBox(width: 4),
                _buildNavTab(
                  label: 'Check-Out',
                  icon: Icons.logout_rounded,
                  isSelected: activeTab == AppTab.checkOut,
                  onTap: () => nav.setTab(AppTab.checkOut),
                ),
                const SizedBox(width: 4),
                _buildNavTab(
                  label: 'Reservations',
                  icon: Icons.bed_outlined,
                  isSelected: activeTab == AppTab.reservations,
                  onTap: () => nav.setTab(AppTab.reservations),
                ),
              ],

              const Spacer(),

              // Right Section: Date, Actions, Profile
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!hideDate) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppTheme.cardBorder),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 13, color: AppTheme.textMuted),
                          const SizedBox(width: 6),
                          Text(
                            formattedDate,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textDark),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],

                  // Quick Actions Menu
                  PopupMenuButton<AppTab>(
                    tooltip: 'Quick Navigation',
                    onSelected: (tab) => nav.setTab(tab),
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: AppTab.dashboard, child: Text('Main Dashboard')),
                      const PopupMenuItem(value: AppTab.checkIn, child: Text('Guest Check-in')),
                      const PopupMenuItem(value: AppTab.checkOut, child: Text('Guest Check-Out')),
                      const PopupMenuItem(value: AppTab.reservations, child: Text('Reservations / Room Booking')),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryNavy,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt_rounded, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text('Quick Actions', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Avatar
                  const CircleAvatar(
                    radius: 17,
                    backgroundColor: AppTheme.primaryNavy,
                    child: Text(
                      'AP',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNavTab({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryNavy : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: isSelected ? Colors.white : AppTheme.textMuted),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? Colors.white : AppTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenBody(AppTab activeTab) {
    switch (activeTab) {
      case AppTab.dashboard:
        return const DashboardScreen();
      case AppTab.checkIn:
        return const CheckInScreen();
      case AppTab.checkOut:
        return const CheckOutScreen();
      case AppTab.reservations:
        return const BookingScreen(isEmbedded: true);
    }
  }
}
