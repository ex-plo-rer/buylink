import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';

class AddProductNotifier extends BaseChangeNotifier {
  final Reader _reader;

  AddProductNotifier(this._reader);

  String? _categoryValue;
  String? get categoryValue => _categoryValue;

  List<String> categories = ['Aaaa', 'Bbbbb', 'Ccccc'];

  List<String?> _imageList = [];
  List<String?> get imageList => _imageList;

  void onCategoryChanged({
    required String newCategory,
  }) async {
    _categoryValue = newCategory;
    // nullifySubCat();
    print('New category : $newCategory');
    print('Category value : $_categoryValue');
    // fetchSubCategories(categoryId: int.tryParse(newCategory) ?? 1);
    notifyListeners();
  }

  String? image1;
  String? image2;
  String? image3;
  String? image4;

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

  void setImages({
    required List<PlatformFile> images,
  }) {
    for (var image in images) {
      _imageList.add(image.path!);
      print('_imageList $_imageList');
    }
    notifyListeners();
  }
}

final addProductNotifierProvider =
    ChangeNotifierProvider.autoDispose<AddProductNotifier>(
        (ref) => AddProductNotifier(ref.read));
