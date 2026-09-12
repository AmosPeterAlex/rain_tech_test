import 'package:flutter_bloc/flutter_bloc.dart';

enum AppTab {
  dashboard,
  checkIn,
  checkOut,
  reservations,
}

class NavigationCubit extends Cubit<AppTab> {
  NavigationCubit() : super(AppTab.dashboard);

  void setTab(AppTab tab) => emit(tab);
}
