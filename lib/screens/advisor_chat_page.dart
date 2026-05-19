import 'package:flutter/material.dart';

import '../app/car_store_state.dart';
import '../models/dealer_message.dart';

class AdvisorChatScreen extends StatefulWidget {
  const AdvisorChatScreen({super.key, required this.state});

  final CarStoreState state;

  @override
  State<AdvisorChatScreen> createState() => _AdvisorChatScreenState();
}

class _AdvisorChatScreenState extends State<AdvisorChatScreen> {
  final _messageController = TextEditingController();
  late final Stream<List<DealerMessage>> _messageStream;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _messageStream = widget.state.watchAdvisorMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Advisor Chat',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Icon(Icons.support_agent_rounded),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<DealerMessage>>(
            stream: _messageStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }

              final messages = snapshot.data ?? const <DealerMessage>[];
              if (snapshot.connectionState == ConnectionState.waiting &&
                  messages.isEmpty) {
                return const Center(child: LinearProgressIndicator());
              }

              if (messages.isEmpty) {
                return const Center(
                  child: Text('Ask an advisor about inventory or delivery.'),
                );
              }

              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _MessageBubble(message: messages[index]);
                },
              );
            },
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 92),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    enabled: !_sending,
                    textInputAction: TextInputAction.send,
                    decoration: const InputDecoration(
                      hintText: 'Message your advisor',
                      prefixIcon: Icon(Icons.chat_bubble_outline_rounded),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.filled(
                  onPressed: _sending ? null : _sendMessage,
                  icon: _sending
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _sending) {
      return;
    }

    setState(() => _sending = true);
    _messageController.clear();
    try {
      await widget.state.sendAdvisorMessage(text);
    } finally {
      if (mounted) {
        setState(() => _sending = false);
      }
    }
  }
}

class AdvisorChatPage extends AdvisorChatScreen {
  const AdvisorChatPage({super.key, required super.state});
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final DealerMessage message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final fromAdvisor = message.senderId == 'advisor';

    return Align(
      alignment: fromAdvisor ? Alignment.centerLeft : Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.82,
        alignment: fromAdvisor ? Alignment.centerLeft : Alignment.centerRight,
        child: Card(
          color: fromAdvisor ? scheme.surface : scheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: fromAdvisor
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Text(
                  message.text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: fromAdvisor
                        ? scheme.onSurface
                        : scheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message.senderName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
