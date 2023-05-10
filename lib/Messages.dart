import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;

  const MessagesScreen({super.key, required this.messages});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: widget.messages[index]['isUserMsg']
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          20,
                        ),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(
                            widget.messages[index]['isUserMsg'] ? 0 : 20),
                        topLeft: Radius.circular(
                            widget.messages[index]['isUserMsg'] ? 20 : 0),
                      ),
                      color: widget.messages[index]['isUserMsg']
                          ? Colors.white70
                          : Colors.white70.withOpacity(0.8)),
                  constraints: BoxConstraints(maxWidth: w * 2 / 3),
                  child: Text(widget.messages[index]['message'].text.text[0])),
            ],
          );
        },
        separatorBuilder: (_, i) =>
            Padding(padding: EdgeInsets.only(top: 10.0)),
        itemCount: widget.messages.length);
  }
}
