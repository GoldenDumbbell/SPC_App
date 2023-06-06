class Checksection {
  static String loggedInUser = '';

  static void setLoggecInUser(String email) {
    loggedInUser = email;
  }

  static String getLoggedInUser() {
    return loggedInUser;
  }
}

class username {
  static String loggedInUsername = '';

  static void setLoggecInUsername(String name) {
    loggedInUsername = name;
  }

  static String getLoggedInUsername() {
    return loggedInUsername;
  }
}
