class HtmlContentModel {
  HtmlContentModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  HtmlContentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}

class Data {
  Data({
    required this.content,
  });
  late final Content content;

  Data.fromJson(Map<String, dynamic> json) {
    content = Content.fromJson(json['content']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['content'] = content.toJson();
    return data;
  }
}

class Content {
  Content({
    required this.title,
    required this.description,
  });
  late final String title;
  late final String description;

  Content.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    description = json['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
