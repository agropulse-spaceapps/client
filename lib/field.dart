import 'package:map_location_picker/map_location_picker.dart';

enum Plant {
  artichoke,
  arugula,
  asparagus,
  beet,
  bellPepper,
  bokChoy,
  broccoli,
  brusselsSprouts,
  cabbage,
  carrot,
  cauliflower,
  celery,
  chard,
  collardGreens,
  corn,
  cucumber,
  eggplant,
  endive,
  fennel,
  garlic,
  greenBean,
  kale,
  kohlrabi,
  leek,
  lettuce,
  mushroom,
  mustardGreens,
  okra,
  onion,
  parsnip,
  pea,
  potato,
  pumpkin,
  radish,
  rhubarb,
  rutabaga,
  scallion,
  shallot,
  spinach,
  squash,
  sweetPotato,
  tomato,
  turnip,
  watercress,
  yam,
  zucchini,
  apple,
  apricot,
  avocado,
  banana,
  blackberry,
  blueberry,
  cherry,
  coconut,
  cranberry,
  date,
  dragonFruit,
  durian,
  elderberry,
  fig,
  gooseberry,
  grape,
  grapefruit,
  guava,
  kiwi,
  lemon,
  lime,
  lychee,
  mango,
  melon,
  nectarine,
  orange,
  papaya,
  passionFruit,
  peach,
  pear,
  pineapple,
  plum,
  pomegranate,
  raspberry,
  strawberry,
  tangerine,
  watermelon,
  // Add more plants as needed
}

class Field {
  final double organicMatter = 3.5;
  int? rain; // per mm^2
  double? temperature;
  int? yp;

  final String name;
  final int area;
  final GeocodingResult location;
  // optional
  double? ph;
  int? soilState;
  int? soilHumidity; 
  double? nitrogen;
  double? phosphorus;
  int? potassium;
  double? finalResult;
  Plant? crop;

  // TODO: add location
  // location based variables: temperature, rain
  // user based variables: ph, soilState, soilHumidity, nitrogen, phosphorus, potassium 

  void recalculate() {
    // double v=(ph+organicMatter+soilState)/3;
    // double c=(temperature+rain+soilHumidity)/3;
    // double m=(nitrogen+phosphorus+potassium)/3;
    // double w=(soilState+soilHumidity+rain)/3;
    // double yield=v*c*m*w;
    // finalResult = yield*yp;
  }

  Field({
    required this.name,
    this.ph,
    this.soilState,
    this.soilHumidity,
    this.nitrogen,
    this.phosphorus,
    this.potassium,
    required this.area,
    this.crop,
    required this.location,
  }) {
    recalculate();
  } // TODO: require location
}