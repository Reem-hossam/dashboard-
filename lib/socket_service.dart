import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initSocket(BuildContext context) {
    socket = IO.io(
      'https://1kh4zcgw-3000.uks1.devtunnels.ms',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      },
    );

    socket.onConnect((_) {
      print('✅ Socket connected');
    });

    socket.on('orderCreated', (data) {
      print('📦 New order created: $data');

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎉 New Order Created!'),
          content: Text('Order title: ${data['title'] ?? 'No title'}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });

    socket.onDisconnect((_) {
      print('❌ Socket disconnected');
    });
  }

  void dispose() {
    socket.dispose();
  }
}
