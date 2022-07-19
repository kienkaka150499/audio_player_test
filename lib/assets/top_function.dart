String timeFormat(Duration duration) {
  String minutes = '00';
  String seconds = '00';
  duration.inMinutes < 10 ? minutes = '0${duration.inMinutes}' : minutes = '${duration.inMinutes}';
  duration.inSeconds % Duration.secondsPerMinute < 10
      ? seconds = '0${duration.inSeconds % Duration.secondsPerMinute}'
      : seconds = '${duration.inSeconds % Duration.secondsPerMinute}';
  return '$minutes:$seconds';
}

int iconRepeatTapCount = 0;

// List playlist=playlist;
