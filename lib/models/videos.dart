class Video {
  String? name;
  String? key;
  String? site;
  String? type;

  Video({
    this.name,
    this.key,
    this.site,
    this.type,
  });

  Video.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    key = json['key']?.toString();
    site = json['site']?.toString();
    type = json['type']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['key'] = key;
    data['site'] = site;
    data['type'] = type;
    return data;
  }
}

Video emptyVideo = Video(type: "", name: "", key: "", site: "");
