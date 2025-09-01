import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyUsers = [
      {
        "name": "John Doe",
        "imageUrl": null,
        "lastMessage": "Hello, how are you?",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "unreadCounter": 2
      },
      {
        "name": "Jane Smith",
        "imageUrl": null,
        "lastMessage": "Let’s meet tomorrow!",
        "timestamp": DateTime.now().subtract(const Duration(hours: 2)).millisecondsSinceEpoch,
        "unreadCounter": 0
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
      child: Column(
        children: [
          30.verticalSpace,
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Chats", style: h),
          ),
          20.verticalSpace,
         const CustomTextfield(hintText: "Search here...", isSearch: true),
          10.verticalSpace,
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 5),
              itemCount: dummyUsers.length,
              separatorBuilder: (context, index) => 8.verticalSpace,
              itemBuilder: (context, index) {
                final user = dummyUsers[index];
                return ChatTile(
                  name: user["name"] as String,
                  imageUrl: user["imageUrl"] as String?,
                  lastMessage: user["lastMessage"] as String?,
                  timestamp: user["timestamp"] as int,
                  unreadCounter: user["unreadCounter"] as int,
                  onTap: () {},
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.name,
    this.imageUrl,
    this.lastMessage,
    required this.timestamp,
    required this.unreadCounter,
    this.onTap,
  });

  final String name;
  final String? imageUrl;
  final String? lastMessage;
  final int timestamp;
  final int unreadCounter;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final lastMessageTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    final minutes = now.difference(lastMessageTime).inMinutes;

    String timeAgo;
    if (minutes < 60) {
      timeAgo = "$minutes minutes ago";
    } else {
      final hours = now.difference(lastMessageTime).inHours;
      timeAgo = "$hours hours ago";
    }

    return ListTile(
      onTap: onTap,
      tileColor: grey.withOpacity(0.12),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      leading: imageUrl == null
          ? CircleAvatar(
              backgroundColor: grey.withOpacity(0.5),
              radius: 25,
              child: Text(name[0], style: h),
            )
          : ClipOval(
              child: Image.network(
                imageUrl!,
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              ),
            ),
      title: Text(name),
      subtitle: Text(
        lastMessage ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(timeAgo, style: const TextStyle(color: grey)),
          8.verticalSpace,
          unreadCounter == 0
              ? const SizedBox(height: 15)
              : CircleAvatar(
                  radius: 9.r,
                  backgroundColor: primary,
                  child: Text(
                    "$unreadCounter",
                    style: small.copyWith(color: white),
                  ),
                )
        ],
      ),
    );
  }
}
