String countTimeDifference(DateTime timePosted, DateTime timeNow) {
  final Duration timeDiff = timeNow.difference(timePosted);
  if (timeDiff.inDays == 0) {
    if (timeDiff.inHours == 0) {
      if (timeDiff.inMinutes == 0) {
        if (timeDiff.inSeconds == 0) {
          return 'just now';
        }
        return '${timeDiff.inSeconds.toString()}s';
      }
      return '${timeDiff.inMinutes.toString()}m';
    }
    return '${timeDiff.inHours.toString()}h';
  }
  return '${timeDiff.inDays.toString()}d';
}
