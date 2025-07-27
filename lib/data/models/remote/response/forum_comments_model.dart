class ForumCommentsModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<Replyes>? results;

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
            : List<Replyes>.from(
                json["results"]!.map((x) => Replyes.fromJson(x))),
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

class Replyes {
  final int? id;
  final String? user;
  final int? forum;
  final String? text;
  final int? parent;
  final DateTime? createdAt;
  final List<Replyes>? replies;
  final int? likeCount;
  final int? dislikeCount;

  Replyes({
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

  factory Replyes.fromJson(Map<String, dynamic> json) => Replyes(
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
            : List<Replyes>.from(
                json["replies"]!.map((x) => Replyes.fromJson(x))),
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
