import 'package:chatgram/core/utils/app_colors.dart';
import 'package:chatgram/core/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chatgram/core/models/user_model.dart';
import 'package:chatgram/core/widgets/custom_text.dart';
import 'package:chatgram/presentation/home/widgets/avatar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;

  const ChatScreen({
    super.key,
    required this.user,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.removeListener(_onTextChange);
    _textController.dispose();
    super.dispose();
  }

  void _onTextChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        title: Row(
          children: [
            Avatar(
              radius: 25,
              photo: widget.user.photo,
            ),
            const Gap(10),
            CustomText(
              text: widget.user.name,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          reverse: true,
          itemCount: 30,
          padding: const EdgeInsets.only(bottom: 50, top: 20),
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.greenLight1,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: const CustomText(
                    text: "Qalesandasddsada",
                    fontSize: 16,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(color: AppColors.white),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: CustomTextfield(
                  prefixIcon: Icon(
                    CupertinoIcons.paperclip,
                    size: 25,
                    color: AppColors.grey,
                  ),
                  hintText: "Message",
                  isBorder: false,
                  focusNode: _focusNode,
                  controller: _textController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {},
                    child: _textController.text.isNotEmpty
                        ? SvgPicture.asset(
                            "assets/icons/send.svg",
                            colorFilter: ColorFilter.mode(
                              AppColors.blueLight2,
                              BlendMode.srcIn,
                            ),
                            width: 25,
                          )
                        : SvgPicture.asset(
                            "assets/icons/mic.svg",
                            colorFilter: ColorFilter.mode(
                              AppColors.blueLight2,
                              BlendMode.srcIn,
                            ),
                            width: 25,
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
