import 'package:grpc/grpc.dart';

const serverPort = 3000;
const retryDelay = Duration(milliseconds: 5);

ClientChannel newClient(String ip, int port) {
  return ClientChannel(
    ip,
    port: port,
    options: ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      idleTimeout: Duration(hours: 24),
    ),
  );
}
