class Band {
  Band({
    this.id,
    this.name,
    this.votes,
  });

  factory Band.fromMap(Map<String, Object> map) {
    return Band(
      id: map['id'],
      name: map['name'],
      votes: map['votes'],
    );
  }

  String id;
  String name;
  int votes;
}
