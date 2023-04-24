import 'package:maintenance_app/Constants/AppImports.dart';

class RequestController extends ChangeNotifier {
  // constructor
  RequestController(this.context);

  // variables
  final BuildContext context;
  final List<UserRequestDatum> _requestList = [];

  // getter
  get getRequestList => _requestList;

  // setter
  setRequestList(List<UserRequestDatum> list) {
    _requestList.clear();
    _requestList.addAll(list);
    notifyListeners();
  }

  // functions
  addRequestList(UserRequestDatum data) {
    _requestList.add(data);
    notifyListeners();
  }
}
