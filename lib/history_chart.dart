import 'package:dart_test/data.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class HistoryChart extends StatefulWidget {
  const HistoryChart({Key? key}) : super(key: key);

  @override
  State createState() {
    return _HistoryChartState();
  }
}

class _HistoryChartState extends State<HistoryChart> {
  final PagingController<int, Entry> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _pagingController.appendPage(
        List.generate(10, (index) => Entry.dummy()), 0);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      _pagingController.appendPage(
          List.generate(10, (index) => Entry.dummy()), pageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 177,
      width: size.width * 0.86,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: const Color(0xff80cbc4),
          borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          SizedBox(
            width: size.width * 0.65,
            child: ShaderMask(
              blendMode: BlendMode.dstOut,
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  stops: [0.9, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.transparent, Color(0xff80cbc4)],
                ).createShader(bounds);
              },
              child: PagedListView<int, Entry>(
                reverse: true,
                padding: const EdgeInsets.only(right: 15),
                scrollDirection: Axis.horizontal,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Entry>(
                  newPageProgressIndicatorBuilder: (context) => const Center(
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator()),
                  ),
                  itemBuilder: (context, item, index) =>
                      Bars(data: Entry.dummy()),
                ),
              ),
            ),
          ),
          Positioned(
              top: 63,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: size.width * 0.73,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.white,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        "Ziel",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 39,
                        ),
                        Text(
                          "MET",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "km Joggen",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class Bars extends StatelessWidget {
  final Entry data;

  const Bars({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${DateFormat("E").format(data.date)}.\n${DateFormat("dd.mm").format(data.date)}",
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints.expand(width: 55, height: 55),
              padding: const EdgeInsets.only(right: 5),
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.white),
              )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff2b9d92),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xff2b9d92).withOpacity(0.5),
                              const Color(0xff2b9d92)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0, 0.6])),
                    width: 9,
                    height: 50 * data.green / 100,
                  ),
                  const SizedBox(width: 3),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffe55cb1),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xffe55cb1).withOpacity(0.5),
                              const Color(0xffe55cb1)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0, 0.6])),
                    width: 9,
                    height: 50 * data.pink / 100,
                  ),
                  const SizedBox(width: 3),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff5b62e7),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xff5b62e7).withOpacity(0.5),
                              const Color(0xff5b62e7)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0, 0.6])),
                    width: 9,
                    height: 50 * data.blue / 100,
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                "${data.met}",
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                "${data.jogging}",
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
