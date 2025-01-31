class LocationPermissionModel {
  bool? permissionEnable;
  bool? serviceEnable;

  LocationPermissionModel({this.permissionEnable, this.serviceEnable});

  LocationPermissionModel.fromJson(Map<String, dynamic> json) {
    permissionEnable = json['permission_enable'];
    serviceEnable = json['service_enable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['permission_enable'] = permissionEnable;
    data['service_enable'] = serviceEnable;
    return data;
  }
}