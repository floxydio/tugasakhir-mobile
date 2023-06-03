class IntToMonth {
  static String monthConverter(int month) {
    if (month < 1 || month > 12) {
      throw Exception('Invalid month value');
    }

    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return monthNames[month - 1];
  }
}
