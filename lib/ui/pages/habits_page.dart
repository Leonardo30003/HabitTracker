import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit/blocs/habits_bloc.dart';
import 'package:habit/models/habit.dart';
import '../widgets/habit_card.dart';

class HabitsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker'),
      ),
      body: BlocBuilder<HabitsBloc, HabitsState>(
        builder: (context, state) {
          if (state is HabitsLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HabitsLoadSuccess) {
            if (state.habits.isEmpty) {
              return Center(child: Text('No habits added'));
            }
            return ListView(
              children: state.habits.map((habit) => HabitCard(habit: habit)).toList(),
            );
          } else if (state is HabitsLoadFailure) {
            return Center(child: Text('Failed to load habits'));
          } else {
            // Si el estado no es reconocido, muestra un mensaje de error.
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  // Esta función muestra un diálogo para añadir un nuevo hábito
  void _showAddHabitDialog(BuildContext context) {
    final TextEditingController _textFieldController = TextEditingController();

    // Muestra un AlertDialog con un TextField para ingresar el nombre del hábito
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Habit'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Habit name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ADD'),
              onPressed: () {
                if (_textFieldController.text.isNotEmpty) {
                  final habit = Habit(
                    id: DateTime.now().toString(),
                    name: _textFieldController.text,
                    completed: false,
                  );
                  // Añade el hábito utilizando el BLoC
                  context.read<HabitsBloc>().add(AddHabitEvent(habit));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
