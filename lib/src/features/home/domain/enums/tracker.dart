enum Tracker {
  groups,
  bots;

  String get label {
    switch(this) {
      case Tracker.groups:
        return 'Signal Groups';
      case Tracker.bots:
        return 'Bots';
    }
  }
}
