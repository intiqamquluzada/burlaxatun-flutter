import 'package:equatable/equatable.dart';

class BlogCategoryModel extends Equatable {
  final int? categoryId;
  final String? categoryName;
  final List<BlogModel>? blogs;
  final int? blogsCount;

  const BlogCategoryModel({
    this.categoryId,
    this.categoryName,
    this.blogs,
    this.blogsCount,
  });

  factory BlogCategoryModel.fromJson(Map<String, dynamic> json) =>
      BlogCategoryModel(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        blogs: json["blogs"] == null
            ? []
            : List<BlogModel>.from(json["blogs"].map((x) => BlogModel.fromJson(x))),
        blogsCount: json["blogs_count"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "blogs_count": blogsCount,
        "blogs": blogs == null
            ? []
            : List<dynamic>.from(blogs!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [categoryId, categoryName, blogsCount, blogs];
}

class BlogModel extends Equatable {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? slug;
  final String? file;
  final String? thumbnail;
  final String? name;
  final String? text;
  final int? categoryId;

  const BlogModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.file,
    this.thumbnail,
    this.name,
    this.text,
    this.categoryId,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
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
        categoryId: json["category"],
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
        "category": categoryId,
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        slug,
        file,
        thumbnail,
        name,
        text,
        categoryId,
      ];
}
