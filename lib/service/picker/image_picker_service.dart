import 'package:image_picker/image_picker.dart';
import 'package:presensi_universitas_bina_insan_app/core/component/snackbar_component.dart';

class ImagePickerService {
  ImagePicker picker = ImagePicker();

  Future<String?> pickImageFormKamera() async {
    try {
      final path = await picker.pickImage(source: ImageSource.camera);
      return path?.path;
    } catch (e) {
      errorSnacbar('gagal mengambil gambar');
      throw Exception();
    }
  }

  Future<String?> picImageFormGalery() async {
    try {
      final path = await picker.pickImage(source: ImageSource.gallery);
      return path?.path;
    } catch (e) {
      errorSnacbar('gagal mengambil gambar');
      throw Exception();
    }
  }
}
