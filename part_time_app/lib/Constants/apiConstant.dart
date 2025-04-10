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
const updateCustomerPassUrl = "api/v1/customers/updatePass/";
const uploadAvatarUrl = "api/v1/files/upload/avatar";

//explore Services
const exploreURL = "api/v1/tasks/getTaskListByDateDesc?";
const explorePriceURL = "api/v1/tasks/getTaskListByPrice";
const collectionURL = "api/v1/collection/my-collection";
const createCollectionURL = "api/v1/collection/create?taskId=";
const searchResultPage = "api/v1/tasks/searchByKeywords?";
const searchbyTag = "api/v1/tasks/searchByTag?";
const getFilterTagListUrl = "api/v1/tags/getFilterTagList";
const advertisementPage = "api/v1/advertisement/all";
const getCategoryList = "api/v1/tasks/getTaskListByCategoryId/";

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
const updateTaskUrl = "api/v1/tasks/updateTask";
const getCustomerListByOrderStatusIdUrl =
    "api/v1/tasks/getCustomerListByOrderStatusId/";
const acceptRejectOrderUrl = "api/v1/orders/update";
const getTwoRandomTaskUrl = "api/v1/tasks/getRandom";

//system message Services
const systemMessage = "api/v1/notification/system?page=1";
const getNotificationTipsUrl = "api/v1/notification/getLatestNotificationTips";
const getNotificationListByTypeUrl =
    "api/v1/notification/notificationListByType?";
const patchNotificationReadStatusUrl = "api/v1/notification/updateIsRead/";
const postSystemNotificationReadStatusUrl =
    "api/v1/notification/updateSystemIsRead";

// Categories
const getCategoryListUrl = "api/v1/categories/getCategoryList";

//About Us Services
const aboutUsUrl = "api/v1/aboutUs/";

//Settings Services
const updateCollectionViewUrl = "api/v1/customers/updateCollectionViewable";

//Payment
const getPaymentHistoryUrl = "api/v1/payments/payment/history?page=";
const getPaymentDetailUrl = "api/v1/payments/detail/";
const getDepositUrl = "api/v1/deposit/info";
const getDepositStatusUrl = "api/v1/deposit/";

//Ticketing
const getTicketingHistoryUrl = "api/v1/ticket/getAllByCustomerId?page=";
const getTicketingDetailUrl = "api/v1/ticket/getTicketByTicketId/";
const getTicketComplainTypeUrl = "api/v1/ticket/getTypes";
const createTicketUrl = "api/v1/ticket/create";

// tag
const getTagListUrl = "api/v1/tags/getTagList?";

// upload file
const uploadTaskImagesUrl = "api/v1/files/upload/post";
const uploadDepositUrl = "api/v1/files/upload/deposit-screenshot";
const uploadTicketImagesUrl = "api/v1/files/upload/ticket";

// Payment
const createPaymentUrl = "api/v1/payments/create";

// Customer
const customerHomePageUrl = "api/v1/customers/detailsByCustomerId/";
const customerTotalPostUrl = "api/v1/customers/totalPostCount?";
const customerTotalCollectionUrl = "api/v1/collection/totalCount/";
const customerHomePageTaskUrl = "api/v1/customers/getCustomerHomePageTask/";
const customerHomePageCollectionUrl = "api/v1/customers/getCustomerHomePageCollection/";

//Business Scope Services
const getBusinessScopeListUrl = "api/v1/business-scope/";
