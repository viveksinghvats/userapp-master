import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'constants.dart';
import 'common.dart';

class ProductService {
  static final Client client = Client();
  // get category list
  static Future<Map<String, dynamic>> getCategoryList() async {
    String languageCode, locationData;
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });
    final response = await client.get(
        Constants.BASE_URL + "products/home/category?$locationData",
        headers: {
          'Content-Type': 'application/json',
          'language': languageCode,
        });
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getProductListAll(index) async {
    String userId, languageCode, locationData;
    await Common.getUserID().then((uid) {
      if (uid == null) {
        userId = "userId=";
      } else {
        userId = "userId=" + uid;
      }
    });
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });
    String productIndex = "page=" + "$index";
    final response = await client.get(
        Constants.BASE_URL +
            "products/home/product?$userId&$productIndex&$locationData",
        headers: {
          'Content-Type': 'application/json',
          'language': languageCode,
        });
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getTopDealsListAll() async {
    String languageCode, locationData;
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });
    final response = await client.get(
        Constants.BASE_URL + "products/home/top/deal?$locationData",
        headers: {
          'Content-Type': 'application/json',
          'language': languageCode,
        });
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getTodayDealsListAll() async {
    String languageCode, locationData;
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });
    final response = await client.get(
        Constants.BASE_URL + "products/home/deal/of/day?$locationData",
        headers: {
          'Content-Type': 'application/json',
          'language': languageCode,
        });
    return json.decode(response.body);
  }

  // get product to category
  static Future<Map<String, dynamic>> getProductToCategoryList(id) async {
    String token, languageCode, locationData, userId;
    await Common.getToken().then((onValue) {
      token = onValue;
    });

    await Common.getUserID().then((uid) {
      if (uid == null) {
        userId = "userId=";
      } else {
        userId = "userId=" + uid;
      }
    });
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });
    final response = await client.get(
        Constants.BASE_URL + "products/by/category/$id?$userId&$locationData",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
          'language': languageCode,
        });

    return json.decode(response.body);
  }

  // get product to category
  static Future<Map<String, dynamic>> getProductToSubCategoryList(id) async {
    String token, languageCode, locationData;
    await Common.getToken().then((onValue) {
      token = onValue;
    });
    String userId;
    await Common.getUserID().then((uid) {
      if (uid == null) {
        userId = "userId=";
      } else {
        userId = "userId=" + uid;
      }
    });
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });
    final response = await client.get(
        Constants.BASE_URL +
            "products/by/subcategory/$id?$userId&$locationData",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
          'language': languageCode,
        });

    return json.decode(response.body);
  }

  // place order
  static Future<Map<String, dynamic>> placeOrder(body) async {
    String token, languageCode;
    await Common.getToken().then((onValue) {
      token = onValue;
    });
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });

    final response = await client.post(
        Constants.BASE_URL + "orders/place/order",
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
          'language': languageCode,
        });
    return json.decode(response.body);
  }

//order info by user ID
  static Future<Map<String, dynamic>> getOrderByUserID() async {
    String token, languageCode;
    await Common.getToken().then((onValue) {
      token = onValue;
    });
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    final response =
        await client.get(Constants.BASE_URL + "orders/history", headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token',
      'language': languageCode,
    });
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> orderRating(body, orderId) async {
    String token, languageCode;
    await Common.getToken().then((onValue) {
      token = onValue;
    });
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    final response = await client.post(
        Constants.BASE_URL + "orders/ratings/$orderId",
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
          'language': languageCode,
        });
    return json.decode(response.body);
  }

  //rate to product
  static Future<Map<String, dynamic>> productRate(body) async {
    String token, languageCode, locationData;
    await Common.getToken().then((onValue) {
      token = onValue;
    });
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });
    final response = await client.post(
        Constants.BASE_URL + "rating/rate/product?$locationData",
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
          'language': languageCode,
        });
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> productDetails(productId) async {
    String userId, languageCode, locationData;
    await Common.getUserID().then((uid) {
      if (uid == null) {
        userId = "userId=";
      } else {
        userId = "userId=" + uid;
      }
    });
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });
    final response = await client.get(
        Constants.BASE_URL + "products/info/$productId?$userId&$locationData",
        headers: {
          'Content-Type': 'application/json',
          'language': languageCode,
        });
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getProdCatDealTopDeal() async {
    String languageCode, locationData;
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });
    final response = await client
        .get(Constants.BASE_URL + "products/home/page?$locationData", headers: {
      'Content-Type': 'application/json',
      'language': languageCode,
    });
    await Common.setAllData(json.decode(response.body));
    return json.decode(response.body);
  }

  static Future<dynamic> getSearchList(status) async {
    String userId, languageCode, locationData;
    await Common.getUserID().then((uid) {
      if (uid == null) {
        userId = "userId=";
      } else {
        userId = "userId=" + uid;
      }
    });
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });

    final response = await client.get(
        Constants.BASE_URL + 'products/search/$status?$userId&$locationData',
        headers: {
          'Content-Type': 'application/json',
          'language': languageCode,
        });
    return json.decode(response.body);
  }

  static Future<dynamic> getSearchCategoryList(status) async {
    String userId, languageCode, locationData;
    await Common.getUserID().then((uid) {
      if (uid == null) {
        userId = "userId=";
      } else {
        userId = "userId=" + uid;
      }
    });
    await Common.getSelectedLanguage().then((code) {
      languageCode = code ?? "";
    });
    await Common.getLocation().then((locationDataValue) async {
      locationData = "location=" + locationDataValue['_id'];
    });

    final response = await client.get(
        Constants.BASE_URL + 'products/search/category/$status?$userId&$locationData',
        headers: {
          'Content-Type': 'application/json',
          'language': languageCode,
        });
    return json.decode(response.body);
  }

}
