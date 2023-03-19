import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/day.dart';

final daysProvider = NotifierProvider<DayNotifier, List<Day>>(DayNotifier.new);

class DayNotifier extends Notifier<List<Day>> {
  void updateDays(List<Day> days) {
    state = days;
  }
  
  Day? getDay(String day) {
    for (var d in state) {
      if(d.dag?.toUpperCase() == day.toUpperCase()) {
        return d;
      }
    }
    return null;
  }

  @override
  List<Day> build() {
    return [];
  }
}