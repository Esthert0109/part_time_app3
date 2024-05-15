// common
const port = "http://103.159.133.27:8085/";

// User Services
const loginUrl = "api/v1/login/do-login";
const registrationUrl = "api/v1/customers/";
const getUserInfoUrl = "api/v1/customers/info";
const checkUrl = "api/v1/customers/users/check";
const sendOTPUrl = "api/v1/sms/send/";
const verifyOTPUrl = "api/v1/sms/verify/mobile/";
const updateForgotPasswordUrl = "api/v1/customers/updatePassByForgot/";

//explore Services
const exploreURL = "api/v1/tasks/getTaskListByDateDesc?";
const explorePriceURL = "api/v1/tasks/getTaskListByPrice";
const collectionURL = "api/v1/collection/my-collection";
const searchResultPage =
    "api/v1/taskss/searchByKeywords?keyword=Test&sortOrder=desc";
const advertisementPage = "api/v1/advertisement/all";

//system message Services
const systemMessage = "api/v1/notification/system?page=1";
const getNotificationTipsUrl = "api/v1/notification/getLatestNotificationTips";

// Categories
const getCategoryListUrl = "api/v1/categories/getCategoryList";
