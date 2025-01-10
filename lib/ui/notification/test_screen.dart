import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

final class PusherNotification extends StatefulWidget {
  const PusherNotification({super.key});

  @override
  State<PusherNotification> createState() => _PusherNotificationState();
}

class _PusherNotificationState extends State<PusherNotification> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter();
  String eventMessage = 'Waiting for events...';
  List<String> notifications = <String>[];

  @override
  void initState() {
    super.initState();
    initPusher();
  }

  Future<void> initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();

    try {
      await pusher.init(
        apiKey: "161ffab7fc0d7656ff1a", // Замініть на свій API Key
        cluster: "us3", // Наприклад, 'us2'
        onEvent: onPusherEvent,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onError: onError,
      );

      await pusher.subscribe(channelName: "koperdas_13");
      await pusher.connect();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void onPusherEvent(final PusherEvent event) {
    setState(() {
      eventMessage = "Received event: ${event.eventName}, data: ${event.data}";
      notifications.add("Event: ${event.eventName}, Data: ${event.data}");
    });
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

  @override
  Widget build(final BuildContext context) {
    return notifications.isEmpty
            ? const Center(child: Text("Waiting for notifications..."))
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(notifications[index]),
                  );
                },
    );
  }
}
