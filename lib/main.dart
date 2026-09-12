import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/booking/bloc/booking_cubit.dart';
import 'features/booking/data/mock_room_repository.dart';
import 'features/navigation/cubit/navigation_cubit.dart';
import 'features/navigation/presentation/app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RaintechHotelBookingApp());
}

class RaintechHotelBookingApp extends StatelessWidget {
  const RaintechHotelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MockRoomRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider(
            create: (context) => BookingCubit(
              repository: context.read<MockRoomRepository>(),
            )..loadInitialData(),
          ),
        ],
        child: MaterialApp(
          title: 'Raintech Hotel - Management Suite',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const AppShell(),
        ),
      ),
    );
  }
}
