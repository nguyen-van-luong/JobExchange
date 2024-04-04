import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:job_exchange/ui/router.dart';

import '../../../dtos/jwt_payload.dart';
import '../user_avatar.dart';

class ItemMenu {
  ItemMenu({required this.name, required this.icon, required this.route});

  final String name;
  final IconData icon;
  final String route;
}

class RightHeader extends StatefulWidget {
  const RightHeader({super.key});
  

  @override
  State<RightHeader> createState() => _RightHeaderState();
}

class _RightHeaderState extends State<RightHeader> {

  List<ItemMenu> profilerMenu = [
    ItemMenu(
        name: "Trang cá nhân",
        icon: Icons.person,
        route: "/profile/}"),
    ItemMenu(
        name: "Đổi mật khẩu", icon: Icons.change_circle, route: "/changepass"),
    ItemMenu(name: "Quên mật khẩu", icon: Icons.vpn_key, route: "/forgotpass"),
    ItemMenu(name: "Đăng xuất", icon: Icons.logout, route: "/publish/post")
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Row(
      children: [
        (JwtPayload.sub == null)
            ? Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                constraints: const BoxConstraints(minWidth: 120),
                child: FilledButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 66, 133, 244)) ),
                  onPressed: () =>  appRouter.go('/login'),
                  child: const Text("Đăng Nhập",
                      style: TextStyle(color: Colors.white),
                      softWrap: false,
                      maxLines: 1),
                ),
              )
            : widgetSignIn()
      ],
    );
  }

  Widget widgetSignIn() => Row(
        children: [
          MenuAnchor(
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: UserAvatar(
                        imageUrl: JwtPayload.avatarUrl ?? '', size: 32)),
                iconSize: 32,
                splashRadius: 16,
                tooltip: 'Profiler',
              );
            },
            menuChildren: List<MenuItemButton>.generate(
              profilerMenu.length,
              (int index) => MenuItemButton(
                  onPressed: () =>
                      {GoRouter.of(context).go(profilerMenu[index].route)},
                  child: Row(
                    children: [
                      Icon(profilerMenu[index].icon),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(profilerMenu[index].name)
                    ],
                  )),
            ),
          ),
        ],
      );
}
  

