import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';


class SearchBar extends StatefulWidget {
  //ignore: prefer_const_constructors_in_immutables
  SearchBar({Key key, this.sampleListModel}) : super(key: key);
  final SampleModel sampleListModel;

  @override
  _SearchBarState createState() => _SearchBarState(sampleListModel);
}

class _SearchBarState extends State<SearchBar> with WidgetsBindingObserver {
  _SearchBarState(this.sampleListModel);
  
  final SampleModel sampleListModel;

  TextEditingController editingController = TextEditingController();

  List<ChartsBean> duplicateControlItems;

  List<SubItem> duplicateSampleItems;

  //ignore: prefer_collection_literals
  List<ChartsBean> items = List<ChartsBean>();
  Widget searchIcon = Icon(Icons.search, color: Colors.grey);
  final FocusNode _isFocus = FocusNode();
  bool isOpen = false;

  @override
  void initState() {
    duplicateControlItems = sampleListModel.searchControlItems;
    duplicateSampleItems = sampleListModel.searchSampleItems;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (_isFocus.hasFocus) {
      if (!isOpen) {
        isOpen = true;
      } else if (isOpen) {
        isOpen = false;
        _isFocus.unfocus();
      }
    }
  }

  void filterSearchResults(String query) {
    // ignore: prefer_collection_literals
    final List<ChartsBean> dummySearchControl = List<ChartsBean>();
    dummySearchControl.addAll(duplicateControlItems);

    // ignore: prefer_collection_literals
    final List<SubItem> dummySearchSamplesList = List<SubItem>();
    dummySearchSamplesList.addAll(duplicateSampleItems);

    if (query.isNotEmpty) {
      searchIcon = null;
      // ignore: prefer_collection_literals
      final List<ChartsBean> dummyControlData = List<ChartsBean>();
      for (int i = 0; i < dummySearchControl.length; i++) {
        final ChartsBean item = dummySearchControl[i];
        if (item.mtitle.toLowerCase().contains(query.toLowerCase())) {
          dummyControlData.add(item);
        }
      }
      // ignore: prefer_collection_literals
      final List<SubItem> dummySampleData = List<SubItem>();
      for (int i = 0; i < dummySearchSamplesList.length; i++) {
        final SubItem item = dummySearchSamplesList[i];
        if (item.title.toLowerCase().contains(query.toLowerCase())) {
          dummySampleData.add(item);
        }
      }

      sampleListModel.controlList.clear();
      sampleListModel.controlList.addAll(dummyControlData);
      sampleListModel.sampleList.clear();
      sampleListModel.sampleList.addAll(dummySampleData);
      // ignore: invalid_use_of_protected_member
      sampleListModel.notifyListeners();
      return;
    } else {
      searchIcon = Icon(Icons.search, color: Colors.grey);
      sampleListModel.controlList.clear();
      sampleListModel.controlList.addAll(duplicateControlItems);
      sampleListModel.sampleList.clear();
      // ignore: invalid_use_of_protected_member
      sampleListModel.notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: sampleListModel.searchBoxColor,
              borderRadius: const BorderRadius.all(Radius.circular(5.0))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Container(
              child: TextField(
                  focusNode: _isFocus,
                  onChanged: (String value) {
                    filterSearchResults(value);
                  },
                  onEditingComplete: () {
                    _isFocus.unfocus();
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelStyle:const TextStyle(fontFamily: 'MontserratMedium'),
                      hintText: 'Search',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'MontserratMedium',
                          color: Colors.grey),
                      prefixIcon: searchIcon)),
            ),
          ),
        ),
      ],
    );
  }
}
