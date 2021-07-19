import 'package:flutter/material.dart';

import 'emojis.dart';

class EmotionKeyboard extends StatefulWidget {
  final double height;
  final EdgeInsets padding;
  final void Function(String emoji) onSelect;
  EmotionKeyboard({
    Key? key,
    this.height = 248,
    this.padding = const EdgeInsets.all(10),
    required this.onSelect,
  }) : super(key: key);
  @override
  _EmotionKeyboardState createState() => _EmotionKeyboardState();
}

class _EmotionKeyboardState extends State<EmotionKeyboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Function(void Function())? setList;
  List<Map<String, String>> _emojiGroups = [
    smileys,
    animals,
    foods,
    travel,
    activities,
    objects,
    symbols,
    flags,
  ];
  List<String> _icons = [
    smileys.values.first,
    animals.values.first,
    foods.values.first,
    travel.values.first,
    activities.values.first,
    objects.values.first,
    symbols.values.first,
    flags.values.first,
  ];

  updateList() {
    if (setList != null) setList!(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _emojiGroups.length, vsync: this);
    _tabController.addListener(updateList);
  }

  @override
  void dispose() {
    _tabController.removeListener(updateList);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Material(
        child: Column(
          children: [
            StatefulBuilder(
              builder: (context, setstate) {
                setList = setstate;
                return SizedBox(
                  height: 48,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final selected = _tabController.index == index;
                      return MaterialButton(
                        elevation: 0,
                        color: selected ? Colors.black12 : null,
                        onPressed: () {
                          _tabController.animateTo(index);
                        },
                        minWidth: 40,
                        child: Center(
                          child: Text(_icons[index]),
                        ),
                      );
                    },
                    itemCount: _icons.length,
                  ),
                );
              },
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _emojiGroups
                    .map((e) => _EmotionView(
                          emojis: e,
                          padding: widget.padding,
                          onSelect: widget.onSelect,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmotionView extends StatelessWidget {
  final Map<String, String> emojis;
  final EdgeInsets padding;
  final void Function(String emoji) onSelect;
  const _EmotionView({
    Key? key,
    required this.emojis,
    this.padding = const EdgeInsets.all(10),
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 40,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final text = emojis.values.toList()[index];
        return InkWell(
          onTap: () => onSelect(text),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        );
      },
      itemCount: emojis.length,
    );
  }
}
