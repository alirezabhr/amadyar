import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../models/order.dart';

class OrderHistoryCard extends StatelessWidget {
  final Map<OrderStatus, Map<String, Object>> map = const {
    OrderStatus.DELIVERED: {
      'color': Color.fromARGB(255, 153, 241, 156),
      'text': 'تحویل داده شده'
    },
    OrderStatus.ASSIGNED: {
      'color': Color.fromARGB(255, 247, 238, 125),
      'text': 'شروع نشده'
    },
    OrderStatus.IN_PROGRESS: {
      'color': Color.fromARGB(255, 133, 235, 253),
      'text': 'در حال انجام'
    },
    OrderStatus.ARRIVED: {
      'color': Color.fromARGB(255, 253, 161, 161),
      'text': 'در حال تخلیه'
    },
  };

  final Order order;

  const OrderHistoryCard(this.order, {Key? key}) : super(key: key);

  Widget? get originAddressText {
    if (order.storage != null) {
      return Text("مبدا: ${order.storage?.address}");
    }
    return null;
  }

  Widget? get destinationAddressText {
    if (order.store != null) {
      return Text("مقصد: ${order.store!.address}");
    }
    return null;
  }

  String jalaliFormattedDate(Jalali dateTime) {
    return '${dateTime.formatter.wN}، ${dateTime.formatter.d} ${dateTime
        .formatter.mN}';
  }

  String formattedTime(Jalali dateTime) {
    return 'ساعت ${dateTime.hour}:${dateTime.minute}';
  }

  Widget timingColumn(String title, Jalali dateTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
              '${jalaliFormattedDate(dateTime)} - ${formattedTime(dateTime)}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        color: map[order.status]!["color"] as Color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  originAddressText,
                  destinationAddressText,
                  Text("مرسوله: ${order.title}"),
                  order.weight != null ? Text("وزن: ${order.weight} kg") : null,
                  timingColumn('زمان پیشنهادی تحویل:', order.estimationArrival),
                  timingColumn('زمان پیشنهادی تخلیه:', order.estimationDepart),
                  // TODO add start and end real time if exist
                ]
                    .map(
                      (e) =>
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: e,
                        ),
                      ),
                )
                    .toList(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${map[order.status]!["text"]}",
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
