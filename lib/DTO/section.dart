class Checksection {
  static String loggedInUser = '';

  static void setLoggecInUser(String email) {
    loggedInUser = email;
  }

  static String getLoggedInUser() {
    return loggedInUser;
  }
}
