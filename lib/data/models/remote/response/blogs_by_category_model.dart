class BlogsByCategoryModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<BlogByCategory>? results;

  BlogsByCategoryModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory BlogsByCategoryModel.fromJson(Map<String, dynamic> json) =>
      BlogsByCategoryModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<BlogByCategory>.from(
                json["results"]!.map((x) => BlogByCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class BlogByCategory {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? slug;
  final String? file;
  final String? thumbnail;
  final String? name;
  final String? text;
  final int? category;

  BlogByCategory({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.file,
    this.thumbnail,
    this.name,
    this.text,
    this.category,
  });

  factory BlogByCategory.fromJson(Map<String, dynamic> json) => BlogByCategory(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        slug: json["slug"],
        file: json["file"],
        thumbnail: json["thumbnail"],
        name: json["name"],
        text: json["text"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "slug": slug,
        "file": file,
        "thumbnail": thumbnail,
        "name": name,
        "text": text,
        "category": category,
      };
}
