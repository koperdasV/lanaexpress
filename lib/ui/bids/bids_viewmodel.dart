import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:lanaexpress/core/base/ui/base_controller.dart';
import 'package:lanaexpress/core/services/notification_service.dart';
import 'package:lanaexpress/core/services/status_service.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/domain/models/user_info_model.dart';
import 'package:lanaexpress/domain/responses/bids_response.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class BidsViewModel extends BaseController {
  final NotificationService _notificationService = NotificationService.to;
  late final StatusService _statusService = StatusService.to;

  static const String _notificationsKey = 'notifications';
  static const String _lastClearDateKey = 'lastClearDate';
  static const int _daysToClear = 5; // Кількість днів до очищення
  static const int _notificationsToKeep = 3;

  PusherChannelsFlutter pusher = PusherChannelsFlutter();
  String eventMessage = 'Waiting for events...';

  List<BidsResponse>? _bidsList = <BidsResponse>[];

  List<BidsResponse>? get bidsList => _bidsList;

  List<String>? _notifications = <String>[];

  List<String>? get notifications => _notifications;

  set notificationsList(final List<String>? notifications) {
    _notifications = notifications;
    notifyListeners();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> init() async {
    await getUserInfo();
    await initPusher();
    await loadNotifications();
    setBusy(true);
    // try {
    //   final List<BidsResponse>? res = await _notificationService.getBidsList();
    //   if (res != null) {
    //     _bidsList = res;
    //   } else {}
    // } catch (e, stackTrace) {
    //   LogManager().log(e, stackTrace);
    // }
    setBusy(false);
  }

  int? _companyID;
  int? get companyID => _companyID;
  
  int? _driverID;
  int? get driverID => _driverID;

  UserInfo? _userInfo;

  UserInfo? get userInfo => _userInfo;

  set userInfo(final UserInfo? userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  Future<void> getUserInfo() async {
    setBusy(true);
    try {
      final UserInfo? res = await _statusService.getUserInfo();
      if (res != null) {
        userInfo = res;
        if (userInfo?.drivers?.isNotEmpty ?? false) {
          _companyID = userInfo?.drivers?.first.companyId;
          if (kDebugMode) {
            print('First Driver\'s Company ID: $_companyID');
          }
        }
      } else {
        if (kDebugMode) {
          print('User info is null');
        }
      }
      setBusy(false);
    } catch (e, stackTrace) {
      LogManager().log(e, stackTrace);
    }
    setBusy(false);
  }

  Future<void> initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
        apiKey: "9cf69dd52a79ffd55b9f", // 9cf69dd52a79ffd55b9f
        cluster: "us3", // Наприклад, 'us2'
        onEvent: onPusherEvent,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onError: onError,
      );

      // application-lana-pusher-company_id
      // application-lana-pusher-driver_id
      await pusher.subscribe(
        channelName: "application-lana-pusher-company_$_companyID",
      );
      await pusher.connect();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void onPusherEvent(final PusherEvent event) async {
    // Ігноруємо подію "pusher:subscription_succeeded"
    if (event.eventName == "pusher:subscription_succeeded") {
      return;
    }

    // Обробляємо всі інші події
    eventMessage = "${event.eventName}, ${event.data}";
    _notifications?.add("${event.eventName}, ${event.data}");
    await saveNotification(event.data);
    await _playNotificationSound();
    notifyListeners();
  }

  // Метод для відтворення звуку при отриманні події
  Future<void> _playNotificationSound() async {
    await _audioPlayer
        .play(AssetSource('sounds/mixkit-retro-game-notification-212.wav'));
  }

  Future<void> loadNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> storedNotifications =
        prefs.getStringList('notifications') ?? <String>[];

    _notifications = storedNotifications;
  }

  // Збереження подій локально
  Future<void> saveNotification(final String notification) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Перевірка, чи потрібно очищати
    await _checkAndClearOldNotifications(prefs);

    // Збереження сповіщення
    final List<String> notifications =
        prefs.getStringList(_notificationsKey) ?? <String>[];
    notifications.add(notification);
    await prefs.setStringList(_notificationsKey, notifications);
  }

  Future<void> _checkAndClearOldNotifications(
    final SharedPreferences prefs,
  ) async {
    final String? lastClearDateString = prefs.getString(_lastClearDateKey);
    final DateTime now = DateTime.now();

    if (lastClearDateString != null) {
      final DateTime lastClearDate = DateTime.parse(lastClearDateString);
      final Duration difference = now.difference(lastClearDate);

      if (difference.inDays >= _daysToClear) {
        List<String> notifications =
            prefs.getStringList(_notificationsKey) ?? <String>[];

        // Залишаємо тільки останні _notificationsToKeep елементів
        if (notifications.length > _notificationsToKeep) {
          notifications = notifications.sublist(
            notifications.length - _notificationsToKeep,
          );
        }

        await prefs.setStringList(
          _notificationsKey,
          notifications,
        ); // Оновлення списку сповіщень
        await prefs.setString(
          _lastClearDateKey,
          now.toIso8601String(),
        ); // Оновлення дати
      }
    } else {
      // Якщо дати немає, зберігаємо поточну дату
      await prefs.setString(_lastClearDateKey, now.toIso8601String());
    }
  }
}

void onSubscriptionSucceeded(final String channelName, final dynamic data) {
  if (kDebugMode) {
    print("Subscription succeeded to $channelName");
  }
}

void onError(final String message, final int? code, final dynamic e) {
  if (kDebugMode) {
    print("Pusher error: $message (code: $code)");
  }
}
