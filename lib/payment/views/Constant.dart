class Constant {
  static const baseUrl = 'https://212b-39-44-66-245.ngrok-free.app';
////////////////this is for checkin am i opening the correct file
  static const loginUrl = '$baseUrl/stockfiy/api/auth/login';
  static const firmUrl = '$baseUrl/stockfiy/api/Phase1/getFirmDetails';
  static const userUrl = '$baseUrl/stockfiy/api/Phase1/getUserDetails';
  static const usertypeUrl = '$baseUrl/stockfiy/api/Phase1/ListUserTypes';
  static const storeUrl = '$baseUrl/stockfiy/api/Phase1/ListStores';
  static const productComapnaiesUrl =
      '$baseUrl/stockfiy/api/Phase1/ListProductCompanies';
  static const productGrouping =
      '$baseUrl/stockfiy/api/Phase1/ListProductGroups';
  static const product = '$baseUrl/stockfiy/api/Phase1/ListProducts';
  static const addPostPartner =
      '$baseUrl/stockfiy/api/partnership/postaddpartner';
  static const getUserType = '$baseUrl/stockfiy/api/partnership/getUserTypes';
  static const getPartnerTypeList =
      '$baseUrl/stockfiy/api/partnership/getpartnertypeslist';

  static const auth = '$baseUrl/stockfiy/api/auth/login';
  static const getGroup = '$baseUrl/stockfiy/api/partnership/getGroups';
  static const getPatnersList =
      '$baseUrl/stockfiy/api/partnership/getPartnersList';
  static const getpatnerBanksList =
      '$baseUrl/stockfiy/api/partnership/getPartnersBanksList';
  static const getFirmsBanksList =
      '$baseUrl/stockfiy/api/partnership/getFirmsBanksList';
  static const patnerWithdrawal =
      '$baseUrl/stockfiy/api/partnership/PartnerWithdrawal';
  static const country = '$baseUrl/stockfiy/api/Phase1/ListCountries';
  static const state = '$baseUrl/stockfiy/api/Phase1/ListStates';
  static const cities = '$baseUrl/stockfiy/api/Phase1/ListCities';
  static const areas = '$baseUrl/stockfiy/api/Phase1/ListAreas';
  static const customer = '$baseUrl/stockfiy/api/Phase1/ListPermanentCustomers';
  static const appId = '$baseUrl/stockfiy/api/auth/saveDeviceData';
  static const sendApi =
      '$baseUrl/stockfiy/api/realdata/StorePermanentCustomerPayments';
  static const customerReciptSync =
      '$baseUrl/stockfiy/api/sync/saveOfflineData';
}
