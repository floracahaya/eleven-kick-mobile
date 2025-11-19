class ProductEntry {
  String id;
  String name;
  String description;
  String category;
  String thumbnail;
  int price;
  DateTime dateAdded;
  bool isFeatured;
  int? userId;           // nullable
  String? userUsername;  // nullable

  ProductEntry({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.price,
    required this.dateAdded,
    required this.isFeatured,
    this.userId,
    this.userUsername,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"].toString(),
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        category: json["category"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
        price: json["price"] ?? 0,
        dateAdded: DateTime.parse(json["date_added"] ?? DateTime.now().toString()),
        isFeatured: json["is_featured"] ?? false,
        userId: json["user_id"],           // bisa null
        userUsername: json["user_username"], // bisa null
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "category": category,
        "thumbnail": thumbnail,
        "price": price,
        "date_added":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "is_featured": isFeatured,
        "user_id": userId,
        "user_username": userUsername,
      };
}
