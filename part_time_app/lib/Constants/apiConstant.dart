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
const updateUserInfoUrl = "api/v1/customers/updateInfo";

//explore Services
const exploreURL = "api/v1/tasks/getTaskListByDateDesc?";
const explorePriceURL = "api/v1/tasks/getTaskListByPrice";
const collectionURL = "api/v1/collection/my-collection";
const createCollectionURL = "api/v1/collection/create?taskId=";
const searchResultPage = "api/v1/tasks/searchByKeywords?";
const searchbyTag = "api/v1/tasks/searchByTag?";
const advertisementPage = "api/v1/advertisement/all";

// order Services
const getOrderByStatusUrl = "api/v1/orders/getOrderListByStatusId/";
const getTaskByStatusUrl = "api/v1/tasks/getTaskListByStatusId/";
const getOrderDetailByOrderIdUrl = "api/v1/orders/getOrderDetailsByOrderId/";
const getTaskDetailByTaskIdUrl = "api/v1/tasks/getTaskDetails/";
const unshelveTaskUrl = "api/v1/tasks/unshelves?";
const createOrderUrl = "api/v1/orders/create/";
const createTaskUrl = "api/v1/tasks/create";
const submitOrderUrl = "api/v1/orders/submit";
const submitTaskUrl = "api/v1/tasks/submit/";
const updateTaskUrl = "/api/v1/tasks/updateTask";
const getCustomerListByOrderStatusIdUrl = "api/v1/tasks/getCustomerListByOrderStatusId/";
const acceptRejectOrderUrl = "api/v1/orders/update";

//system message Services
const systemMessage = "api/v1/notification/system?page=1";
const getNotificationTipsUrl = "api/v1/notification/getLatestNotificationTips";
const getNotificationListByTypeUrl =
    "api/v1/notification/notificationListByType?";

// Categories
const getCategoryListUrl = "api/v1/categories/getCategoryList";

// tag
const getTagListUrl = "api/v1/tags/getTagList?";

// upload file
const uploadTaskImagesUrl = "api/v1/files/upload/post";
const uploadDepositUrl = "api/v1/files/upload/deposit-screenshot";

// Payment
const createPaymentUrl = "api/v1/payments/create";