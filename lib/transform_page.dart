import 'dart:math';

import 'package:flutter/material.dart';

class TransformPage extends StatefulWidget {
  const TransformPage({Key? key}) : super(key: key);

  @override
  State<TransformPage> createState() => _TransformPageState();
}

class _TransformPageState extends State<TransformPage> {
  double rotate = 0;
  double positionX = 150;
  double positionY = 300;

  double theta = 0;

  double wheelchairWidth = 40;

  void turn() {}

  void move({required double left, required double right}) {
    double direction = 0;

    if ((left > 0 && right < 0) || (left < 0 && right > 0)) {
      double rotateDiff = 0;
      if (left > right) {
        if (left > right.abs()) {
          rotateDiff = right.abs();
        } else {
          rotateDiff = left;
        }

        left -= rotateDiff;
        right += rotateDiff;
        direction = 1;
      } else {
        if (right > left) {
          if (right > left.abs()) {
            rotateDiff = left.abs();
          } else {
            rotateDiff = right;
          }
        }

        right -= rotateDiff;
        left += rotateDiff;
        direction = -1;
      }

      double rotationTheta =
          (rotateDiff * 360) / (2 * pi * wheelchairWidth) * direction;
      this.theta += rotationTheta;
      setState(() {
        rotate += rotationTheta;
      });
    }

    double diff = left - right;
    diff = diff.abs();

    double remain = left > right ? left - diff : right - diff;
    direction = left > right ? 1 : -1;

    double positive = 1;

    if (left < 0 || right < 0) {
      positive = -1;
    }

    straight(remain, positive);

    double theta = (diff * 360) / (2 * pi * wheelchairWidth) * direction;

    rotateTheta(theta);
  }

  void rotateTheta(double theta) async {
    // double rotationTheta = (diff * 360) / (2 * pi * wheelchairWidth);

    this.theta += theta;

    // theta += rotationTheta;
    print("global theta ${this.theta}");
    print("theta $theta");

    double offsetX =
        (wheelchairWidth - cos(theta * (pi / 180)) * wheelchairWidth) / 2;
    double offsetY = (wheelchairWidth * sin(theta * (pi / 180))) / 2;

    //?????? offset ?????? ????????? ??????
    // double test1 = rotationOffsetX * cos(theta * (pi / 180)) -
    //     rotationOffsetY * sin(theta * (pi / 180));
    // double test2 = rotationOffsetX * sin(theta * (pi / 180)) +
    //     rotationOffsetY * cos(theta * (pi / 180));

    print("x = $offsetX");
    print("y = $offsetY");

    double rotationOffsetX = offsetX * cos(-(this.theta - theta) * (pi / 180)) -
        offsetY * sin(-(this.theta - theta) * (pi / 180));
    double rotationOffsetY = offsetX * sin(-(this.theta - theta) * (pi / 180)) +
        offsetY * cos(-(this.theta - theta) * (pi / 180));

    print("rotationOffsetX = $rotationOffsetX");
    print("rotationOffsetY = $rotationOffsetY");

    double offsetRotate = theta / (2 * pi);
    //?????? ????????? X ?????? ???????????? Y?????? ?????????
    //????????? ????????? X?????? ????????? Y?????? ????????????

    if (theta > 0) {
      positionX += rotationOffsetX;
      positionY -= rotationOffsetY;
    } else {
      positionX -= rotationOffsetX;
      positionY += rotationOffsetY;
    }
    setState(() {
      // positionX -= rotationOffsetX;
      // positionY += rotationOffsetY;
      rotate = this.theta;
    });
  }

  void straight(double diff, double direction) async {
    if (diff == 0) return;
    diff = diff.abs();

    double offsetX =
        cos((90 - theta) * (pi / 180)) * (wheelchairWidth / 2 + diff);
    double offsetY =
        sin((90 - theta) * (pi / 180)) * (wheelchairWidth / 2 + diff);

    setState(() {
      positionX += (offsetX * direction);
      positionY -= (offsetY * direction);
    });
  }

  void calculate(double left, double right) async {
    double diff = 0;

    if (left > right)
      diff = right;
    else
      diff = left;

    //diff?????? ???????????? ????????? y?????? ?????????
    //????????? ?????? theta??? ???????????? ????????? x,y ???????????? ???????????????.

    double offsetX = 0;
    double offsetY = 0;
    if (diff > 0) {
      print(sin((90 - theta) * (pi / 180)));
      print(cos((90 - theta) * (pi / 180)));
      print(cos(90));
      print(cos(90 * (pi / 180)));
      offsetX = cos((90 - theta) * (pi / 180)) * (wheelchairWidth / 2 + diff);
      offsetY = sin((90 - theta) * (pi / 180)) * (wheelchairWidth / 2 + diff);

      print("?????? ?????? positionX = $offsetX");
      print("?????? ?????? positionY = $offsetY");
      setState(() {
        positionX += offsetX;
        positionY -= offsetY;
      });
    }

    // await Future.delayed(Duration(seconds: 2));
    //?????? ??????
    if (left > right)
      diff = left - diff;
    else
      diff = right - diff;

    if (right > left) diff = -diff;

    double rotationTheta = (diff * 360) / (2 * pi * wheelchairWidth);

    theta += rotationTheta;
    print(theta);
    print(rotationTheta);
    print(cos(theta * (pi / 180)));
    print("cos 60 = ${cos(60 * (pi / 180))}");

    double rotationOffsetX =
        (wheelchairWidth - cos(rotationTheta * (pi / 180)) * wheelchairWidth) /
            2;
    double rotationOffsetY =
        (wheelchairWidth * sin(rotationTheta * (pi / 180))) / 2;

    //?????? offset ?????? ????????? ??????
    double test1 = rotationOffsetX * cos(theta * (pi / 180)) -
        rotationOffsetY * sin(theta * (pi / 180));
    double test2 = rotationOffsetX * sin(theta * (pi / 180)) +
        rotationOffsetY * cos(theta * (pi / 180));

    print(test1);
    print(test2);

    if (right > left) {
      offsetX -= rotationOffsetX;
      offsetY -= rotationOffsetY;
    } else {
      offsetX += rotationOffsetX;
      offsetY += rotationOffsetY;
    }

    print("x = $offsetX");
    print("y = $offsetY");

    double offsetRotate = theta / (2 * pi);
    setState(() {
      positionX += offsetX;
      positionY -= offsetY;
      rotate = theta;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    print(rotate);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Stack(
              children: [
                AnimatedPositioned(
                    top: positionY,
                    left: positionX,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedRotation(
                      turns: rotate / 360,
                      // turns: 1,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: Stack(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 10,
                                height: 10,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            )),
            Container(
              height: 200,
              child: Column(
                children: [
                  Text("Rotate = ${rotate.toStringAsFixed(3)}"),
                  TextButton(
                      onPressed: () async {
                        move(left: 3, right: 2);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: -3, right: 3);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 2, right: 0);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 2, right: 0);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 2, right: 0);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 2, right: 0);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 2, right: 0);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 2, right: 0);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 2, right: 0);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 2, right: 0);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 2, right: 0);
                        await Future.delayed(Duration(milliseconds: 150));
                        move(left: 2, right: 0);
                      },
                      child: Text("Dance! ")),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            move(left: 15, right: -15);
                          },
                          child: Text("?????????(?????????) ")),
                      TextButton(
                          onPressed: () async {
                            move(left: 15, right: 0);
                          },
                          child: Text("?????????")),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            move(left: -15, right: 15);
                          },
                          child: Text("?????????(?????????) ")),
                      TextButton(
                          onPressed: () async {
                            move(left: 0, right: 15);
                          },
                          child: Text("?????????")),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            move(left: 15, right: 15);
                          },
                          child: Text("??????")),
                      TextButton(
                          onPressed: () async {
                            move(left: -15, right: -15);
                          },
                          child: Text("??????")),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
