import '../Constants/AppImports.dart';

class AppProviders {
  final List<SingleChildWidget> _providerList = [
    ChangeNotifierProvider(create: (context) => AuthController(context)),
    ChangeNotifierProvider(create: (context) => RequestController(context)),
  ];

  get getAllProviders => _providerList;
}
