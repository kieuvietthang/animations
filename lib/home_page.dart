import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:untitled6/custom_poly_line.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = false;
  bool _isSelected = false;
  bool _isDiscover = false;
  bool _isDiscover1 = false;
  bool _isDiscover2 = false;
  bool isAnimation = false;
  double progress = 0.0;
  late Timer timer;
  bool isBVisible = false;
  bool isADimmed = false;
  bool isMap = false;

  final Offset startPoint = Offset(50, 650);
  final Offset endPoint = Offset(300, 450);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/image/img_bgr_map.jpeg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: isMap
            ? Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      size: const Size(300, 500),
                      painter: DashedLinePainter(
                        startPoint: startPoint,
                        endPoint: endPoint,
                        progress: progress,
                      ),
                    ),
                  ),
                  Positioned(
                    left: startPoint.dx - 25,
                    top: startPoint.dy - 25,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: isADimmed
                          ? Image.asset('assets/image/img_home_disconnect.png')
                          : Image.asset('assets/image/img_home.png'),
                    ),
                  ),
                  if (isBVisible)
                    Positioned(
                      left: endPoint.dx - 25,
                      top: endPoint.dy - 25,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/image/img_school.png'),
                      ),
                    ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    top: _isSelected ? 60 : -200,
                    left: 10,
                    right: 10,
                    child: Container(
                      height: 70,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '8:30',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "Trẻ con đã đi tới trường",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    bottom: _isSelected ? 30 : -100,
                    left: 25,
                    right: 25,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSelected = false;
                          _isDiscover = true;
                          _isDiscover1 = true;
                        });
                      },
                      child: Container(
                        height: screenSize.height * 0.06,
                        width: screenSize.width * 0.78,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "Tiếp tục",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    top: _isDiscover1 ? 60 : -200,
                    left: 10,
                    right: 10,
                    child: Container(
                      height: 70,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        color: const Color(0xFFAD4DE5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Text(
                        'Bạn băn khoăn không biết con mình có dán mắt vào điện thoại trong lớp không?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    bottom: _isDiscover ? 30 : -100,
                    left: 25,
                    right: 25,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDiscover = false;
                          _isDiscover2 = true;
                          Future.delayed(const Duration(milliseconds: 200), () {
                            setState(() {
                              isAnimation = true;
                            });
                          });
                        });
                      },
                      child: Container(
                        height: screenSize.height * 0.06,
                        width: screenSize.width * 0.78,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "Khám phá",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    top: _isDiscover2 ? 60 + 80 : -200,
                    left: 10,
                    right: 10,
                    child: Container(
                        height: screenSize.height * 0.28,
                        width: screenSize.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: isAnimation
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      LinearPercentIndicator(
                                        barRadius: const Radius.circular(5),
                                        animation: true,
                                        animationDuration: 2000,
                                        lineHeight: 50,
                                        percent: 0.65,
                                        backgroundColor: Colors.white,
                                        linearGradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF97C3DA),
                                            Color(0xFFFFC8E4)
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        left: 20,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/image/ic_tiktok.svg',
                                              width: 40,
                                              height: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 15,
                                         right: 30,
                                        child: Text(
                                          '46p',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF7C7A7A),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Stack(
                                    children: [
                                      LinearPercentIndicator(
                                        barRadius: const Radius.circular(5),
                                        animation: true,
                                        animationDuration: 2000,
                                        lineHeight: 50,
                                        percent: 0.48,
                                        backgroundColor: Colors.white,
                                        linearGradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF97C3DA),
                                            Color(0xFFFFC8E4)
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        left: 20,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/image/ic_facebook.svg',
                                              width: 40,
                                              height: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 15,
                                        right: 30,
                                        child: Text(
                                          '31p',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF7C7A7A),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Stack(
                                    children: [
                                      LinearPercentIndicator(
                                        barRadius: const Radius.circular(5),
                                        animation: true,
                                        animationDuration: 2000,
                                        lineHeight: 50,
                                        percent: 1,
                                        backgroundColor: Colors.white,
                                        linearGradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF97C3DA),
                                            Color(0xFFFFC8E4)
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        left: 20,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/image/ic_youtube.svg',
                                              width: 40,
                                              height: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 15,
                                        right: 30,
                                        child: Text(
                                          '1g 23p',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFFFE5B5B),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Container()),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    bottom: _isDiscover2 ? 30 : -100,
                    left: 25,
                    right: 25,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDiscover2 = false;
                          _isDiscover1 = false;
                        });
                      },
                      child: Container(
                        height: screenSize.height * 0.06,
                        width: screenSize.width * 0.78,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "Tiếp tục",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    bottom: _isVisible ? screenSize.height / 2 - 50 : -200,
                    left: 10,
                    right: 10,
                    child: Container(
                      height: screenSize.height * 0.22,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Xin chào, tôi là Pingo!",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Hãy để tôi chỉ cho banj biết cách ứng dụng này hoạt động. Cho phép Findmykids theo dõi hoạt động của bạn",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    bottom: _isVisible ? 30 : -100,
                    left: 25,
                    right: 25,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                          isMap = true;
                          if (isMap == true) {
                            timer = Timer.periodic(Duration(milliseconds: 50),
                                (timer) {
                              setState(() {
                                progress += 0.01; // Tăng dần độ dài đã vẽ

                                // Hiển thị điểm B khi vẽ được nửa đoạn
                                if (progress >= 0.5 && !isBVisible) {
                                  isBVisible = true; // Hiện điểm B
                                }

                                // Đổi màu điểm A sau khi điểm B hiển thị
                                if (isBVisible) {
                                  isADimmed = true; // Đổi màu điểm A
                                }

                                if (progress >= 1.0) {
                                  progress = 1.0; // Đặt lại giá trị progress
                                  timer.cancel();
                                  _isSelected = true;
                                }
                              });
                            });
                          }
                        });
                      },
                      child: Container(
                        height: screenSize.height * 0.06,
                        width: screenSize.width * 0.78,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "Bắt đầu",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
