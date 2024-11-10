// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'theme.dart';

class Reading extends StatelessWidget {
  const Reading({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor(context),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Center(
                child: Image.asset(
                  'assets/signs/Libra.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Libra',
                style: CupertinoTheme.of(context)
                    .textTheme
                    .navTitleTextStyle
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '23.Oct- 22.Nov',
                style: CupertinoTheme.of(context)
                    .textTheme
                    .navTitleTextStyle
                    .copyWith(color: CupertinoColors.systemGrey),
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              CupertinoFormSection(
                header: Text('Lucky Numbers'),
                children: [
                  CupertinoFormRow(
                    child: Text('5, 7 and 3'),
                  ),
                ],
              ),
              CupertinoFormSection(
                header: Text('Unlucky Numbers'),
                children: [
                  CupertinoFormRow(
                    child: Text('9 and 1'),
                  ),
                ],
              ),
              CupertinoFormSection(
                header: Text('Lucky Colour'),
                children: [
                  CupertinoFormRow(
                    child: Text('Red and Blue'),
                  ),
                ],
              ),
              CupertinoFormSection(
                header: Text('Unlucky Colour'),
                children: [
                  CupertinoFormRow(
                    child: Text('Black'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
