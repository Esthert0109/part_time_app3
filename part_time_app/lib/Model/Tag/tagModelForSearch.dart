class TagModelForSearch {
  final int code;
  final String msg;
  final List<TagDataForSearch> data;

  TagModelForSearch(
      {required this.code, required this.msg, required this.data});

  factory TagModelForSearch.fromJson(Map<String, dynamic> json) {
    int code = json['code'];
    String msg = json['msg'];
    Map<String, dynamic> data = json['data'];
    List<TagDataForSearch> tagDataList = data.entries.map((entry) {
      return TagDataForSearch.fromJson(entry.key, entry.value);
    }).toList();
    return TagModelForSearch(code: code, msg: msg, data: tagDataList);
  }
}

class TagDataForSearch {
  final String category;
  final List<TagForSearch> tags;

  TagDataForSearch({required this.category, required this.tags});

  factory TagDataForSearch.fromJson(String category, List<dynamic> json) {
    List<TagForSearch> tags =
        json.map((tag) => TagForSearch.fromJson(tag)).toList();
    return TagDataForSearch(category: category, tags: tags);
  }
}

class TagForSearch {
  final int id;
  final String name;

  TagForSearch({required this.id, required this.name});

  factory TagForSearch.fromJson(Map<String, dynamic> json) {
    return TagForSearch(
      id: json['tagId'],
      name: json['tagName'],
    );
  }
}
