class Data {
  Weight weight;
  int reps;
  Data({this.weight, this.reps});

  Data.fromJson(Map<String, dynamic> json)
      : weight = json['weight'],
        reps = json['reps'];

  Map<String, dynamic> toJson() => {
        'weight': weight,
        'reps': reps,
      };
}

class Weight {
  double kg;
  double lbs;

  Weight({this.kg, this.lbs});

  Weight.fromJson(Map<String, dynamic> json)
      : kg = json['kg'],
        lbs = json['lbs'];

  Map<String, dynamic> toJson() => {
        'kg': kg,
        'lbs': lbs,
      };
}
