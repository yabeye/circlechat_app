part of 'presence_cubit.dart';

abstract class PresenceState {}

class PresenceInitial extends PresenceState {}

class PresenceUpdated extends PresenceState {
  final bool isOnline;
  final DateTime lastSeen;

  PresenceUpdated(this.isOnline, this.lastSeen);
}

class PresenceError extends PresenceState {
  final String errorMessage;
  PresenceError(this.errorMessage);
}

class PresenceForeground extends PresenceState {}

class PresenceBackground extends PresenceState {}
