class DateUtil {
  static List<String> getWeekDate() {
    Duration day = Duration(days: 1);
    List<String> dates = [];
    DateTime dt = DateTime.now();
    dates.add('${dt.month}/${dt.day}(今)');
    dt = dt.subtract(day);
    dates.insert(0, '${dt.month}/${dt.day}');
    dt = dt.subtract(day);
    dates.insert(0, '${dt.month}/${dt.day}');
    dt = dt.subtract(day);
    dates.insert(0, '${dt.month}/${dt.day}');
    dt = dt.subtract(day);
    dates.insert(0, '${dt.month}/${dt.day}');
    dt = dt.subtract(day);
    dates.insert(0, '${dt.month}/${dt.day}');
    dt = dt.subtract(day);
    dates.insert(0, '${dt.month}/${dt.day}');
    return dates;
  }
}
