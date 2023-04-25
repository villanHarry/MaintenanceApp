import 'package:maintenance_app/Constants/AppImports.dart';

class RequestController extends ChangeNotifier {
  // constructor
  RequestController(this.context);

  // variables
  final BuildContext context;
  final List<UserRequestDatum> _requestList = [];
  final List<AdminRequestDatum> _pendingRequestList = [];
  final List<AdminRequestDatum> _processingRequestList = [];
  final List<AdminRequestDatum> _completedRequestList = [];

  // getter
  get getRequestList => _requestList;
  get getPendingRequests => _pendingRequestList;
  get getProcessingRequests => _processingRequestList;
  get getCompletedRequests => _completedRequestList;

  // setter
  setRequestList(List<UserRequestDatum> list) {
    _requestList.clear();
    _requestList.addAll(list);
    notifyListeners();
  }

  setPendingRequests(List<AdminRequestDatum> list) {
    _pendingRequestList.clear();
    _pendingRequestList.addAll(list);
    notifyListeners();
  }

  setProcessingRequests(List<AdminRequestDatum> list) {
    _processingRequestList.clear();
    _processingRequestList.addAll(list);
    notifyListeners();
  }

  setCompletedRequests(List<AdminRequestDatum> list) {
    _completedRequestList.clear();
    _completedRequestList.addAll(list);
    notifyListeners();
  }

  // functions
  addRequestList(UserRequestDatum data) {
    _requestList.add(data);
    notifyListeners();
  }

  removeRequest(String id, String category) {
    if (category == AppConstant.statusList[0]) {
      _pendingRequestList.removeWhere((element) => element.id == id);
      notifyListeners();
    }
    if (category == AppConstant.statusList[1]) {
      _processingRequestList.removeWhere((element) => element.id == id);
      notifyListeners();
    }
    if (category == AppConstant.statusList[2]) {
      _completedRequestList.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }
}
