import 'package:map_location_picker/map_location_picker.dart';

enum Plant {
  wheat,        
  beans,
  lentil,                                 
  chickpeas,
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
  headCabbage,
  kale,
  kohlrabi,
  leek,
  lettuce,
  mushroom,
  mustardGreens,
  oilPumpkin,
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

class Stats {
  int? rain; // per mm^2
  double? temperature;
  // optional
  double ph;
  int soilState;
  int humidity; 
  double nitrogen;
  double phosphorus;
  int potassium;
  double organicMatter;
  Stats({
    this.rain,
    this.temperature,
    required this.ph,
    required this.soilState, // default value for crop is 25
    required this.humidity,
    required this.nitrogen, // default value for crop is 0.350
    required this.phosphorus, // default value for crop is 8
    required this.potassium, // default value for crop is 200
    required this.organicMatter, // default value for crop is 3.5
  });
}

class Field {
  int? yp;

  final String name;
  final int area;
  final GeocodingResult location;
  
  double? finalResult;
  Plant? cropType;
  Stats? crop;
  Stats soil;
  double? yield;
  
  num abs(num x) {
    return x<0?-x:x;
  }

  void recalculate() {
    // TODO: use csv file to get crop stats and api for other things
    double x= abs(crop!.ph-soil.ph)/0.1;
    x*= 0.0071;
    x+= 1;
    double y = abs(crop!.organicMatter-soil.organicMatter)/0.01;
    y*= 0.00142;
    y+= 1;
    double z = abs(crop!.soilState-soil.soilState)/1;
    z*= 0.002;
    z+= 1;
    double a= abs(crop!.temperature!-soil.temperature!)/0.1;
    a*= 0.001;
    a+= 1;
    double b= abs(crop!.rain!-soil.rain!)/1;
    b*= 0.000555;
    b+= 1;
    double c= abs(crop!.humidity-soil.humidity)/1;
    c*= 0.011;
    c+= 1;
    double d= abs(crop!.nitrogen-soil.nitrogen)/0.001;
    d*= 0.001;
    d+= 1;
    double e= abs(crop!.phosphorus-soil.phosphorus)/0.1;
    e*= 0.0071;
    e+= 1;
    double f= abs(crop!.potassium-soil.potassium)/1;
    f*= 0.002;
    f+= 1;
    double v = (x+y+z)/3;
    double h = (a+b+c)/3;
    double m = (d+e+f)/3;
    double w = (z+b+c)/3;
    yield = (v * h * m * w);
    finalResult = yield! * yp!;
  }

  Field({
    required this.name,
    required this.soil,
    required this.area,
    this.cropType,
    required this.location,
  }) {
    // recalculate();
  }
}