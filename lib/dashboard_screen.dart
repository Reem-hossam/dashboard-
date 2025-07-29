import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'socket_service.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final SocketService _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    // Listen for popup trigger from background service
    FlutterBackgroundService().on('showPopup').listen((event) {
      if (event != null && mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(event['title'] ?? 'New Event'),
            content: Text(event['body'] ?? 'Details...'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Dashboard'),
      ),
      body: const Center(
        child: Text('Waiting for new orders...'),
      ),
    );
  }
}
