class ApiUrls {
  ApiUrls._();

  // Change base URL
  static const bool change = false;

  // Base URL Candidate
  static const baseUrlProd = "http://candidat.aptiotalent.com/api";
  static const baseUrlTest = "http://land-scan.sodalite-consulting.com/api";

  // Pour obtenir la bonne base URL
  static String get baseUrl => change ? baseUrlProd : baseUrlTest;

  // Authentication
  static String get postLoginUrl => "$baseUrl/loginAgent";
  static String get getLogoutUrl => "$baseUrl/logout/";

  // Events
  static String get getListEventScanUrl => "$baseUrl/event/";
  static String get getListEventUrl => "$baseUrl/eventFive/";
  static String get postEventScanUrl => "$baseUrl/scanne";

}