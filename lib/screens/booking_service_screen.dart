import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_service/controllers/booking_service_controller.dart';
import 'package:quick_service/utils/color_constants.dart';
import '../models/provider_model.dart';

class BookingScreen extends StatelessWidget {
  final ProviderModel provider;

  const BookingScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingController(provider));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Book Service",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- Provider Summary ----------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      provider.imageUrl,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              provider.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            if (provider.isVerified) ...[
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.check_circle,
                                color: ColorConstants.primaryColor,
                                size: 16,
                              ),
                            ],
                          ],
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              provider.rating.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "\$${provider.hourlyRate}/hr",
                          style: const TextStyle(
                            fontSize: 14,
                            color: ColorConstants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ---------------- Select Date ----------------
            const Text(
              "Select Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.weekDates.length,
                itemBuilder: (_, i) {
                  final date = controller.weekDates[i];

                  return Obx(() {
                    final isSelected =
                        date.day == controller.selectedDate.value.day &&
                        date.month == controller.selectedDate.value.month;

                    return GestureDetector(
                      onTap: () => controller.selectedDate.value = date,
                      child: Container(
                        width: 70,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorConstants.primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? ColorConstants.primaryColor
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _weekday(date),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${date.day}",
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            ),

            const SizedBox(height: 24),

            // ---------------- Time Slot ----------------
            const Text(
              "Select Time Slot",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.timeSlots.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (_, i) {
                final time = controller.timeSlots[i];

                return Obx(() {
                  final unavailable = controller.unavailableSlots.contains(
                    time,
                  );
                  final isSelected = controller.selectedTime.value == time;

                  return GestureDetector(
                    onTap: unavailable
                        ? null
                        : () => controller.selectedTime.value = time,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: unavailable
                            ? Colors.grey.shade300
                            : isSelected
                            ? ColorConstants.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? ColorConstants.primaryColor
                              : Colors.grey.shade400,
                        ),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: unavailable
                              ? Colors.grey.shade600
                              : isSelected
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),

            const SizedBox(height: 24),

            // ---------------- Duration ----------------
            const Text(
              "Duration",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Obx(() {
              return DropdownButtonFormField<int>(
                value: controller.selectedDuration.value,
                onChanged: (v) => controller.selectedDuration.value = v ?? 1,
                items: const [
                  DropdownMenuItem(value: 1, child: Text("1 hour")),
                  DropdownMenuItem(value: 2, child: Text("2 hours")),
                  DropdownMenuItem(value: 3, child: Text("3 hours")),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // ---------------- Total Price ----------------
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Price:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${controller.totalPrice.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 24),

            // ---------------- Confirm Button ----------------
            Obx(() {
              final enabled = controller.isReadyToBook;

              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: enabled
                      ? () async {
                          await controller.confirmBooking();

                          Get.dialog(
                            AlertDialog(
                              title: const Text("Booking Confirmed"),
                              content: Text(
                                "${provider.name}\n"
                                "${_formatDate(controller.selectedDate.value)}\n"
                                "${controller.selectedTime.value}\n"
                                "${controller.selectedDuration.value} hour(s)\n"
                                "Total: \$${controller.totalPrice.toStringAsFixed(0)}",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: enabled
                        ? ColorConstants.primaryColor
                        : Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Confirm Booking",
                    style: TextStyle(
                      color: enabled ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _weekday(DateTime date) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[date.weekday - 1];
  }

  String _formatDate(DateTime date) {
    return "${_weekday(date)} ${date.day}";
  }
}
