class PaginationModel {
  final int from;
  final int lastPage;
  final String? nextPageUrl;
  final int perPage;
  final String? prevPageUrl;
  final int total;

  PaginationModel({
    required this.from,
    required this.lastPage,
    this.nextPageUrl,
    required this.perPage,
    this.prevPageUrl,
    required this.total,
  });

  // Factory method to create an instance from JSON
  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      from: json['from']?? 0,
      lastPage: json['last_page'],
      nextPageUrl: json['next_page_url'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      total: json['total'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'last_page': lastPage,
      'next_page_url': nextPageUrl,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'total': total,
    };
  }
}
