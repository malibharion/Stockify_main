import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../Reporsts Model/reportsModels.dart';
import '../../constants.dart';
import 'StoreSalePurchaseEvent.dart';
import 'StoreSalePurchaseState.dart';

class Storesalepurchasebloc
    extends Bloc<StoreSalePurchaseEvent, StorePalePurchaseState> {
  Storesalepurchasebloc() : super(StorePalePurchaseState()) {
    //Companies
    on<LoadCompanies>((event, emit) async {
      try {
        final companies = await _fetchCompanies();
        emit(state.copyWith(companies: companies));
      } catch (e) {
        print(e);
      }
    });

    on<SelectCompany>((event, emit) {
      emit(state.copyWith(selectedCompaniesId: event.companyId));
    });

    //Groups

    on<LoadGroups>((event, emit) async {
      try {
        final gropus = await _fetchGroups();
        emit(state.copyWith(groups: gropus));
      } catch (e) {
        print(e);
      }
    });

    on<SelectGroup>((event, emit) {
      emit(state.copyWith(selectedGroupsId: event.groupId));
    });

//Products

    on<LoadProducts>((event, emit) async {
      try {
        final products = await _fetchProducts();
        emit(state.copyWith(products: products));
      } catch (e) {
        print(e);
      }
    });
    on<SelectProducts>((event, emit) {
      emit(state.copyWith(selectedProductId: event.productId));
    });

    on<LoadStores>((event, emit) async {
      try {
        final stores = await _fetchStores();
        emit(state.copyWith(stores: stores));
      } catch (e) {
        print(e);
      }
    });
    on<SelectStore>((event, emit) {
      emit(state.copyWith(selectedStoreId: event.storeId));
    });

    //Date Range
    on<SelectDateRange>((event, emit) {
      emit(state.copyWith(
        selectedDateRange: event.selectedDateRange,
        customDateRange: event.customDateRange,
      ));
    });
    on<SelectCustomDate>((event, emit) {
      emit(state.copyWith(
        selectedDateRange: 'Custom',
        customDateRange: event.customDateRange,
      ));
    });
  }

  // Functions For Fetching Data --------------------.>

  //Function for Fetching Company-------------->

  Future<List<Company>> _fetchCompanies() async {
    final response =
        await http.post(Uri.parse(ReportConstants.storeSalePurchaseList));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.body.isEmpty) {
      throw Exception('Empty response');
    }

    print('Response headers: ${response.headers}');

    try {
      final data = json.decode(response.body);
      final companies = (data['get_allCompanies'] as List)
          .map((json) => Company.fromJson(json))
          .toList();
      return companies;
    } catch (e) {
      print('Failed to parse JSON: $e');
      throw Exception('Invalid JSON response');
    }
  }

  // Function For Fetching Group-------------->
  Future<List<Groups>> _fetchGroups() async {
    final response =
        await http.post(Uri.parse(ReportConstants.storeSalePurchaseList));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.body.isEmpty) {
      throw Exception('Empty response');
    }

    try {
      final data = json.decode(response.body);
      final groups = (data['get_alllGroups'] as List)
          .map((json) => Groups.fromJson(json))
          .toList();
      return groups;
    } catch (e) {
      print('Failed to parse JSON: $e');
      throw Exception('Invalid JSON response');
    }
  }
  //Fucntions for fetching groups

  Future<List<Prouducts>> _fetchProducts() async {
    final response =
        await http.post(Uri.parse(ReportConstants.storeSalePurchaseList));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.body.isEmpty) {
      throw Exception('Empty response');
    }

    try {
      final data = json.decode(response.body);
      final products = (data['get_allProduct'] as List)
          .map((json) => Prouducts.fromJson(json))
          .toList();
      return products;
    } catch (e) {
      print('Failed to parse JSON: $e');
      throw Exception('Invalid JSON response');
    }
  }
  //Function For fetching store

  Future<List<Stores>> _fetchStores() async {
    final response =
        await http.post(Uri.parse(ReportConstants.storeSalePurchaseList));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.body.isEmpty) {
      throw Exception('Empty response');
    }

    try {
      final data = json.decode(response.body);
      final stores = (data['active_store'] as List)
          .map((json) => Stores.fromJson(json))
          .toList();
      return stores;
    } catch (e) {
      print('Failed to parse JSON: $e');
      throw Exception('Invalid JSON response');
    }
  }
}
