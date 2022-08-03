import '../../domain/entities/post_entity.dart';

class PostModelDataLayer extends PostEntity {
  PostModelDataLayer(
      {required int id, required String title, required String body})
      : super(id: id, title: title, body: body);
  factory PostModelDataLayer.fromJson(Map<String, dynamic> json) {
    return PostModelDataLayer(
        id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body};
  }
}
