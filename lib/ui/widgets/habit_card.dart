import 'package:flutter/material.dart';
import '../../models/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  HabitCard({required this.habit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(habit.name),
      trailing: Icon(
        habit.completed ? Icons.check_circle : Icons.check_circle_outline,
      ),
      onTap: () {
        // Aquí iría la lógica para marcar el hábito como completado/incompleto
      },
    );
  }
}
