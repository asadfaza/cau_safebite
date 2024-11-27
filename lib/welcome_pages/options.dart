import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class PageForChoose extends StatefulWidget {
  final String title;
  final Widget center;
  final bool isReligious;
  final List<String> options;

  // Constructor to accept parameters
  const PageForChoose({
    required this.title,
    required this.center,
    required this.options,
    required this.isReligious,
    Key? key,
  }) : super(key: key);
  @override
  State<PageForChoose> createState() => _PageForChooseState();
}

class _PageForChooseState extends State<PageForChoose> {
  List<String> selectedItems = [];
  String selectedReligious = 'Islam';
  void toggleSelection(String option, List<String> selectedOptions) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  List<Widget> rIconOptions = [
    Icon(Icons.church),
    Icon(Icons.mosque),
    Icon(Icons.synagogue),
    Icon(Icons.temple_buddhist),
    Icon(Icons.temple_hindu),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              widget.isReligious
                  ? Navigator.pop(context, selectedReligious)
                  : Navigator.pop(context, selectedItems);
            },
            icon: Icon(
              Icons.arrow_back_ios,
            )),
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: bColor,
        title: Text(
          widget.title,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 48,
                margin: EdgeInsets.only(
                    bottom: 20,
                    left: screenSize.width * 0.1,
                    right: screenSize.width * 0.1),
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                height: screenSize.height * 0.5,
                width: screenSize.width * 0.8,
                child: widget.isReligious
                    ? options(widget.options, rIconOptions, selectedReligious)
                    : MultiSelectContainer(
                        itemsDecoration: MultiSelectDecorations(
                            selectedDecoration: BoxDecoration(
                                color: Colors.blue.shade300,
                                border: Border.all(color: Colors.blue.shade300),
                                borderRadius: BorderRadius.circular(30)),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(30))),
                        alignments: MultiSelectAlignments(
                            mainAxisAlignment: MainAxisAlignment.spaceAround),
                        items: widget.options
                            .map((option) =>
                                MultiSelectCard(value: option, label: option))
                            .toList(),
                        onChange: (all, selected) {
                          toggleSelection(selected, selectedItems);
                        },
                      ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.1, right: screenSize.width * 0.1),
            margin: EdgeInsets.only(bottom: 40),
            alignment: Alignment.bottomCenter,
            child: TextButton(
                style: buttonStyle(screenSize.width, Color(0xffA3CFF3)),
                onPressed: () {
                  widget.isReligious
                      ? Navigator.pop(context, selectedReligious)
                      : Navigator.pop(context, selectedItems);
                },
                child: Text('Save')),
          )
        ],
      ),
    );
  }

  Widget options(
          List<String> options, List<Widget> imageOptions, selectedOptions) =>
      ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedReligious = option;
              });
            },
            child: Container(
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 2,
                    color: selectedReligious == option
                        ? Colors.blue.shade300
                        : Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 5),
                      imageOptions[index],
                      SizedBox(width: 10),
                      Text(
                        option,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
}
