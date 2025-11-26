import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_service/utils/date_util.dart';
import 'package:quick_service/utils/loader.dart';
import '../models/provider_model.dart';
import 'dart:math';

class BookingController extends GetxController {
  final ProviderModel provider;

  BookingController(this.provider);

  // Dates (next 7 days)
  var selectedDate = DateTime.now().obs;

  List<DateTime> get weekDates {
    return List.generate(7, (i) => DateTime.now().add(Duration(days: i)));
  }

  // Time slots
  final timeSlots = [
    "9:00 AM",
    "11:00 AM",
    "1:00 PM",
    "3:00 PM",
    "5:00 PM",
    "7:00 PM",
  ];

  // Random unavailable slots
  late List<String> unavailableSlots;

  var selectedTime = ''.obs;

  // Duration
  var selectedDuration = 1.obs;

  @override
  void onInit() {
    super.onInit();
    unavailableSlots = _generateUnavailableSlots();
  }

  List<String> _generateUnavailableSlots() {
    final rnd = Random();
    final list = [...timeSlots]..shuffle();
    return list.take(2 + rnd.nextInt(2)).toList(); // 2–3 slots unavailable
  }

  // Price
  double get totalPrice => provider.hourlyRate * selectedDuration.value;

  bool get isReadyToBook =>
      selectedTime.isNotEmpty && selectedDate.value != null;

  Future<void> confirmBooking() async {
    // Show loader
    Get.dialog(const Center(child: ColorLoader3()), barrierDismissible: false);

    // Simulate processing time
    await Future.delayed(const Duration(seconds: 1));

    Get.back();

    // Show success dialog
    Get.dialog(
      AlertDialog(
        title: const Text("Booking Confirmed"),
        content: Text(
          "${provider.name}\n"
          "${formatDate(selectedDate.value)}\n"
          "${selectedTime.value}\n"
          "${selectedDuration.value} hour(s)\n"
          "Total: \$${totalPrice.toStringAsFixed(0)}",
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("OK")),
        ],
      ),
    );
  }
}
