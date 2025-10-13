class SpecializationModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<Specialization>? results;

  SpecializationModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory SpecializationModel.fromJson(Map<String, dynamic> json) =>
      SpecializationModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Specialization>.from(
                json["results"]!.map((x) => Specialization.fromJson(x))),
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

class Specialization {
  final int? id;
  final String? name;
  final String? description;
  final int? active;

  Specialization({
    this.id,
    this.name,
    this.description,
    this.active,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "active": active,
      };
}
