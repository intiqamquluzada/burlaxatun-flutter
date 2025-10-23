class ForumCategoryStatsModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<ForumCategoryStats>? results;

  ForumCategoryStatsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ForumCategoryStatsModel.fromJson(Map<String, dynamic> json) =>
      ForumCategoryStatsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<ForumCategoryStats>.from(
                json["results"]!.map((x) => ForumCategoryStats.fromJson(x))),
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

class ForumCategoryStats {
  final int? id;
  final int? forumCount;
  final int? totalViews;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? order;
  final String? name;
  final bool? isActive;

  ForumCategoryStats({
    this.id,
    this.forumCount,
    this.totalViews,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.name,
    this.isActive,
  });

  factory ForumCategoryStats.fromJson(Map<String, dynamic> json) => ForumCategoryStats(
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

// class ForumCategoryStatsModel {
//   final int? id;
//   final int? forumCount;
//   final int? totalViews;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? order;
//   final String? name;
//   final bool? isActive;

//   ForumCategoryStatsModel({
//     this.id,
//     this.forumCount,
//     this.totalViews,
//     this.createdAt,
//     this.updatedAt,
//     this.order,
//     this.name,
//     this.isActive,
//   });

//   factory ForumCategoryStatsModel.fromJson(Map<String, dynamic> json) =>
//       ForumCategoryStatsModel(
//         id: json["id"],
//         forumCount: json["forum_count"],
//         totalViews: json["total_views"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         order: json["order"],
//         name: json["name"],
//         isActive: json["is_active"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "forum_count": forumCount,
//         "total_views": totalViews,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "order": order,
//         "name": name,
//         "is_active": isActive,
//       };
// }
