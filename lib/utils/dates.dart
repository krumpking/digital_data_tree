class DateAlgos {
  static int getDifferenceOfDates(String date1, String date2) {
    DateTime firstDate = DateTime.parse(date1);
    DateTime secondDate = DateTime.parse(date2);

    Duration difference = firstDate.difference(secondDate);

    return difference.inDays;
  }
}
