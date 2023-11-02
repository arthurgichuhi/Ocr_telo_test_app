import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocr_app/screens/scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 164, 167, 173),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      const Text(
                        'Jane Atieno',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const Icon(Icons.person_4_rounded)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Text(
                'Menus',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScreenButtons(
                      name: 'Scan Meter',
                      description: '20 Meters To Go',
                      voidCallback: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScanScreen(),
                          )),
                      icon: Icons.qr_code_scanner,
                      color: const Color(0xff2b4196)),
                  ScreenButtons(
                      name: 'Scanned',
                      description: '55 Meters',
                      voidCallback: () {},
                      icon: CupertinoIcons.checkmark,
                      color: const Color(0XFF2B962F))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScreenButtons(
                      name: 'Notifications',
                      description: '3 Unread',
                      voidCallback: () {},
                      icon: Icons.notifications_none_outlined,
                      color: const Color(0XFF742B96)),
                  ScreenButtons(
                      name: 'History',
                      description: '300 Scans',
                      voidCallback: () {},
                      icon: Icons.monitor_heart_outlined,
                      color: const Color(0XFF2B7C96))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScreenButtons extends StatelessWidget {
  const ScreenButtons(
      {super.key,
      required this.name,
      required this.description,
      required this.voidCallback,
      required this.icon,
      required this.color});
  final String name;
  final String description;
  final VoidCallback voidCallback;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => voidCallback(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * .38,
            minHeight: MediaQuery.of(context).size.width * .38),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: color),
              child: Icon(
                icon,
                size: 35,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 10),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
