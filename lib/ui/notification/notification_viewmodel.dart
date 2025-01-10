import 'package:lanaexpress/core/base/ui/base_controller.dart';
import 'package:lanaexpress/core/services/notification_service.dart';
import 'package:lanaexpress/data/managers/logger/log_manager.dart';
import 'package:lanaexpress/domain/responses/bids_response.dart';

class NotificationViewModel extends BaseController {
  final NotificationService _notificationService = NotificationService.to;

  List<BidsResponse>? _bidsList = <BidsResponse>[];

  List<BidsResponse>? get bidsList => _bidsList;

  // set loadboards(List<BidsResponse>? loadboards) {
  //   _loadboards = loadboards;
  //   notifyListeners();
  // }

  // PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  // String _log = 'output:\n';
  // final TextEditingController apiKey = TextEditingController();
  // final TextEditingController cluster = TextEditingController();
  // final TextEditingController channelName = TextEditingController();
  // final TextEditingController eventName = TextEditingController();
  // final GlobalKey<FormState> channelFormKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> eventFormKey = GlobalKey<FormState>();
  // final ScrollController listViewController = ScrollController();
  // final TextEditingController data = TextEditingController();

  Future<void> init() async {
    setBusy(true);
    try {
      final List<BidsResponse>? res = await _notificationService.getBidsList();
      if (res != null) {
        _bidsList = res;
      } else {
        
      }
    } catch (e, stackTrace) {
      LogManager().log(e, stackTrace);
    }
    setBusy(false);
  }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   //if (!mounted) return;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   apiKey.text = prefs.getString("apiKey") ?? '';
  //   cluster.text = prefs.getString("cluster") ?? 'eu';
  //   channelName.text = prefs.getString("channelName") ?? 'my-channel';
  //   eventName.text = prefs.getString("eventName") ?? 'client-event';
  //   data.text = prefs.getString("data") ?? 'test';
  //   notifyListeners();
  // }

  // Future<void> onConnectPressed() async {
  //   if (!channelFormKey.currentState!.validate()) {
  //     return;
  //   }
  //   // Remove keyboard
  //   //FocusScope.of(context).requestFocus(FocusNode());
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("apiKey", 'f9d98cecfe897e4d65f0');
  //   prefs.setString("cluster", 'eu');
  //   prefs.setString("channelName", 'koper');

  //   try {
  //     await pusher.init(
  //         apiKey: apiKey.text,
  //         cluster: cluster.text,
  //         onConnectionStateChange: onConnectionStateChange,
  //         onError: onError,
  //         onSubscriptionSucceeded: onSubscriptionSucceeded,
  //         onEvent: onEvent,
  //         onSubscriptionError: onSubscriptionError,
  //         onDecryptionFailure: onDecryptionFailure,
  //         onMemberAdded: onMemberAdded,
  //         onMemberRemoved: onMemberRemoved,
  //         onSubscriptionCount: onSubscriptionCount,
  //         // authEndpoint: "<Your Authendpoint Url>",
  //         onAuthorizer: onAuthorizer);
  //     await pusher.subscribe(channelName: channelName.text);
  //     await pusher.connect();
  //   } catch (e) {
  //     LogManager().log("ERROR: $e");
  //   }
  // }

  // void onConnectionStateChange(dynamic currentState, dynamic previousState) {
  //   LogManager().log("Connection: $currentState");
  // }

  // void onError(String message, int? code, dynamic e) {
  //   LogManager().log("onError: $message code: $code exception: $e");
  // }

  // void onEvent(PusherEvent event) {
  //   LogManager().log("onEvent: $event");
  // }

  // void onSubscriptionSucceeded(String channelName, dynamic data) {
  //   LogManager().log("onSubscriptionSucceeded: $channelName data: $data");
  //   final me = pusher.getChannel(channelName)?.me;
  //   LogManager().log("Me: $me");
  // }

  // void onSubscriptionError(String message, dynamic e) {
  //   LogManager().log("onSubscriptionError: $message Exception: $e");
  // }

  // void onDecryptionFailure(String event, String reason) {
  //   LogManager().log("onDecryptionFailure: $event reason: $reason");
  // }

  // void onMemberAdded(String channelName, PusherMember member) {
  //   LogManager().log("onMemberAdded: $channelName user: $member");
  // }

  // void onMemberRemoved(String channelName, PusherMember member) {
  //   LogManager().log("onMemberRemoved: $channelName user: $member");
  // }

  // void onSubscriptionCount(String channelName, int subscriptionCount) {
  //   LogManager().log(
  //       "onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  // }

  // dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
  //   return {
  //     "auth": "foo:bar",
  //     "channel_data": '{"user_id": 1}',
  //     "shared_secret": "3a398434322d833ae29e"
  //   };
  // }

  // void onTriggerEventPressed() async {
  //   var eventFormValidated = eventFormKey.currentState!.validate();

  //   if (!eventFormValidated) {
  //     return;
  //   }
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("eventName", eventName.text);
  //   prefs.setString("data", data.text);
  //   pusher.trigger(PusherEvent(
  //       channelName: channelName.text,
  //       eventName: eventName.text,
  //       data: data.text));
  // }
}
