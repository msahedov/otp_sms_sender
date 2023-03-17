enum BoxType { message, inbox, settings }

extension BoxTypeMapping on BoxType {
  String get stringValue {
    switch (this) {
      case BoxType.message:
        return 'message';
      case BoxType.settings:
        return 'settings';
      default:
        return 'message';
    }
  }
}
