import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserTypeChanged extends UserEvent {
  final UserType userType;

  const UserTypeChanged(this.userType);

  @override
  List<Object> get props => [userType];
}

// States
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  final UserType userType;

  const UserInitial({this.userType = UserType.student});

  @override
  List<Object> get props => [userType];
}

// User Type Enum
enum UserType { student, teacher }

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitial()) {
    on<UserTypeChanged>(_onUserTypeChanged);
  }

  void _onUserTypeChanged(UserTypeChanged event, Emitter<UserState> emit) {
    emit(UserInitial(userType: event.userType));
  }
}
