import 'package:core_functionality/core_functionality.dart';
import 'package:flutter/material.dart';
import 'package:shared_ui/src/forms/drop_down_list.dart/drop_down_list_search.dart';

/// A callback function that is invoked when items are selected
typedef ItemSelectionCallBack<T> = void Function(List<SelectedListItem<T>> selectedItems);

/// A function type definition for building a widget for a specific list item
typedef ListItemBuilder<T> = Widget Function(int index, SelectedListItem<T> dataItem);

/// A function type definition for searching through a list of items based on the user's query
typedef SearchDelegate<T> = List<SelectedListItem<T>> Function(String query, List<SelectedListItem<T>> dataItems);

/// A function type definition for handling notifications from a draggable bottom sheet
typedef BottomSheetListener = bool Function(DraggableScrollableNotification draggableScrollableNotification);

/// A generic and customizable dropdown widget with support for single and multiple selections,
/// a searchable list, and advanced configuration options
///
/// The `DropDown` widget provides a flexible way to display a list of items
/// in a bottom sheet with optional features such as search, select all, and
/// multiple selection
class DropDown<T> {
  /// The list of generic data items to be displayed in the dropdown
  final List<SelectedListItem<T>> data;

  /// A callback function triggered when items are selected from the list
  final ItemSelectionCallBack<T>? onSelected;

  /// A function that takes an [index] and [dataItem] as a parameter and returns a custom widget
  /// to display for the list item at that index
  final ListItemBuilder<T>? listItemBuilder;

  /// Enables single or multiple selection for the drop down list items
  /// Set to `true` to allow multiple items to be selected at once
  ///
  /// Default Value: [false]
  final bool enableMultiSelect;

  /// The maximum number of items that can be selected when [enableMultiSelect] is true
  final int? maxSelectedItems;

  /// A callback function triggered when the maximum selection limit is reached
  ///
  /// This callback is called when the number of selected items exceeds or reaches
  /// the value specified by [maxSelectedItems]
  final VoidCallback? onMaxSelectionReached;

  /// The padding applied to the `ListView` that contains the dropdown items
  ///
  /// If not provided (i.e., null), [EdgeInsets.zero] will be applied
  final EdgeInsets? listViewPadding;

  /// The widget used as a separator between items in the dropdown list
  ///
  /// This can be any widget, such as a `Divider` or `SizedBox`
  ///
  /// If not provided (i.e., null), a default `Divider` with a color of
  /// [Colors.black12] and a height of 0 will be applied
  final Widget? listViewSeparatorWidget;

  final Widget? emptyListWidget;

  /// The padding applied to the content of each `ListTile` in the dropdown list
  ///
  /// If not provided (i.e., null), the default padding of
  /// [EdgeInsets.symmetric(horizontal: 20)] will be applied
  final EdgeInsets? listTileContentPadding;

  /// Defines the background color of each `ListTile` in the dropdown list
  /// Default Value: [Colors.transparent]
  final Color listTileColor;

  /// The widget displayed as a trailing icon when a list item is selected
  ///
  /// This is used only when [enableMultiSelect] is true
  ///
  /// Default Value: [Icon(Icons.check_box)]
  final Widget selectedTrailing;

  /// The widget displayed as a trailing icon when a list item is not selected
  ///
  /// This is used only when [enableMultiSelect] is true
  ///
  /// Default Value: [Icon(Icons.check_box_outline_blank)]
  final Widget deSelectedTrailing;

  /// Specifies whether a modal bottom sheet should be displayed using the root navigator
  ///
  /// Default Value: [false]
  final bool useRootNavigator;

  /// Specifies whether the bottom sheet can be dragged up and down and dismissed by swiping downwards
  ///
  /// Default Value: [true]
  final bool enableDrag;

  /// Specifies whether the bottom sheet will be dismissed when the user taps on the scrim
  ///
  /// Default Value: [true]
  final bool isDismissible;

  /// The initial fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: [0.7]
  final double initialChildSize;

  /// The minimum fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: [0.3]
  final double minChildSize;

  /// The maximum fractional value of the parent container's height to use when
  /// displaying the [DropDown] widget in [DraggableScrollableSheet]
  ///
  /// Default Value: [0.9]
  final double maxChildSize;

  /// A listener that monitors events bubbling up from the BottomSheet
  ///
  /// The [bottomSheetListener] is triggered with a [DraggableScrollableNotification]
  /// when changes occur in the BottomSheet's draggable scrollable area
  final BottomSheetListener? bottomSheetListener;

  /// Sets the background color of the dropdown
  ///
  /// Default Value: [Colors.transparent]
  final Color dropDownBackgroundColor;

  /// The padding applied to the dropdown container
  ///
  /// If not provided (i.e., null), the default value will be
  /// [EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom)]
  final EdgeInsets? dropDownPadding;

  /// The padding applied to the dropdown header
  ///
  /// If not provided (i.e., null), the default value will be
  /// [EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0)]
  final EdgeInsets? headerPadding;

  /// The widget displayed as the title of the bottom sheet
  /// This allows customization of the title content
  ///
  /// If not provided, no title will be displayed
  final Widget? sheetTitle;

  /// Specifies the text displayed on the submit button when [enableMultiSelect] is true
  ///
  /// This is only used if a custom [submitButtonChild] widget is not provided
  ///
  /// Default Value: [Submit]
  final String submitButtonText;

  /// Specifies the text displayed on the clear button when [enableMultiSelect] is true
  ///
  /// This is only used if a custom [clearButtonChild] widget is not provided
  ///
  /// Default Value: [Clear]
  final String clearButtonText;

  /// Controls the visibility of the search widget
  ///
  /// Default Value: [true], The widget will be visible by default
  /// Set to [false] to hide the widget
  final bool showSearch;

  /// The padding applied to the search text field
  ///
  /// If not provided (i.e., null), the default value will be
  /// [EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)]
  final EdgeInsets? searchPadding;

  /// Specifies the text displayed on the search widget as hint text
  ///
  /// Default Value: [Search]
  final String searchHintText;

  /// This is the fill color for the input field
  ///
  /// Default Value: [Colors.black12]
  final Color searchFillColor;

  /// This is the cursor color for the input field
  ///
  /// Default Value: [Colors.black]
  final Color searchCursorColor;

  /// A delegate used to configure the custom search functionality in the dropdown
  final SearchDelegate<T>? searchDelegate;

  DropDown({
    Key? key,
    required this.data,
    this.onSelected,
    this.listItemBuilder,
    this.enableMultiSelect = false,
    this.maxSelectedItems,
    this.onMaxSelectionReached,
    this.listViewPadding,
    this.listViewSeparatorWidget,
    this.emptyListWidget,
    this.listTileContentPadding,
    this.listTileColor = Colors.transparent,
    this.selectedTrailing = const Icon(Icons.check_box),
    this.deSelectedTrailing = const Icon(Icons.check_box_outline_blank),
    this.useRootNavigator = false,
    this.enableDrag = true,
    this.isDismissible = true,
    this.initialChildSize = 0.7,
    this.minChildSize = 0.3,
    this.maxChildSize = 0.9,
    this.bottomSheetListener,
    this.dropDownBackgroundColor = Colors.transparent,
    this.dropDownPadding,
    this.headerPadding,
    this.sheetTitle,
    this.submitButtonText = 'Submit',
    this.clearButtonText = 'Clear',
    this.showSearch = true,
    this.searchPadding,
    this.searchHintText = 'Search',
    this.searchFillColor = Colors.black12,
    this.searchCursorColor = Colors.black,
    this.searchDelegate,
  });
}

/// Manages the state and behavior of a dropdown
/// This includes configuring and displaying a modal bottom sheet containing the dropdown items
class DropDownState<T> {
  /// The `DropDown` configuration object that defines the behavior, appearance,
  /// and other properties of the dropdown menu
  final DropDown<T> dropDown;

  /// The shape of the bottom sheet
  ///
  /// If not provided (i.e., null), the default value will be
  /// [RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)))]
  final ShapeBorder? shapeBorder;

  DropDownState({required this.dropDown, this.shapeBorder});

  /// Displays the dropdown menu as a modal bottom sheet
  ///
  /// [context] is the BuildContext used to display the modal bottom sheet
  ///
  /// This method uses the configurations defined in the `dropDown` object
  Future<List<T>> showModal(BuildContext context) async {
    final result = await showModalBottomSheet<List<T>>(
      useRootNavigator: dropDown.useRootNavigator,
      isScrollControlled: true,
      enableDrag: dropDown.enableDrag,
      isDismissible: dropDown.isDismissible,
      shape:
          shapeBorder ?? const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return _MainBody<T>(dropDown: dropDown);
          },
        );
      },
    );
    return result ?? [];
  }
}

/// This is main class to display the bottom sheet body
class _MainBody<T> extends StatefulWidget {
  /// The `DropDown` configuration object that defines the behavior, appearance,
  /// and other properties of the dropdown menu
  final DropDown<T> dropDown;

  const _MainBody({required this.dropDown, super.key});

  @override
  State<_MainBody<T>> createState() => _MainBodyState<T>();
}

class _MainBodyState<T> extends State<_MainBody<T>> {
  /// This list will set when the list of data is not available
  List<SelectedListItem<T>> mainList = [];

  @override
  void initState() {
    super.initState();
    mainList = widget.dropDown.data;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) onSubmitButtonPressed();
      },
      canPop: false,
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: widget.dropDown.bottomSheetListener,
        child: DraggableScrollableSheet(
          initialChildSize: widget.dropDown.initialChildSize,
          minChildSize: widget.dropDown.minChildSize,
          maxChildSize: widget.dropDown.maxChildSize,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: widget.dropDown.dropDownBackgroundColor,
              padding:
                  widget.dropDown.dropDownPadding ?? EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: widget.dropDown.headerPadding ?? const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Bottom sheet title text
                        if (widget.dropDown.sheetTitle != null) Expanded(child: widget.dropDown.sheetTitle!),
                      ],
                    ),
                  ),

                  /// A [TextField] that displays a list of suggestions as the user types with clear button.
                  if (widget.dropDown.showSearch)
                    Padding(
                      padding: widget.dropDown.searchPadding ?? Pads.sym(20, 10),
                      child: SearchTextField(
                        onTextChanged: _buildSearchList,
                        searchHintText: widget.dropDown.searchHintText,
                        searchFillColor: widget.dropDown.searchFillColor,
                        searchCursorColor: widget.dropDown.searchCursorColor,
                      ),
                    ),

                  if (mainList.isEmpty) widget.dropDown.emptyListWidget ?? const Text('No Data Found'),

                  /// ListView (list of data with check box for multiple selection & on tile tap single selection)
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: mainList.length,
                      padding: widget.dropDown.listViewPadding ?? EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final bool isSelected = mainList[index].isSelected;
                        return Material(
                          color: Colors.transparent,
                          clipBehavior: Clip.hardEdge,
                          child: ListTile(
                            onTap: () {
                              if (widget.dropDown.enableMultiSelect) {
                                if (!isSelected && widget.dropDown.maxSelectedItems != null) {
                                  if (mainList.where((e) => e.isSelected).length >= widget.dropDown.maxSelectedItems!) {
                                    widget.dropDown.onMaxSelectionReached?.call();
                                    return;
                                  }
                                }
                                setState(() {
                                  mainList[index].isSelected = !isSelected;
                                });
                              } else {
                                widget.dropDown.onSelected?.call([mainList[index]]);
                                _onUnFocusKeyboardAndPop([mainList[index].data]);
                              }
                            },
                            title:
                                widget.dropDown.listItemBuilder?.call(index, mainList[index]) ??
                                Text(mainList[index].data.toString()),
                            trailing: widget.dropDown.enableMultiSelect
                                ? (isSelected ? widget.dropDown.selectedTrailing : widget.dropDown.deSelectedTrailing)
                                : (isSelected ? widget.dropDown.selectedTrailing : const SizedBox.shrink()),
                            contentPadding:
                                widget.dropDown.listTileContentPadding ?? const EdgeInsets.symmetric(horizontal: 20),
                            tileColor: widget.dropDown.listTileColor,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => getSeparatorWidget,
                    ),
                  ),

                  if (widget.dropDown.enableMultiSelect)
                    Padding(
                      padding: Pads.sm('lr'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: Insets.med,
                        children: [
                          /// Clear Button
                          Expanded(
                            child: OutlinedButton(
                              onPressed: onClearButtonPressed,
                              child: Text(widget.dropDown.clearButtonText),
                            ),
                          ),

                          /// Submit Button
                          Expanded(
                            child: FilledButton(
                              onPressed: onSubmitButtonPressed,
                              child: Text(widget.dropDown.submitButtonText),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget get getSeparatorWidget =>
      widget.dropDown.listViewSeparatorWidget ?? const Divider(color: Colors.black12, height: 0);

  /// Handle the submit button pressed
  void onSubmitButtonPressed() {
    final List<SelectedListItem<T>> selectedList = widget.dropDown.data.where((e) => e.isSelected).toList();
    widget.dropDown.onSelected?.call(selectedList);
    _onUnFocusKeyboardAndPop(selectedList.map((e) => e.data).toList());
  }

  /// Handle the clear button pressed
  void onClearButtonPressed() {
    for (final element in mainList) {
      element.isSelected = false;
    }
    setState(() {});
    onSubmitButtonPressed();
  }

  /// This helps when search enabled & show the filtered data in list.
  void _buildSearchList(String userSearchTerm) {
    final results =
        widget.dropDown.searchDelegate?.call(userSearchTerm, widget.dropDown.data) ??
        widget.dropDown.data
            .where((e) => e.data.toString().toLowerCase().contains(userSearchTerm.toLowerCase()))
            .toList();

    if (userSearchTerm.isEmpty) {
      mainList = widget.dropDown.data;
    } else {
      mainList = results;
    }
    setState(() {});
  }

  /// This helps to UnFocus the keyboard & pop from the bottom sheet.
  void _onUnFocusKeyboardAndPop(List<T>? result) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop(result);
  }
}
