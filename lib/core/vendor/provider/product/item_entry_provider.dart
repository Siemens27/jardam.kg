import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/item_entry_field_repository.dart';
import '../../viewobject/core_field.dart';
import '../../viewobject/custom_field.dart';
import '../../viewobject/product_entry_field.dart';
import '../../viewobject/selected_object.dart';
import '../common/ps_provider.dart';

class ItemEntryFieldProvider extends PsProvider<ItemEntryField> {
  ItemEntryFieldProvider(
      {required ItemEntryFieldRepository repo, int limit = 0})
      : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  PsResource<ItemEntryField> get itemEntryField => data;

  Map<CustomField, SelectedObject> textControllerMap =
      <CustomField, SelectedObject>{};

  CoreField titleCoreField = CoreField(visible: '0');
  CoreField categoryCoreField = CoreField(visible: '0');
  CoreField subCategoryCoreField = CoreField(visible: '0');
  CoreField phoneNumCoreField = CoreField(visible: '0');
  CoreField currencySymbolCoreField = CoreField(visible: '0');
  CoreField priceCoreField = CoreField(visible: '0');
  CoreField discountRateCoreField = CoreField(visible: '0');
  CoreField descriptionCoreField = CoreField(visible: '0');
  CoreField cityCoreField = CoreField(visible: '0');
  CoreField townshipCoreField = CoreField(visible: '0');

   bool isPickUpOnMap = false;

  CoreField getCoreFieldByFieldName(String id) {
    final int index = itemEntryField.data!.coreField!
        .indexWhere((CoreField element) => element.fieldName == id);
    if (index >= 0) {
      return itemEntryField.data!.coreField!.elementAt(index);
    } else {
      return CoreField(visible: '0');
    }
  }
}
