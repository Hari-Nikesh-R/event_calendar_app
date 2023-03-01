class ConfigurationSession{
  static final ConfigurationSession _singleton = ConfigurationSession._internal();
  ConfigurationSession._internal();
  factory ConfigurationSession() {
    return _singleton;
  }

}