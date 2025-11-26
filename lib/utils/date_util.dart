String weekday(DateTime date) {
  const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  return days[date.weekday - 1];
}

String formatDate(DateTime date) {
  return "${weekday(date)} ${date.day}";
}
