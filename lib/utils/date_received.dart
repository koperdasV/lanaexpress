String timePassedParse(String date) {
  final DateTime lastTime = DateTime.parse(date);
  final Duration timePassed = DateTime.now().difference(lastTime);

  if (timePassed.inDays > 0) {
    return '${timePassed.inDays} days';
  } else if (timePassed.inHours > 0) {
    return '${timePassed.inHours} h';
  } else if (timePassed.inMinutes > 0) {
    return '${timePassed.inMinutes} min';
  } else {
    return '${timePassed.inSeconds} sec';
  }
}

