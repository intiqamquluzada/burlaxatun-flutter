class VideoModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<Video>? results;

  VideoModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Video>.from(
                json["results"]!.map((x) => Video.fromJson(x))),
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

class Video {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? slug;
  final String? file;
  final String? link;
  final dynamic thumbnail;
  final String? name;
  final String? text;
  final dynamic category;

  Video({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.file,
    this.link,
    this.thumbnail,
    this.name,
    this.text,
    this.category,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        slug: json["slug"],
        file: json["file"],
        link: json["link"],
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
        "link": link,
        "thumbnail": thumbnail,
        "name": name,
        "text": text,
        "category": category,
      };
}
