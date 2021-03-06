import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:touchable_opacity/touchable_opacity.dart';

void main() {
  testWidgets("Touchable Opacity renders correctly",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Text("Child Text"),
        ),
      ),
    ));

    expect(find.byKey(Key("nksystems.touchable_opacity_gesture_detector")),
        findsOneWidget);
    expect(find.text("Child Text"), findsOneWidget);
  });

  testWidgets("Touchable Opacity onTapDown works correctly",
      (WidgetTester tester) async {
    int count = 0;
    Function onTapDown = (_) {
      count++;
    };

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Text("Child Text"),
          onTapDown: onTapDown,
        ),
      ),
    ));

    await tester.tap(find.text("Child Text"));
    await tester.pump();

    expect(count, equals(1));
  });

  testWidgets("Touchable Opacity onTapUp works correctly",
      (WidgetTester tester) async {
    int count = 0;
    Function onTapUp = (_) {
      count++;
    };

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Text("Child Text"),
          onTapUp: onTapUp,
        ),
      ),
    ));

    await tester.tap(find.text("Child Text"));
    await tester.pump();

    expect(count, equals(1));
  });

  testWidgets("Touchable Opacity onTap works correctly",
      (WidgetTester tester) async {
    int count = 0;
    Function onTap = () {
      count++;
    };

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Text("Child Text"),
          onTap: onTap,
        ),
      ),
    ));

    await tester.tap(find.text("Child Text"));
    await tester.pump();

    expect(count, equals(1));
  });

  testWidgets("Touchable Opacity onTapCancel works correctly",
      (WidgetTester tester) async {
    int count = 0;
    Function onTapCancel = () {
      count++;
    };

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Text("Child Text"),
          onTapCancel: onTapCancel,
        ),
      ),
    ));

    await tester.drag(find.text("Child Text"), Offset(300, 300));
    await tester.pump();

    expect(count, equals(1));
  });

  testWidgets("Touchable Opacity onDoubleTap works correctly",
      (WidgetTester tester) async {
    int count = 0;
    Function onDoubleTap = () {
      count++;
    };

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Text("Child Text"),
          onDoubleTap: onDoubleTap,
        ),
      ),
    ));

    await tester.tap(find.text("Child Text"));
    await tester.pump(Duration(milliseconds: 50));
    await tester.tap(find.text("Child Text"));
    await tester.pump(Duration(milliseconds: 500));

    expect(count, equals(1));
  });

  testWidgets("Touchable Opacity onLongPress works correctly",
      (WidgetTester tester) async {
    int count = 0;
    Function onLongPress = () {
      count++;
    };

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Text("Child Text"),
          onLongPress: onLongPress,
        ),
      ),
    ));

    await tester.startGesture(tester.getCenter(find.text("Child Text")));
    await tester.pump(Duration(milliseconds: 500));

    expect(count, equals(1));
  });

  testWidgets("Touchable Opacity onLongPress events works correctly",
      (WidgetTester tester) async {
    bool longStartCalled = false;
    bool longMoveCalled = false;
    bool longUpCalled = false;
    bool longEndCalled = false;

    Function onLongStart = (_) {
      longStartCalled = true;
    };
    Function onLongPressMove = (_) {
      longMoveCalled = true;
    };
    Function onLongPressUp = () {
      longUpCalled = true;
    };
    Function onLongPressEnd = (_) {
      longEndCalled = true;
    };

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Text("Child Text"),
          onLongPressStart: onLongStart,
          onLongPressMoveUpdate: onLongPressMove,
          onLongPressUp: onLongPressUp,
          onLongPressEnd: onLongPressEnd,
        ),
      ),
    ));

    TestGesture gesture =
        await tester.startGesture(tester.getCenter(find.text("Child Text")));
    await tester.pump(Duration(milliseconds: 500));
    expect(longStartCalled, equals(true));
    await gesture.moveBy(Offset(2, 0));
    expect(longMoveCalled, equals(true));
    await gesture.up();
    expect(longUpCalled, equals(true));
    expect(longEndCalled, equals(true));
  });

  testWidgets("Touchable Opacity vetical events work correctly",
      (WidgetTester tester) async {
    bool downCalled = false;
    bool startCalled = false;
    bool updateCalled = false;
    bool endCalled = false;

    Function down = (_) {
      downCalled = true;
    };
    Function start = (_) {
      startCalled = true;
    };
    Function update = (_) {
      updateCalled = true;
    };
    Function end = (_) {
      endCalled = true;
    };

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Container(
            height: 30,
            width: 50,
            child: Center(child: Text("Child Text")),
          ),
          onVerticalDragDown: down,
          onVerticalDragStart: start,
          onVerticalDragUpdate: update,
          onVerticalDragEnd: end,
        ),
      ),
    ));

    TestGesture gesture =
        await tester.startGesture(tester.getCenter(find.text("Child Text")));
    expect(downCalled, equals(true));
    await gesture.moveBy(Offset(0, 20));
    expect(startCalled, equals(true));
    await gesture.moveBy(Offset(0, -20));
    expect(updateCalled, equals(true));
    await gesture.up();
    expect(endCalled, equals(true));
  });

  testWidgets("Touchable Opacity horizontal events work correctly",
      (WidgetTester tester) async {
    bool downCalled = false;
    bool startCalled = false;
    bool updateCalled = false;
    bool endCalled = false;

    Function down = (_) {
      downCalled = true;
    };
    Function start = (_) {
      startCalled = true;
    };
    Function update = (_) {
      updateCalled = true;
    };
    Function end = (_) {
      endCalled = true;
    };

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Container(
            height: 30,
            width: 50,
            child: Center(child: Text("Child Text")),
          ),
          onHorizontalDragDown: down,
          onHorizontalDragStart: start,
          onHorizontalDragUpdate: update,
          onHorizontalDragEnd: end,
        ),
      ),
    ));

    TestGesture gesture =
        await tester.startGesture(tester.getCenter(find.text("Child Text")));
    expect(downCalled, equals(true));
    await gesture.moveBy(Offset(20, 0));
    expect(startCalled, equals(true));
    await gesture.moveBy(Offset(-20, 0));
    expect(updateCalled, equals(true));
    await gesture.up();
    expect(endCalled, equals(true));
  });

  testWidgets("Touchable Opacity pan events work correctly",
      (WidgetTester tester) async {
    bool downCalled = false;
    bool startCalled = false;
    bool updateCalled = false;
    bool endCalled = false;

    Function down = (_) {
      downCalled = true;
    };
    Function start = (_) {
      startCalled = true;
    };
    Function update = (_) {
      updateCalled = true;
    };
    Function end = (_) {
      endCalled = true;
    };

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: TouchableOpacity(
          child: Container(
            height: 30,
            width: 50,
            child: Center(child: Text("Child Text")),
          ),
          onPanDown: down,
          onPanStart: start,
          onPanUpdate: update,
          onPanEnd: end,
        ),
      ),
    ));

    TestGesture gesture =
        await tester.startGesture(tester.getCenter(find.text("Child Text")));
    expect(downCalled, equals(true));
    await gesture.moveBy(Offset(0, 20));
    expect(startCalled, equals(true));
    await gesture.moveBy(Offset(0, -20));
    expect(updateCalled, equals(true));
    await gesture.up();
    expect(endCalled, equals(true));
  });
}
