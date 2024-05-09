part of 'regolamento_bloc.dart';

@immutable
sealed class DrawerEvent {}

final class DrawerTapHome extends DrawerEvent {}

final class DrawerTapCalendar extends DrawerEvent {}

final class DrawerTapStanding extends DrawerEvent {}

final class DrawerTapLineups extends DrawerEvent {}

final class DrawerTapAccount extends DrawerEvent {}

final class DrawerTapSettings extends DrawerEvent {}

final class DrawerTapRegolamento extends DrawerEvent {}

final class DrawerTapLogout extends DrawerEvent {}
