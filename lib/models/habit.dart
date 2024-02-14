class Habit {
  final String id;
  final String name;
  final bool completed;

  Habit({required this.id, required this.name, this.completed = false});

  Habit copyWith({String? name, bool? completed}) {
    return Habit(
      id: this.id,
      name: name ?? this.name,
      completed: completed ?? this.completed,
    );
  }
}
