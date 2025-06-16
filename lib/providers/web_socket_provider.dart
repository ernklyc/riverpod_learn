import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final webSocketProvider = StreamProvider.autoDispose<String>((ref) {
  final channel = WebSocketChannel.connect(
    Uri.parse(
      'wss://stream.binance.com:9443/ws/btcusdt@trade',
    ),
  );
  ref.onDispose(() {
    channel.sink.close();
  });
  return channel.stream.map((event) {
    final data = jsonDecode(event);
    return data['p'].toString();
  });
});
