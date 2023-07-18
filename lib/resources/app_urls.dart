
class AppUrls{

  static var baseURL = "https://clientapps.webhopers.com:3069/api/app/";

  // static const String localBaseURL = "http://192.168.0.155:3015/api/app/";

  // ignore: non_constant_identifier_names
  static var validate_otp = "${baseURL}rep/verifyotp";
  static var login = "${baseURL}rep/login";
  static var register = "${baseURL}franchisee/register";
  static var registerFields = "${baseURL}registration/fields";
  static var getRegisterDivisions = "${baseURL}product/up/division/get";

  static var getMrs = "${baseURL}rep/get";
  static var getVisits = "${baseURL}rep/visit/get";

  static var forgotPassword = "${baseURL}rep/search";

  static var resetPassword = "${baseURL}rep/resetPassword";
  static var resetAccount = "${baseURL}rep/resetaccount";

  static var getDashboardCount = "${baseURL}dashboard/count";

// Products
  static var getProducts = "${baseURL}product/get";
  static var getFavouriteProducts = "${baseURL}product/fav/get";
  static var addToFavouriteProduct = "${baseURL}product/fav/add";
  static var deleteFavouriteProduct = "${baseURL}product/fav/delete";
  static var productSearch = "${baseURL}product/search";
  static var getDivisions = "${baseURL}product/division/get";
  static var getProductCategories = "${baseURL}product/category/get";

  // Visual aids
  static var getVisualAids = "${baseURL}product/visualates";

  // drawer
  static var getAbout = "${baseURL}about";
  static var getPromotional = "${baseURL}about/promotional";
  static var getOffers = "${baseURL}offer/get";
  static var getCustomers = "${baseURL}customer/get";
  static var getDailySalesReport = "${baseURL}rep/report";

  // Add
  static var addCustomer = "${baseURL}customer/add";
  static var updateCustomer = "${baseURL}customer/update";
  static var addMR = "${baseURL}rep/add";
  static var addVisit = "${baseURL}rep/visit/add";
  static var deactivateMR = "${baseURL}rep/deactivate";
  static var activateMR = "${baseURL}rep/activate";

  static var logout = "${baseURL}rep/logout";

  static var updateMr = "${baseURL}rep/mr-update";
  static var deleteMr = "${baseURL}rep/mr-delete";

  //Orders
  static var getMyOrder = "${baseURL}companyOrder/get";
  static var reOrder = "${baseURL}companyOrder/add";
  static var customerOrder = "${baseURL}order/get";
  static var addOrder = "${baseURL}order/add";

  // self analysis
  static var getWorkAnalysis = "${baseURL}rep/visit/getWorkAnalysis";

  //Profile
  static var getProfile = "${baseURL}rep/profile";
  static var getFirm = "${baseURL}franchisee/get";
  static var updateProfile = "${baseURL}rep/update";
  static var firmUpdate = "${baseURL}franchisee/update";
  static var changePassword = "${baseURL}rep/changePassword";

  // Before Login
  static var checkupApi = "${baseURL}check";
  static var homeCountApi = "${baseURL}dashboard/up/count";
  static var productApi = "${baseURL}product/up/get";
  static var productSearchApi = "${baseURL}product/up/search";
  static var divisionApi = "${baseURL}product/up/division/get";
  static var categoryApi = "${baseURL}product/up/category/get";
  static var typeApi = "${baseURL}product/up/type/get";
  static var visualAidsApi = "${baseURL}product/up/visualates";
  static var enquiryApi = "${baseURL}enquiry";
  static var packingType = "${baseURL}product/packingType/get";

  //states & cities
  static var state = "${baseURL}states/";
  //FAQs
  static var faqs = "${baseURL}faqs";

}

// static var request_otp = "${baseURL}rep/resetaccount";
// static var city = "$baseURL/location/city";
// static var getProductTypes = "${baseURL}product/type/get";
//  static var checkApi = "${baseURL}check";