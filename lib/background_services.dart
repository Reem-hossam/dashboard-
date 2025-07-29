import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'local_notification.dart';
void onStart(ServiceInstance service) async {

  DartPluginRegistrant.ensureInitialized(); // Required for Flutter isolate
  // Initialize notification plugin in background isolate
  await initializeNotifications();
  // Setup socket connection
  IO.Socket socket = IO.io(
    'https://1kh4zcgw-3000.uks1.devtunnels.ms',
    <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    },

  );
  socket.connect();
  socket.onConnect((_) {
    print('Socket connected');
  });
  socket.on('orderCreated', (data) async {
    print('Received: $data');
    await showNotification("New Event", "Data: $data");
  });
  socket.onDisconnect((_) => print('Socket disconnected'));
}