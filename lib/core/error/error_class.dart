class Failur {
  final String? status;
  final String? message;
  Failur({this.status, String? message})
      : message = message?.replaceAll('Exception:', '');
}
