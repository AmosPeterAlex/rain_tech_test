import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/booking_cubit.dart';
import '../bloc/booking_state.dart';
import 'widgets/header_bar.dart';
import 'widgets/date_picker_row.dart';
import 'widgets/room_grid.dart';
import 'widgets/booking_summary_card.dart';
import 'widgets/booking_success_dialog.dart';

class BookingScreen extends StatelessWidget {
  final bool isEmbedded;

  const BookingScreen({
    super.key,
    this.isEmbedded = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state.status == BookingStatus.bookingSuccess && state.selectedRoom != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => BookingSuccessDialog(
              state: state,
              onNewBooking: () {
                context.read<BookingCubit>().resetBooking();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<BookingCubit>();

        if (state.status == BookingStatus.loading && state.allRooms.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(color: AppTheme.primaryNavy),
            ),
          );
        }

        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isEmbedded) ...[
              HeaderBar(
                onSearchChanged: (query) {
                  cubit.updateSearchQuery(query);
                },
                onQuickAction: () {
                  cubit.resetBooking();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Starting new room reservation flow.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],

            // Responsive Main Section
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 1024;

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Section: Controls & Room Floor Grid
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DatePickerRow(
                              checkInDate: state.checkInDate,
                              checkOutDate: state.checkOutDate,
                              guestCount: state.guestCount,
                              nights: state.nights,
                              selectedRoomType: state.selectedTypeFilter,
                              onCheckInSelected: (date) {
                                cubit.selectDateRange(
                                  date,
                                  state.checkOutDate,
                                );
                              },
                              onCheckOutSelected: (date) {
                                cubit.selectDateRange(
                                  state.checkInDate,
                                  date,
                                );
                              },
                              onGuestCountChanged: (count) {
                                cubit.updateGuestCount(count);
                              },
                              onRoomTypeSelected: (type) {
                                cubit.filterByType(type);
                              },
                            ),
                            const SizedBox(height: 20),
                            RoomGrid(
                              rooms: state.filteredRooms,
                              selectedRoom: state.selectedRoom,
                              isRoomBooked: (room) => state.isRoomBooked(room),
                              onRoomSelected: (room) {
                                if (state.selectedRoom?.id == room.id) {
                                  cubit.selectRoom(null); // Deselect
                                } else {
                                  cubit.selectRoom(room);
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 20),

                      // Right Section: Booking Summary & Action Panel
                      Expanded(
                        flex: 4,
                        child: BookingSummaryCard(
                          state: state,
                          onConfirm: () => cubit.confirmBooking(),
                          onReset: () => cubit.resetBooking(),
                        ),
                      ),
                    ],
                  );
                }

                // Stack vertically for compact/mobile viewports
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DatePickerRow(
                      checkInDate: state.checkInDate,
                      checkOutDate: state.checkOutDate,
                      guestCount: state.guestCount,
                      nights: state.nights,
                      selectedRoomType: state.selectedTypeFilter,
                      onCheckInSelected: (date) {
                        cubit.selectDateRange(
                          date,
                          state.checkOutDate,
                        );
                      },
                      onCheckOutSelected: (date) {
                        cubit.selectDateRange(
                          state.checkInDate,
                          date,
                        );
                      },
                      onGuestCountChanged: (count) {
                        cubit.updateGuestCount(count);
                      },
                      onRoomTypeSelected: (type) {
                        cubit.filterByType(type);
                      },
                    ),
                    const SizedBox(height: 20),
                    RoomGrid(
                      rooms: state.filteredRooms,
                      selectedRoom: state.selectedRoom,
                      isRoomBooked: (room) => state.isRoomBooked(room),
                      onRoomSelected: (room) {
                        if (state.selectedRoom?.id == room.id) {
                          cubit.selectRoom(null);
                        } else {
                          cubit.selectRoom(room);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    BookingSummaryCard(
                      state: state,
                      onConfirm: () => cubit.confirmBooking(),
                      onReset: () => cubit.resetBooking(),
                    ),
                  ],
                );
              },
            ),
          ],
        );

        if (isEmbedded) {
          return content;
        }

        return Scaffold(
          backgroundColor: AppTheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: content,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
