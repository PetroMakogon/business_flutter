import 'package:chat_babakcode/ui/pages/chat/chat_item_photo.dart';
import 'package:chat_babakcode/ui/pages/chat/chat_item_text.dart';
import 'package:chat_babakcode/ui/pages/chat/chat_item_update_required.dart';
import 'package:chat_babakcode/providers/global_setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_constants.dart';
import '../../../models/chat.dart';
import '../../../models/room.dart';
import '../../../providers/chat_provider.dart';

part './chat_items.dart';

class AppChatItem extends StatelessWidget {
  final int index;
  final bool fromMyAccount,
      previousChatFromUser,
      nextChatFromUser,
      middleChatFromUser;

  const AppChatItem(this.index, this.fromMyAccount, this.previousChatFromUser,
      this.nextChatFromUser, this.middleChatFromUser,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final globalSettingProvider = context.read<GlobalSettingProvider>();

    var borders = BorderRadius.only(
        topLeft: previousChatFromUser
            ? const Radius.circular(6)
            : const Radius.circular(16),
        topRight: const Radius.circular(16),
        bottomLeft: const Radius.circular(6),
        bottomRight: const Radius.circular(16));

    if (fromMyAccount) {
      borders = BorderRadius.only(
          bottomLeft: borders.bottomRight,
          bottomRight: borders.bottomLeft,
          topLeft: borders.topRight,
          topRight: borders.topLeft);
    }

    final chatProvider = context.read<ChatProvider>();

    final Room room = chatProvider.selectedRoom!;
    Chat chat = room.chatList[index];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: borders,
        color: globalSettingProvider.isDarkTheme
            ? fromMyAccount
            ? AppConstants.textColor[700]
            : AppConstants.textColor[300]
            : fromMyAccount
            ? AppConstants.textColor[50]
            : AppConstants.textColor[200],
      ),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: borders,
          color: globalSettingProvider.isDarkTheme
              ? fromMyAccount
                  ? AppConstants.textColor[700]
                  : AppConstants.textColor[300]
              : fromMyAccount
                  ? AppConstants.textColor[50]
                  : AppConstants.textColor[200],
        ),
        // padding: const EdgeInsets.all(12),
        child: Builder(builder: (context) {
          if(chat is ChatTextModel){
            return ChatItemText(fromMyAccount, chat: chat,);
          }else if(chat is ChatPhotoModel){
            return ChatItemPhoto(fromMyAccount, chat: chat,);
          }
          return const ChatItemUpdateRequired();
        },)

        // chat.type == ChatType.text
        //     ?
        //     : chat.type == ChatType.photo
        //         ? _ItemPhoto(fromMyAccount, index)
        //         : chat.type == ChatType.voice
        //             ? _itemVoice(context, fromMyAccount, index)
        //             : ,
      ),
    );
  }

}
