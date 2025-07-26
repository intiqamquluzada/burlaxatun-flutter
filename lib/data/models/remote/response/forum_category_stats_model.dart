class ForumCategoryStatsModel {
  final int? id;
  final int? forumCount;
  final int? totalViews;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? order;
  final String? name;
  final bool? isActive;

  ForumCategoryStatsModel({
    this.id,
    this.forumCount,
    this.totalViews,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.name,
    this.isActive,
  });

  factory ForumCategoryStatsModel.fromJson(Map<String, dynamic> json) =>
      ForumCategoryStatsModel(
        id: json["id"],
        forumCount: json["forum_count"],
        totalViews: json["total_views"],
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
        "forum_count": forumCount,
        "total_views": totalViews,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order": order,
        "name": name,
        "is_active": isActive,
      };
}
