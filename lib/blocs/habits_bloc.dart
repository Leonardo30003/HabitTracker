import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/habit.dart';
import 'dart:collection';

// Eventos
abstract class HabitsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddHabitEvent extends HabitsEvent {
  final Habit habit;

  AddHabitEvent(this.habit);

  @override
  List<Object> get props => [habit];
}

class ToggleHabitCompletionEvent extends HabitsEvent {
  final String habitId;

  ToggleHabitCompletionEvent(this.habitId);

  @override
  List<Object> get props => [habitId];
}

// Estados
abstract class HabitsState extends Equatable {
  @override
  List<Object> get props => [];
}

class HabitsLoadInProgress extends HabitsState {}

class HabitsLoadSuccess extends HabitsState {
  final UnmodifiableListView<Habit> habits;

  HabitsLoadSuccess(this.habits);

  @override
  List<Object> get props => [habits];
}

class HabitsLoadFailure extends HabitsState {}

// BLoC
class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final List<Habit> _habits = [];

  HabitsBloc() : super(HabitsLoadInProgress()) {
    on<AddHabitEvent>((event, emit) {
      _habits.add(event.habit);
      emit(HabitsLoadSuccess(UnmodifiableListView(_habits)));
    });

    on<ToggleHabitCompletionEvent>((event, emit) {
      final index = _habits.indexWhere((habit) => habit.id == event.habitId);
      if (index != -1) {
        _habits[index] = _habits[index].copyWith(completed: !_habits[index].completed);
        emit(HabitsLoadSuccess(UnmodifiableListView(_habits)));
      }
    });
  }
}
