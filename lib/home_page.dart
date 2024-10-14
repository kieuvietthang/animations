import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled6/custom_poly_line.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = false;
  bool _isSelected = false;
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
                      size: Size(300, 500),
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
                    child: Container(
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
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/image/img_school.png'),
                      ),
                    ),
                  Positioned.fill(
                    child: AnimatedPositioned(
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('8:30'),
                            Text("Trẻ con đã đi tới trường"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      bottom: _isSelected ? 30 : -100,
                      left: 25,
                      right: 25,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSelected = false;
                          });
                        },
                        child: Container(
                          height: 70,
                          width: 200,
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
                  ),
                ],
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedPositioned(
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                  ),
                  Positioned.fill(
                    child: AnimatedPositioned(
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
                  ),
                ],
              ),
      ),
    );
  }
}
