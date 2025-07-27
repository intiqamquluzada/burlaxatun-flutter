class ForumCommentsModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<Comments>? results;

  ForumCommentsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ForumCommentsModel.fromJson(Map<String, dynamic> json) =>
      ForumCommentsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Comments>.from(
                json["results"]!.map((x) => Comments.fromJson(x))),
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

class Comments {
  final int? id;
  final String? user;
  final int? forum;
  final String? text;
  final int? parent;
  final DateTime? createdAt;
  final List<Comments>? replies;
  final int? likeCount;
  final int? dislikeCount;

  Comments({
    this.id,
    this.user,
    this.forum,
    this.text,
    this.parent,
    this.createdAt,
    this.replies,
    this.likeCount,
    this.dislikeCount,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        id: json["id"],
        user: json["user"],
        forum: json["forum"],
        text: json["text"],
        parent: json["parent"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        replies: json["replies"] == null
            ? []
            : List<Comments>.from(
                json["replies"]!.map((x) => Comments.fromJson(x))),
        likeCount: json["like_count"],
        dislikeCount: json["dislike_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "forum": forum,
        "text": text,
        "parent": parent,
        "created_at": createdAt?.toIso8601String(),
        "replies": replies == null
            ? []
            : List<dynamic>.from(replies!.map((x) => x.toJson())),
        "like_count": likeCount,
        "dislike_count": dislikeCount,
      };
}
