final String prefix = 'dev-';

class Storage {
  static final String user = "user";
  static final String mainBox = "mainBox";
  static final String language = "language";
  static final String lastTokenTime = "lastTokenTime";
  static final String lastRead = "LastRead";
  static final String appMode = "appMode";
  static final Map<String, String> firebase = {
    'user': prefix + 'users',
    'timeline': prefix + 'timeline'
  };
}
