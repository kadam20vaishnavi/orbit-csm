import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit_csm/ui/OpenTasks/OpenTasksResModel.dart';
import 'package:orbit_csm/ui/OpenTasks/OpenTasksViewModel.dart';
import 'package:orbit_csm/util/Constants.dart';
import 'package:orbit_csm/util/colors.dart';
import 'package:orbit_csm/util/common_methods.dart';
import 'package:orbit_csm/util/dimensions.dart';
import 'package:orbit_csm/util/preference.dart';
import 'package:provider/provider.dart';

class OpenTasksState extends StatefulWidget{
  const OpenTasksState({super.key});

  @override
  State<StatefulWidget> createState() => _OpenTasksState();
}

class _OpenTasksState extends State<OpenTasksState>{

  String _selectedFilter = 'Last 7 days'; // Default filter value
  final List<String> _filterOptions = ['Last 7 days','Last 30 days','Select Date'];
  List<TaskItem> _tasks = List.generate(10, (index) => TaskItem.dummy(index)); // Dummy data

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getOpenTask("1001", "7", "", "");
    });
  }

  void _getOpenTask(String intskst_id,String days,String startDate,String endDate) {
    final viewModel = Provider.of<OpenTasksViewModel>(context, listen: false);
    String? loginToken = Preference.getString(Constants.LOGIN_TOKEN);
    if (loginToken != null) {
      print("Open Task Api:$intskst_id,$days,$startDate,$endDate,$loginToken");
      viewModel.getOpenTasksApi(intskst_id,days,startDate,endDate,loginToken);

    } else {
      debugPrint("Login token is null.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OpenTasksViewModel(),
      child: Consumer<OpenTasksViewModel>(
        builder: (context,viewModel,child) {
          // Filter tasks based on selected spinner value
          final filteredTasks = viewModel.selectedFilter == 'Last 7 days'
              ? viewModel.tasks
              : viewModel.tasks.where((task) => task.tskstatus == viewModel.selectedFilter).toList();
          return Scaffold(
            backgroundColor: AppColors.midGray,
            appBar: AppBar(
              backgroundColor: AppColors.darkBlue,
              automaticallyImplyLeading: true, // Shows back button if there's a previous route
              title: const Center( child: Text("Open Tasks",style: TextStyle(color: AppColors.white))),
              iconTheme: const IconThemeData(
                color: Colors.white, // Sets back button color to white
              ),
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Dimensions.level2Margin(context)),
                      child: Text("Filter:"),
                    ),
                    SvgPicture.asset(
                      'assets/images/svg/ic_Search.svg',
                      width: Dimensions.largeTextSize(context),
                      height: Dimensions.largeTextSize(context),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.level2Margin(context)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.level2Margin(context)), // Padding inside dropdown
                          child: DropdownMenu<String>(
                            initialSelection: viewModel.selectedFilter,
                            dropdownMenuEntries: _filterOptions.map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              );
                            }).toList(),
                            onSelected: (String? newValue) {
                              if (newValue != null) {
                                viewModel.updateFilter(newValue); // ✅ Now using ViewModel to update state
                                if (newValue == "Select Date") {
                                  showDateRangeDialog(context);
                                }
                              }
                            },
                            textStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.grey, width: 1),
                        ),
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              _buildRow("Case ID:", "CaseID"),
                              _buildRow("Task ID:", "Task ID"),
                              Divider(color: AppColors.lightGray,thickness: 1),
                              _buildRow("Account Name:", "Account Name"),
                              _buildRow("Contact Name:", "Contact Name"),
                              _buildRow("Mobile no:", "Mobile no"),
                              _buildRow("Event Location:", "Event Location ghuidhfj hfhfhgjhjjjj hfksh fkj jfsjk jdfhsjk"),
                              Divider(color: AppColors.lightGray,thickness: 1),
                              _buildRow("Task Title:", "Priority"),
                              _buildRow("Task Details:", "Location"),
                              _buildRow("Task Type:", "Department"),
                              _buildRow("Sub-Status:", "Category"),
                              Divider(color: AppColors.lightGray,thickness: 1),
                              SizedBox(height: 12),

                              // Check-Out Button
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle check-out logic here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.darkBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text("Check-Out", style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  void showDateRangeDialog(BuildContext context) {
    DateTime? _startDate;
    DateTime? _endDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1), // Rounded corners
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Start Date Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Select Start Date",
                        style: TextStyle(fontSize: Dimensions.mediumTextSize(context),fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(), // Disable future dates
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _startDate = pickedDate;
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_today, color: Colors.blue),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _startDate == null
                            ? "Not Selected"
                            : _startDate!.toLocal().toString().split(' ')[0],
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // End Date Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Select End Date",
                        style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _startDate ?? DateTime.now(),
                            firstDate: _startDate ?? DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _endDate = pickedDate;
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_today, color: Colors.blue),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _endDate == null
                            ? "Not Selected"
                            : _endDate!.toLocal().toString().split(' ')[0],
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      //_getOpenTask("1001","0",_startDate.toString(),_endDate.toString());
                      if (_startDate != null && _endDate != null) {

                       // CommonMethods.convertDate(_startDate, Constants.inputFormatPattern1, Constants.outputFormatPattern6);

                        _getOpenTask("1001","0",_startDate.toString(),_endDate.toString());
                        Navigator.pop(context, {"startDate": _startDate, "endDate": _endDate});
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select both dates")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Set background color to blue
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Remove curve (square corners)
                      ),
                    ),
                    child: const Text("OK",style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Helper function to create each row
  Widget _buildRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            textAlign: TextAlign.start, // Ensures text starts from the left
            title,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              maxLines: 4, // Limits the text to 4 lines
              overflow: TextOverflow.ellipsis, // Adds if text overflows
              textAlign: TextAlign.start, // Ensures text starts from the left
              style: TextStyle (color: AppColors.gray700),
            )
          ),
        ],
      ),
    );
  }
}