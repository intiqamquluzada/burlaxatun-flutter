class ForumCategoryModel {
    final int? count;
    final String? next;
    final String? previous;
    final List<ForumCategory>? results;

    ForumCategoryModel({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    factory ForumCategoryModel.fromJson(Map<String, dynamic> json) => ForumCategoryModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null ? [] : List<ForumCategory>.from(json["results"]!.map((x) => ForumCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class ForumCategory {
    final int? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? order;
    final String? name;
    final bool? isActive;

    ForumCategory({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.order,
        this.name,
        this.isActive,
    });

    factory ForumCategory.fromJson(Map<String, dynamic> json) => ForumCategory(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
