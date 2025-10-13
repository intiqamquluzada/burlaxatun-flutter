class NotificationsModel {
  final int? id;
  final int? user;
  final FromUser? fromUser;
  final String? notificationType;
  final int? forumId;
  final String? forumSlug;
  final String? title;
  final String? text;
  final int? notificationTemplate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationsModel({
    this.id,
    this.user,
    this.fromUser,
    this.notificationType,
    this.forumId,
    this.forumSlug,
    this.title,
    this.text,
    this.notificationTemplate,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        id: json["id"],
        user: json["user"],
        fromUser: json["from_user"] == null
            ? null
            : FromUser.fromJson(json["from_user"]),
        notificationType: json["notification_type"],
        forumId: json["forum_id"],
        forumSlug: json["forum_slug"],
        title: json["title"],
        text: json["text"],
        notificationTemplate: json["notification_template"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "from_user": fromUser?.toJson(),
        "notification_type": notificationType,
        "forum_id": forumId,
        "forum_slug": forumSlug,
        "title": title,
        "text": text,
        "notification_template": notificationTemplate,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class FromUser {
  final int? id;
  final String? fullName;
  final String? email;
  final String? image;
  final bool? fromVideoDoktor;

  FromUser({
    this.id,
    this.fullName,
    this.email,
    this.image,
    this.fromVideoDoktor,
  });

  factory FromUser.fromJson(Map<String, dynamic> json) => FromUser(
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
