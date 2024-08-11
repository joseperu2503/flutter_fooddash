import 'package:fooddash/app/config/constants/environment.dart';
import 'package:fooddash/app/config/constants/storage_keys.dart';
import 'package:fooddash/app/features/core/services/storage_service.dart';
import 'package:fooddash/app/features/order/models/order.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class OrderSocket {
  late IO.Socket socket;
  final int orderId;
  final void Function(Order order) orderStatusUpdate;

  OrderSocket({
    required this.orderId,
    required this.orderStatusUpdate,
  });

  Future<void> connect() async {
    final token = await StorageService.get<String>(StorageKeys.token);

    // Configuración del socket
    socket = IO.io(
      '${Environment.baseUrl}/orders',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'authorization': token}) // optional
          .build(),
    );

    // Conectar al socket
    socket.connect();

    // Escuchar cuando el socket esté conectado
    socket.onConnect((_) {
      // print('Connected to WebSocket ${socket.id}');
      // Unirse al canal específico de la orden
      socket.emit('joinOrderChannel', {'orderId': orderId});
    });

    // Escuchar actualizaciones de estado de la orden
    socket.on('orderStatusUpdate', (dynamic data) {
      Order order = Order.fromJson(data);
      // print('Order ${order.id} status updated: ${order.orderStatus.name}');
      orderStatusUpdate(order);
    });

    // Manejar errores de conexión
    socket.onConnectError((data) {
      // print('Connect Error: $data');
    });

    // Manejar la desconexión
    socket.onDisconnect((_) {
      // print('Disconnected from WebSocket');
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
