import 'package:fooddash/app/config/constants/environment.dart';
import 'package:fooddash/app/config/constants/storage_keys.dart';
import 'package:fooddash/app/features/core/services/storage_service.dart';
import 'package:fooddash/app/features/order/models/order.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class OrderSocket {
  late io.Socket socket;
  final void Function(List<Order> orders) upcomingOrdersUpdated;

  OrderSocket({
    required this.upcomingOrdersUpdated,
  });

  Future<void> connect() async {
    final token = await StorageService.get<String>(StorageKeys.token);

    //* Configuración del socket */
    socket = io.io(
      '${Environment.baseUrl}/orders',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'authorization': token})
          .build(),
    );

    //** Conectar al socket */
    socket.connect();

    //** Escuchar cuando el socket esté conectado */
    socket.onConnect((_) {
      // print('Connected to WebSocket ${socket.id}');
      //** Unirse al canal específico de la orden */
      // socket.emit(
      //   'joinOrderChannel',
      // );
    });

    //** Escuchar actualizaciones de la orden */
    socket.on('upcomingOrdersUpdated', (dynamic data) {
      List<Order> orders = List<Order>.from(data.map((x) => Order.fromJson(x)));
      print('upcomingOrdersUpdated #orders: ${orders.length}');
      upcomingOrdersUpdated(orders);
    });

    //** Manejar errores de conexión */
    socket.onConnectError((data) {
      // print('Connect Error: $data');
    });

    //** Manejar la desconexión */
    socket.onDisconnect((_) {
      // print('Disconnected from WebSocket');
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
