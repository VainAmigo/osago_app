class Car {
  final String id;
  final String inn;
  final String brand;
  final String model;
  final String year;
  final String govPlate;
  final String carType;
  final String carCategory;
  final String motorType;
  final String engineVolume;
  final String carIdNumber;
  final bool certificate;

  Car(
      {required this.id,
      required this.inn,
      required this.brand,
      required this.model,
      required this.year,
      required this.govPlate,
      required this.carType,
      required this.carCategory,
      required this.motorType,
      required this.engineVolume,
      required this.certificate,
      required this.carIdNumber});

  Car copyWith() {
    return Car(
      id: id,
      inn: inn,
      brand: brand,
      model: model,
      year: year,
      govPlate: govPlate,
      carType: carType,
      carCategory: carCategory,
      motorType: motorType,
      engineVolume: engineVolume,
      certificate: certificate,
      carIdNumber: carIdNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inn': inn,
      'brand': brand,
      'model': model,
      'year': year,
      'govPlate': govPlate,
      'carType': carType,
      'carCategory': carCategory,
      'motorType': motorType,
      'engineVolume': engineVolume,
      'certificate': certificate,
      'carIdNumber': carIdNumber,
    };
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      inn: json['inn'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      govPlate: json['govPlate'],
      carType: json['carType'],
      carCategory: json['carCategory'],
      motorType: json['motorType'],
      engineVolume: json['engineVolume'],
      certificate: json['certificate'],
      carIdNumber:  json['carIdNumber'],
    );
  }
}
