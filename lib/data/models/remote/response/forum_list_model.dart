class ForumListModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<Forum>? results;

  ForumListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ForumListModel.fromJson(Map<String, dynamic> json) => ForumListModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Forum>.from(json["results"]!.map((x) => Forum.fromJson(x))),
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

class Forum {
  final int? id;
  final User? user;
  final Category? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? slug;
  final String? text;
  final int? viewCount;
  final int? likes;
  final int? commentCount;

  Forum({
    this.id,
    this.user,
    this.category,
    this.commentCount,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.text,
    this.viewCount,
    this.likes,
  });

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        slug: json["slug"],
        text: json["text"],
        viewCount: json["view_count"],
        likes: json["likes"],
        commentCount: json["comment_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "category": category?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "slug": slug,
        "text": text,
        "view_count": viewCount,
        "likes": likes,
        "comment_count": commentCount,
      };
}

class Category {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? order;
  final String? name;
  final bool? isActive;

  Category({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.name,
    this.isActive,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        order: json["order"],
        name: json["name"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order": order,
        "name": name,
        "is_active": isActive,
      };
}

class User {
  final int? id;
  final String? fullName;
  final String? email;
  final String? image;
  final bool? fromVideoDoktor;

  User({
    this.id,
    this.fullName,
    this.email,
    this.image,
    this.fromVideoDoktor,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        image: json["image"],
        fromVideoDoktor: json["from_video_doktor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "image": image,
        "from_video_doktor": fromVideoDoktor,
      };
}
