import 'package:product_catalog/flavors.dart';
import 'main.dart';

// * Entry point for the stag flavor
void main() async {
  // Add environnement dependent code here
  // ...
  
  F.appFlavor = Flavor.stag;
  await runMainApp();
}
