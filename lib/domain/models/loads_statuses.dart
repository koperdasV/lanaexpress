class LoadStatus {
  int id;
  String description;

  LoadStatus({
    required this.id,
    required this.description,
  });

  factory LoadStatus.fromJson(Map<String, dynamic> json) {
    return LoadStatus(
      id: json["id"],
      description: json["description"],
    );
  }
}