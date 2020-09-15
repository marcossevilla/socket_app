class Band {
  Band({
    this.id,
    this.name,
    this.votes,
  });

  factory Band.fromMap(Map<String, Object> map) {
    return Band(
      id: map.containsKey('id') ? map['id'] : 'no-id',
      name: map.containsKey('name') ? map['name'] : 'no-name',
      votes: map.containsKey('votes') ? map['votes'] : 'no-votes',
    );
  }

  String id;
  String name;
  int votes;
}
