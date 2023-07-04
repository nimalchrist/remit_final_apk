class limitTimer {
  String appName;
  int limitTime;

  limitTimer(this.appName, this.limitTime);
  limitTimer.fromMap(Map map) {
    appName = map[appName];
    limitTime = map[limitTime];
  }
}
