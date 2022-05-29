import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/core_repository.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/navigation_service.dart';

class AddProductNotifier extends BaseChangeNotifier {
  final Reader _reader;

  AddProductNotifier(this._reader);

  String? _categoryValue;
  String? get categoryValue => _categoryValue;
  String? _sizeValue;
  String? get sizeValue => _sizeValue;

  List<String> _categories = ['Aaaa', 'Bbbbb', 'Ccccc'];
  List<String> get categories => _categories;

  List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  List<String> get sizes => _sizes;

  List<String?> _imageList = [];
  List<String?> get imageList => _imageList;

  void onCategoryChanged({
    required String newCategory,
  }) async {
    _categoryValue = newCategory;
    notifyListeners();
  }

  void onSizeChanged({
    required String newSize,
  }) async {
    _sizeValue = newSize;
    notifyListeners();
  }

  String? _name;
  String? _minPrice;
  String? _maxPrice;
  String? _desc;
  String? _brand;
  String? _color;
  String? _minAge;
  String? _maxAge;
  String? _minWeight;
  String? _maxWeight;
  String? _model;
  String? _material;
  String? _care;

  void setImageFile({
    required String imageFile,
    required int imageIndex,
  }) {
    if (imageIndex == 0) {
      _imageList[0] = imageFile;
    } else if (imageIndex == 1) {
      _imageList.length < 2
          ? _imageList.add(imageFile)
          : _imageList[1] = imageFile;
    } else if (imageIndex == 2) {
      _imageList.length < 3
          ? _imageList.add(imageFile)
          : _imageList[2] = imageFile;
    } else if (imageIndex == 3) {
      _imageList.length < 4
          ? _imageList.add(imageFile)
          : _imageList[3] = imageFile;
    }
    notifyListeners();
  }

  void onNameChanged(String value) => _name = value;
  void onMinPriceChanged(String value) => _minPrice = value;
  void onMaxPriceChanged(String value) => _maxPrice = value;
  void onDescChanged(String value) => _desc = value;
  void onBrandChanged(String value) => _brand = value;
  void onColorChanged(String value) => _color = value;
  void onMinAgeChanged(String value) => _minAge = value;
  void onMaxAgeChanged(String value) => _maxAge = value;
  void onMinWeightChanged(String value) => _minWeight = value;
  void onMaxWeightChanged(String value) => _maxWeight = value;
  void onModelChanged(String value) => _model = value;
  void onMaterialChanged(String value) => _material = value;
  void onCareChanged(String value) => _care = value;

  void setImages({
    required List<PlatformFile> images,
  }) {
    for (var image in images) {
      _imageList.add(image.path!);
      print('_imageList $_imageList');
    }
    notifyListeners();
  }

  Future<void> addProduct() async {
    try {
      setState(state: ViewState.loading);
      await _reader(coreRepository).addProduct(
        storeId: 1,
        name: _name!,
        image1: _imageList[0],
        image2: _imageList.length < 2 ? null : _imageList[1],
        image3: _imageList.length < 3 ? null : _imageList[2],
        image4: _imageList.length < 4 ? null : _imageList[3],
        price: _minPrice!,
        oldPrice: _maxPrice!,
        // category: _categoryValue!,
        category: '_categoryValue!',
        description: _desc!,
        brand: _brand!,
        colors: _color!,
        minAge: _minAge!,
        maxAge: _maxAge!,
        minWeight: _minWeight!,
        maxWeight: _maxWeight!,
        size: _sizeValue!,
        model: _model!,
        material: _material!,
        care: _care!,
      );
      Alertify(title: 'Your product has been added').success();
      // _reader(navigationServiceProvider).navigateBack();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }
}

final addProductNotifierProvider =
    ChangeNotifierProvider.autoDispose<AddProductNotifier>(
        (ref) => AddProductNotifier(ref.read));
