class EndpointsConstants {
  EndpointsConstants._();

  static const String baseUrl = 'https://burrla.secop.az';
  // static const String baseUrl = 'https://burla-backend-py.onrender.com';

  // Authentication
  static const login = '$baseUrl/A/users/access-token/';
  static const register = '$baseUrl/A/user-register/';
  static const userUpdate = "$baseUrl/A/user-update/";
  static const babyAdd = "$baseUrl/A/baby-add/";
  static const refreshToken = '$baseUrl/A/users/refresh-token/';

  static const requestResetPassword = '$baseUrl/A/user/password-reset/request/';
  static const verifyOtp = '$baseUrl/A/user/password-reset/confirm/';
  static const resetPassword = '$baseUrl/A/user/password-reset/change/';

  static const changePassword = '$baseUrl/A/user/change-password';

  static const users = '$baseUrl/users';

  static const String pregnancyCalculateDetails =
      '$baseUrl/B1/pregnancy-calculate/';

  // Baby
  static const String babyUrl = '$baseUrl/baby';
  static const String countries = '$babyUrl/name_countries';
  static const String names = '$babyUrl/names';
  static const String selectedNames = '$names/select';
  static const String wishListNames = '$baseUrl/A/wishlist-names/';
  static const String addToWishList = '$baseUrl/A/wishlist-name/add/';
  static const String removeFromWishList = '$baseUrl/A/wishlist-name/remove/';

  // Extra
  static const String dailyRec = '$baseUrl/extra/daily-recommendations/';
  static const String dailyRecDetail =
      '$baseUrl/extra/daily-recommendations-detail/{slug}/';

  static const String faqs = '$baseUrl/extra/faq/';
  static const String privacyPolicy = '$baseUrl/extra/privacy-policy/';
  static const String usingRules = '$baseUrl/extra/using-rules/';
  static const String about = '$baseUrl/extra/about/';
  static const String contact = '$baseUrl/extra/contact-details/';
  static const String extraCountries = '$baseUrl/extra/countries/';
  static const String babyNames = '$baseUrl/extra/baby-names/';
  static const String blogSliders = '$baseUrl/extra/blog-sliders/';
  static const String blogCategories = '$baseUrl/extra/blogs-with-categories/';

  // A
  static const userData = '$baseUrl/A/me/';
  static const userProfileDelete = '$baseUrl/A/delete-account/';

  // A1
  static const String babyIndicators = '$baseUrl/A1/baby-indicators/';
  static const String createIndicator = '$baseUrl/A1/indicators/';

  // B
  static const String tasksByWeek = '$baseUrl/B/guider/tasks-by-weeks/';

  // B1
  static const String notifications = '$baseUrl/B1/notifications/';
  static const String ultraSound = '$baseUrl/B1/ultra-sound/';

  // C
  static const String medicines = '$baseUrl/C/medicines/';
  static const String medicineCreate = '$baseUrl/C/medicines/create/';
  static const String medicinePatch = '$baseUrl/C/medicines/{slug}/update/';
  static const String doctorReserve = '$baseUrl/C/doctor-reserve/';
  static const String myReservations = '$baseUrl/C/my-reservations/';

  // D
  static const forumCategory = "$baseUrl/D/forum-category-list/";
  static const forumCategoryStats = "$baseUrl/D/forum-category-stats/";
  static const forumList = "$baseUrl/D/forum-list/";
  static const forumDetail = "$baseUrl/D/forum-detail";
  static const forumComments = "$baseUrl/D/forum-comment";
  static const createComment = "$baseUrl/D/comments/";
  static const reportComment = '$baseUrl/D/forum-comment/report-create/';
  static const blockUser = '$baseUrl/A/user-block-create/';

  static const user = "$baseUrl/D/forum/videodoktor/user/";
  // static const forumCreate = '$baseUrl/D/forum-create/';

  static const String doctorsList = '$baseUrl/C/doctors-list/';
  static const String doctorDetail = '$baseUrl/C/doctors-detail/{slug}/';
}
