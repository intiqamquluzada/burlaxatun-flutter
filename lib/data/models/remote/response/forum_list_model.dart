class ForumListModel {
  final List<Thread>? threads;
  final int? count;

  ForumListModel({
    this.threads,
    this.count,
  });

  factory ForumListModel.fromJson(Map<String, dynamic> json) => ForumListModel(
        threads: json["threads"] == null
            ? []
            : List<Thread>.from(
                json["threads"]!.map((x) => Thread.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "threads": threads == null
            ? []
            : List<dynamic>.from(threads!.map((x) => x.toJson())),
        "count": count,
      };
}

class Thread {
  final int? id;
  final String? subject;
  final int? fid;
  final int? uid;
  final String? author;
  final int? views;
  final int? replies;
  final bool? closed;
  final bool? sticky;
  final int? createdAt;
  final Post? post;

  Thread({
    this.id,
    this.subject,
    this.fid,
    this.uid,
    this.author,
    this.views,
    this.replies,
    this.closed,
    this.sticky,
    this.createdAt,
    this.post,
  });

  factory Thread.fromJson(Map<String, dynamic> json) => Thread(
        id: json["id"],
        subject: json["subject"],
        fid: json["fid"],
        uid: json["uid"],
        author: json["author"],
        views: json["views"],
        replies: json["replies"],
        closed: json["closed"],
        sticky: json["sticky"],
        createdAt: json["createdAt"],
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "fid": fid,
        "uid": uid,
        "author": author,
        "views": views,
        "replies": replies,
        "closed": closed,
        "sticky": sticky,
        "createdAt": createdAt,
        "post": post?.toJson(),
      };
}

class Post {
  final int? id;
  final int? tid;
  final int? fid;
  final int? uid;
  final String? author;
  final String? subject;
  final String? message;

  Post({
    this.id,
    this.tid,
    this.fid,
    this.uid,
    this.author,
    this.subject,
    this.message,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        tid: json["tid"],
        fid: json["fid"],
        uid: json["uid"],
        author: json["author"],
        subject: json["subject"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tid": tid,
        "fid": fid,
        "uid": uid,
        "author": author,
        "subject": subject,
        "message": message,
      };
}
