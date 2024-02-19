class WebtoonModel {
  final String title, thumb, id;

  // WebtoonModel(this.title, this.thumb, this.id);
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
