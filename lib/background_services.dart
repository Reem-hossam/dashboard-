import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'local_notification.dart';

void onStart(ServiceInstance service) async {
  //DartPluginRegistrant.ensureInitialized();
  debugPrint("🚀 onStart started");

  if (service is AndroidServiceInstance) {
    await service.setAsForegroundService();
    await service.setForegroundNotificationInfo(
      title: " Service Active",
      content: "Listening for orders...",
    );
  }

  await initializeNotifications();

  IO.Socket socket = IO.io(
    'https://1kh4zcgw-3002.uks1.devtunnels.ms',
    <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    },
  );

  socket.connect();
  debugPrint("🚀 Connecting to socket...");

  // socket.onConnect((_) {
  //   debugPrint('✅ Socket connected');
  // });
  socket.onConnect((_) async {
    debugPrint('✅ Socket connected');

    await showNotification("Connected", "Socket is connected!");
  });

  socket.onDisconnect((_) {
    debugPrint('❌ Socket disconnected');
  });

  socket.on('orderCreated', (data) async {
    try {
      print('📦 Order received: $data');

      // Notification
      await showNotification("🛎️ New Order", "Order: ${data['title'] ?? 'No title'}");

      // Send to UI if needed
      service.invoke('showPopup', {
        "title": " New Order",
        "body": "Order: ${data['title'] ?? 'No title'}",
      });
    } catch (e, stack) {
      debugPrint('❌ Error in orderCreated handler: $e');
      debugPrint('📄 Stack trace: $stack');
    }
  });



}
