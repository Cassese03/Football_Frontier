part of 'notification_bloc.dart';


@immutable

sealed class NotificationState {}


final class NotificationInitial extends NotificationState {}


final class NotificationReady extends NotificationState {

  final int currentColor;


  NotificationReady(this.currentColor);

}


final class NotificationLoading extends NotificationState {}

