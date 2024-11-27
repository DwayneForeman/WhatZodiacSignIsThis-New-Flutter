class HoroscopeDatabaseModel {
  final String date;
  final String relationship;
  final String health;
  final String travel;
  final String luck;
  final String profession;
  final String emotions;

  HoroscopeDatabaseModel({
    required this.date,
    required this.relationship,
    required this.health,
    required this.travel,
    required this.luck,
    required this.profession,
    required this.emotions,
  });

  // Convert the HoroscopeDatabaseModel to a Map to insert into the SQLite database
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'relationship': relationship,
      'health': health,
      'travel': travel,
      'luck': luck,
      'profession': profession,
      'emotions': emotions,
    };
  }
}
