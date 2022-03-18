import 'dart:math';

class Entry {
  final double blue;
  final double green;
  final double pink;
  final DateTime date;
  final double met;
  final double jogging;

  Entry({
    required this.date,
    required this.blue,
    required this.pink,
    required this.green,
    required this.jogging,
    required this.met,
  });

  factory Entry.dummy() {
    final random = Random();
    return Entry(
        date: DateTime.now(),
        blue: random.nextInt(100).toDouble(),
        green: random.nextInt(100).toDouble(),
        pink: random.nextInt(100).toDouble(),
        met: 230,
        jogging: 4.7);
  }
}