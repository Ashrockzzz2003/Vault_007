extension DateHelpers on DateTime {
  String toTimeAgoLabel({bool isIntervalNumericVisible = true}) {
    final now = DateTime.now();
    final durationSinceNow = now.difference(this);

    final inDays = durationSinceNow.inDays;
    if (inDays >= 1) {
      return (inDays / 7).floor() >= 1
          ? isIntervalNumericVisible
          ? '1 week ago'
          : 'Last week'
          : inDays >= 2
          ? '$inDays days ago'
          : isIntervalNumericVisible
          ? '1 day ago'
          : 'Yesterday';
    }

    final inHours = durationSinceNow.inHours;
    if (inHours >= 1) {
      return inHours >= 2
          ? '$inHours hours ago'
          : isIntervalNumericVisible
          ? '1 hour ago'
          : 'An hour ago';
    }

    final inMinutes = durationSinceNow.inMinutes;
    if (inMinutes >= 2) {
      return inMinutes >= 2
          ? '$inMinutes minutes ago'
          : isIntervalNumericVisible
          ? '1 minute ago'
          : 'A minute ago';
    }

    final inSeconds = durationSinceNow.inSeconds;
    return inSeconds >= 3 ? '$inSeconds seconds ago' : 'Just now';
  }
}
