class Milestone {
  final String id;
  String task;

  Milestone(this.id, this.task);

  Map<String, String> get toJson => {'task': task};
}
