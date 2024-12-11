class SelectedModel {
  String? text;
  dynamic value;

  SelectedModel({
    this.text,
    this.value,
  });

  SelectedModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    return data;
  }

  static List<SelectedModel> fromJsonList(List list) {
    return list.map((e) => SelectedModel.fromJson(e)).toList();
  }
}
