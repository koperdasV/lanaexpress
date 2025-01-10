// import 'package:lanaexpress/core/base/ui/base_controller.dart';
// import 'package:lanaexpress/core/services/notification_service.dart';
// import 'package:lanaexpress/data/managers/logger/log_manager.dart';
// import 'package:lanaexpress/domain/models/blocked_units.dart';

// final class HoldViewModel extends BaseController {
//   late final NotificationService _notificationService = NotificationService.to;

//   List<BlocedUnits>? _blockedUnitsList = <BlocedUnits>[];
//   List<BlocedUnits>? get blockedUnitsList => _blockedUnitsList;

//   void init() async {
//     await getBlockedUnits();
//   }

//   Future<List<BlocedUnits>?> getBlockedUnits() async {
//     setBusy(true);
//     try {
//       final List<BlocedUnits>? res =
//           await _notificationService.getBlockedUnits();
//       if (res!.isNotEmpty) {
//         _blockedUnitsList = res;
//         setBusy(false);
//         notifyListeners();
//       } else {
//         _blockedUnitsList = <BlocedUnits>[];
//         setBusy(false);
//       }
//       return _blockedUnitsList;
//     } catch (e, stackTrace) {
//       LogManager().log(e, stackTrace);
//       setBusy(false);
//       return <BlocedUnits>[];
//     }
//   }
// }
