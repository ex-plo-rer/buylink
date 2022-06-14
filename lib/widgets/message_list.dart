// import 'package:flutter/material.dart';
//
// import '../core/constants/colors.dart';
//
// class MessageList extends StatelessWidget {
//   const MessageList({Key? key}) : super(key: key);
//
//   final int itemCount;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.all(4),
//       itemCount: itemCount,
//       itemBuilder: (context, index) => ListTile(
//         title: Text(
//           'Deji',
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: const CircleAvatar(
//           backgroundColor: AppColors.shade1,
//           child: Text('DE'),
//           radius: 24,
//         ),
//         subtitle:
//         const Text("Good evening i wanted to ask if you... "),
//         trailing: Column(
//           children: const <Widget>[
//             SizedBox(height: 6),
//             CircleAvatar(
//               backgroundColor: AppColors.primaryColor,
//               child: Text(
//                 '1',
//                 style: TextStyle(fontSize: 12),
//               ),
//               radius: 10,
//             ),
//             Text(
//               "6 Nov",
//               style: TextStyle(fontSize: 12),
//             ),
//           ],
//         ),
//         onTap: () {
//           ref.read(navigationServiceProvider).navigateToNamed(
//             Routes.messageView,
//             arguments: MessageModel(
//               id: 7,
//               storeId: id,
//               name: 'store.name',
//               imageUrl: AppStrings.ronaldo,
//               fromUser: false,
//             ),
//           );
//         },
//       )
//       separatorBuilder: (_, __) => const Spacing.smallHeight(),
//     );
//   }
// }
