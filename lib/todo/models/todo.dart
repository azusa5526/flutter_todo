class Todo {
  Todo(
      {required this.id,
      required this.title,
      this.content,
      required this.state});

  String id;
  String title;
  String? content;
  String state;

  factory Todo.fromJson(Map<String, dynamic> json) => switch (json) {
        {
          '_id': String id,
          'title': String title,
          'content': String? content,
          'state': String state,
        } =>
          Todo(id: id, title: title, content: content, state: state),
        _ => throw const FormatException('Your format fucked up')
      };
}
