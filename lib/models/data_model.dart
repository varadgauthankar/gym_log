class Data {
  double weight;
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
