import 'package:get/get.dart';
import 'package:presensi_universitas_bina_insan_app/data/database/source/attendance_datasource.dart';
import 'package:presensi_universitas_bina_insan_app/data/database/source/izin_datasource.dart';
import 'package:presensi_universitas_bina_insan_app/data/repository_impl/attendance_repository_impl.dart';
import 'package:presensi_universitas_bina_insan_app/data/repository_impl/izin_repository_impl.dart';
import 'package:presensi_universitas_bina_insan_app/domain/repository/attendance_repository.dart';
import 'package:presensi_universitas_bina_insan_app/domain/repository/izin_repository.dart';
import 'package:presensi_universitas_bina_insan_app/domain/usecase/attendance_usecase.dart';
import 'package:presensi_universitas_bina_insan_app/domain/usecase/izin_usecase.dart';
import '../../data/database/local/user_localsource.dart';
import '../../data/database/source/location_datasource.dart';
import '../../data/database/source/office_datasource.dart';
import '../../data/database/source/shift_datasource.dart';
import '../../data/database/source/user_datasource.dart';
import '../../data/repository_impl/location_repository_impl.dart';
import '../../data/repository_impl/office_repository_impl.dart';
import '../../data/repository_impl/shift_repository_impl.dart';
import '../../data/repository_impl/user_repository_impl.dart';
import '../../domain/entity/office_entity.dart';
import '../../domain/entity/shift_entity.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/location_repository.dart';
import '../../domain/repository/office_repository.dart';
import '../../domain/repository/shift_repository.dart';
import '../../domain/repository/user_repository.dart';
import '../../domain/usecase/location_usecase.dart';
import '../../domain/usecase/office_usecase.dart';
import '../../domain/usecase/shift_usecase.dart';
import '../../domain/usecase/user_usecase.dart';
import '../location/location_service.dart';
import 'package:image/image.dart' as img;

class DependencyInjection extends GetxController {
  late LocationService locationService;
  late LocationDatasource locationDatasource;
  late LocationRepository locationRepository;
  late LocationSenUsecase locationSenUsecase;

  late IzinDatasource izinDatasource;
  late IzinRepository izinRepository;
  late AddIzinUsecase addIzinUsecase;
  late GetIzinUsecase getIzinUsecase;
  late DetailIzinUsecase detailIzinUsecase;
  late HapusIzinUsecase hapusIzinUsecase;

  late UserDatasource userDatasource;
  late UserLocalsource userLocalsource;
  late UserRepository userRepository;
  late LoginUsecase loginUsecase;
  late UpdateUserUsecase updateUserUsecase;
  late SaveLoginStatusUsecase saveLoginStatusUsecase;
  late GetLoginStatusUsecase getLoginStatusUsecase;
  late DeleteLoginStatus deleteLoginStatus;
  late UpdatePaswordUserUsecase updatePaswordUserUsecase;

  late OfficeDatasource officeDatasource;
  late OfficeRepository officeRepository;
  late OfficeGetUsecase officeGetUsecase;

  late ShiftDatasource shiftDatasource;
  late ShiftRepository shiftRepository;
  late ShiftGetUsecase shiftGetUsecase;

  late AttendanceDatasource attendanceDatasource;
  late AttendanceRepository attendanceRepository;
  late PresensiAddUsecase presensiAddUsecase;
  late GetPresensiUsecase getPresensiUsecase;
  late DetailPresensiUsecase detailPresensiUsecase;

  @override
  void onInit() {
    locationService = LocationServiceImpl();
    locationDatasource = LocationDatasourceImpl();
    locationRepository = LocationRepositoryImpl(locationDatasource);
    locationSenUsecase = LocationSenUsecase(locationRepository);

    izinDatasource = IzinDatasourceImpl();
    izinRepository = IzinRepositoryImpl(izinDatasource);
    addIzinUsecase = AddIzinUsecase(izinRepository);
    getIzinUsecase = GetIzinUsecase(izinRepository);
    detailIzinUsecase = DetailIzinUsecase(izinRepository);
    hapusIzinUsecase = HapusIzinUsecase(izinRepository);

    userDatasource = UserDatasourceImpl();
    userLocalsource = UserLocalsourceImpl();
    userRepository = UserRepositoryImpl(userDatasource, userLocalsource);
    loginUsecase = LoginUsecase(userRepository);
    updateUserUsecase = UpdateUserUsecase(userRepository);
    getLoginStatusUsecase = GetLoginStatusUsecase(userRepository);
    saveLoginStatusUsecase = SaveLoginStatusUsecase(userRepository);
    deleteLoginStatus = DeleteLoginStatus(userRepository);
    updatePaswordUserUsecase = UpdatePaswordUserUsecase(userRepository);

    shiftDatasource = ShiftDatasourceImpl();
    shiftRepository = ShiftRepositoryImpl(shiftDatasource);
    shiftGetUsecase = ShiftGetUsecase(shiftRepository);

    officeDatasource = OfficeDatasourceImpl();
    officeRepository = OfficeRepositoryImpl(officeDatasource);
    officeGetUsecase = OfficeGetUsecase(officeRepository);

    attendanceDatasource = AttendanceDatasourceImpl();
    attendanceRepository = AttendanceRepositoryImpl(attendanceDatasource);
    presensiAddUsecase = PresensiAddUsecase(attendanceRepository);
    getPresensiUsecase = GetPresensiUsecase(attendanceRepository);
    detailPresensiUsecase = DetailPresensiUsecase(attendanceRepository);

    super.onInit();
  }

  img.Image? image;

  RxString idDevice = '0'.obs;
  Rx<UserEntity> user = const UserEntity().obs;
  Rx<ShiftEntity> shift = const ShiftEntity().obs;
  Rx<OfficeEntity> office = const OfficeEntity().obs;
}
