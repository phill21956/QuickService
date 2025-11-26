import 'package:get/get.dart';
import '../models/provider_model.dart';
import 'dart:math';

class BookingController extends GetxController {
  final ProviderModel provider;

  BookingController(this.provider);

  // Dates (next 7 days)
  var selectedDate = DateTime.now().obs;

  List<DateTime> get weekDates {
    return List.generate(
      7,
      (i) => DateTime.now().add(Duration(days: i)),
    );
  }

  // Time slots
  final timeSlots = [
    "9:00 AM",
    "11:00 AM",
    "1:00 PM",
    "3:00 PM",
    "5:00 PM",
    "7:00 PM"
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
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
