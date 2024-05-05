//Define the all flavors
enum Flavor { DEV, QA, UAT, PROD }

class FlavorConfig {
  final Flavor flavor;
  final String name;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor flavor}) {
    _instance ??= FlavorConfig._internal(
      flavor, getValue(flavor));
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name);

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isDevelopment() => _instance!.flavor == Flavor.DEV;

  static bool isQaTesting() => _instance!.flavor == Flavor.QA;

  static bool isUserAccTesting() => _instance!.flavor == Flavor.UAT;

  static bool isProduction() => _instance!.flavor == Flavor.PROD;

  //To get which flavor we applied
  static String getValue(Flavor flavor){
    switch(flavor){
      case Flavor.DEV:
        return "Dev";
      case Flavor.QA:
        return "Qa";
      case Flavor.UAT:
        return "Uat";
      case Flavor.PROD:
        return "Prod";
      default:
        return "";
    }
  }
}