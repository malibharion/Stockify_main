abstract class StoreSalePurchaseEvent {}

class LoadCompanies extends StoreSalePurchaseEvent {}

class SelectCompany extends StoreSalePurchaseEvent {
  final String? companyId;
  SelectCompany({this.companyId});
}

class LoadGroups extends StoreSalePurchaseEvent {}

class SelectGroup extends StoreSalePurchaseEvent {
  final String? groupId;
  SelectGroup({this.groupId});
}

class Product extends StoreSalePurchaseEvent {}

class LoadProducts extends StoreSalePurchaseEvent {}

class SelectProducts extends StoreSalePurchaseEvent {
  final String? productId;
  SelectProducts({this.productId});
}

class SelectDateRange extends StoreSalePurchaseEvent {
  final String selectedDateRange;
  final String? customDateRange; // Optional custom date range

  SelectDateRange({required this.selectedDateRange, this.customDateRange});
}

class SelectCustomDate extends StoreSalePurchaseEvent {
  final String customDateRange;
  SelectCustomDate({required this.customDateRange});
}

class LoadStores extends StoreSalePurchaseEvent {}

class SelectStore extends StoreSalePurchaseEvent {
  final String? storeId;
  SelectStore({this.storeId});
}
