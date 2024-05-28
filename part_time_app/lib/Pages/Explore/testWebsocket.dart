import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class TestWebsocketPage extends StatefulWidget {
  const TestWebsocketPage({super.key});

  @override
  State<TestWebsocketPage> createState() => _TestWebsocketPageState();
}

class _TestWebsocketPageState extends State<TestWebsocketPage> {
  final TextEditingController _controller = TextEditingController();
  WebSocketChannel? _channel;
  String _connectionStatus = 'Not connected';
  bool _isLoading = false;
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _channel = WebSocketChannel.connect(
        Uri.parse(
            'ws://103.159.133.27:8085/webSocket/9c7be416-8a95-425f-ab1c-47f7552945a'),
      );
      setState(() {
        _connectionStatus = 'Connected';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _connectionStatus = 'Connection failed: $e';
        _isLoading = false;
      });
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty && _channel != null) {
      try {
        _channel!.sink.add(_controller.text);
      } catch (e) {
        setState(() {
          _connectionStatus = 'Send failed: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter WebSocket Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _isLoading ? CircularProgressIndicator() : Text(_connectionStatus),
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: _channel?.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }

  @override
  void dispose() {
    _channel?.sink.close(status.goingAway);
    _controller.dispose();
    super.dispose();
  }
}
