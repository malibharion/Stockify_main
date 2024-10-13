import 'package:equatable/equatable.dart';
import 'package:okra_distributer/Reports/Store%20Sale%20Purchase%20Report/Reporsts%20Model/reportsModels.dart';

class StorePalePurchaseState extends Equatable {
  final List<Company>? companies;
  final String? selectedCompaniesId;
  final List<Groups>? groups;
  final String? selectedGroupsId;
  final List<Prouducts>? products;
  final String? selectedProductId;
  final String? selectedDateRange;
  final String? customDateRange;
  final List<Stores>? stores;
  final String? selectedStoreId;

  StorePalePurchaseState(
      {this.companies,
      this.selectedCompaniesId,
      this.stores,
      this.selectedStoreId,
      this.groups,
      this.customDateRange,
      this.selectedGroupsId,
      this.selectedDateRange,
      this.products,
      this.selectedProductId});

  StorePalePurchaseState copyWith(
      {List<Company>? companies,
      String? selectedCompaniesId,
      List<Stores>? stores,
      String? selectedStoreId,
      String? customDateRange,
      String? selectedDateRange,
      List<Groups>? groups,
      String? selectedGroupsId,
      List<Prouducts>? products,
      String? selectedProductId}) {
    return StorePalePurchaseState(
        companies: companies ?? this.companies,
        selectedCompaniesId: selectedCompaniesId ?? this.selectedCompaniesId,
        stores: stores ?? this.stores,
        selectedStoreId: selectedStoreId ?? this.selectedStoreId,
        groups: groups ?? this.groups,
        selectedGroupsId: selectedGroupsId ?? this.selectedGroupsId,
        customDateRange: customDateRange ?? this.customDateRange,
        selectedDateRange: selectedDateRange ?? this.selectedDateRange,
        products: products ?? this.products,
        selectedProductId: selectedProductId ?? this.selectedProductId);
  }

  @override
  List<Object?> get props => [
        companies,
        selectedCompaniesId,
        groups,
        selectedGroupsId,
        stores,
        selectedStoreId,
        customDateRange,
        products,
        selectedDateRange,
        selectedProductId,
      ];
}
