import 'package:flutter/material.dart';
import 'package:flutter_techhelp_app/app/models/usuario_base_model.dart';
import 'package:flutter_techhelp_app/app/utils/app_colors.dart';
import '../services/openai_service.dart';
import 'widgets/TypingIndicator_widget.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final OpenAIService _openAIService = OpenAIService();
  final List<Map<String, dynamic>> _messages = [];
  bool isLoading = false;
  bool firstMsg = false;
  String _response = '';

  UsuarioBase? usuario;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    usuario ??=
        ModalRoute.of(context)!.settings.arguments as UsuarioBase;
  }

  Future<void> _getResponse() async {
    final text = _controller.text;
    setState(() => _controller.clear());
    if (text.isEmpty) return;

    final reply = await _openAIService.sendMessage(
      text, 
      usuario!.id!,
    );
    setState(() => _response = reply);
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": text});
      isLoading = true;
      _messages.add({"sender": "bot", "text": 'thinking',});
    });

    await _getResponse();

    setState(() {
      _messages.removeLast();
      _messages.add({"sender": "bot", "text": _response});
      _messages.add({
        "sender": "bot",
        "text":''
            "Tem mais algum problema que você queira descrever ${usuario!.nomeRazao.split(' ').first}?",
      });
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuario =
        ModalRoute.of(context)!.settings.arguments as UsuarioBase;

    // Manda a primeira mensagem
    while (!firstMsg) {
      _messages.add({
        "sender": "bot",
        "text":''
            "Olá ${usuario.nomeRazao.split(' ').first}, descreva o seu problema para que eu possa criar um chamado.",
      });
      firstMsg = true;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("TechHelp")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg["sender"] == "user";

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 280),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.primary : AppColors.darkBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: msg["text"] == 'thinking' ? TypingIndicator(color: Colors.white) : Text(
                      msg["text"] ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Digite sua mensagem...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onEditingComplete: !isLoading ? _sendMessage : null,
                    enabled: !isLoading,
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    side: BorderSide(color: Colors.white, width: 1),
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: !isLoading ? _sendMessage : null,
                  child: const Icon(
                    Icons.send_rounded,
                    color: AppColors.secondary,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
