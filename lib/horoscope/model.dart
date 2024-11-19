class HoroscopeData {
  final String sign;
  final Prediction prediction;

  HoroscopeData({required this.sign, required this.prediction});

  factory HoroscopeData.fromJson(Map<String, dynamic> json) {
    return HoroscopeData(
      sign: json['sign'],
      prediction: Prediction.fromJson(json['prediction']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sign': sign,
      'prediction': prediction.toJson(),
    };
  }
}

class Prediction {
  final String personal;
  final String health;
  final String profession;
  final String emotions;
  final String travel;
  final List<String> luck;

  Prediction({
    required this.personal,
    required this.health,
    required this.profession,
    required this.emotions,
    required this.travel,
    required this.luck,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      personal: json['personal'],
      health: json['health'],
      profession: json['profession'],
      emotions: json['emotions'],
      travel: json['travel'],
      luck: List<String>.from(json['luck']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personal': personal,
      'health': health,
      'profession': profession,
      'emotions': emotions,
      'travel': travel,
      'luck': luck,
    };
  }
}
