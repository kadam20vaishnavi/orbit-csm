// Top-level response model
class OpentaskResModel {
  final int status;
  final String message;
  final List<TaskStatusData> data;

  OpentaskResModel 
({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OpentaskResModel.fromJson(Map<String, dynamic> json) {
    return OpentaskResModel 
     (
      status: json['status'] as int,
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((item) => TaskStatusData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

// Model for each status section ("All", "Open", "Close", "OnHold")
class TaskStatusData {
  final String status;
  final List<TaskItem> data;
  final int count;
  final String? intskstId; // Nullable since it's null in some cases

  TaskStatusData({
    required this.status,
    required this.data,
    required this.count,
    this.intskstId,
  });

  factory TaskStatusData.fromJson(Map<String, dynamic> json) {
    return TaskStatusData(
      status: json['status'] as String,
      data: (json['data'] as List)
          .map((item) => TaskItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int,
      intskstId: json['intskst_id'] as String?,
    );
  }
}

// Model for individual task items
class TaskItem {
  final String tsktitle;
  final String? tasktype; // Nullable
  final String? substatus; // Nullable
  final String tskdetail;
  final String intskId;
  final String assignedengineer;
  final String intskstId;
  final String tskstatus;
  final String inidId;
  final String created;
  final bool escalate;
  final String eventloc;
  final String custName;
  final String contactName;
  final String? busiPh; // Nullable
  final String mobno;
  final String? prefix; // Nullable
  final String casePrefix;
  final bool? checkIn; // Nullable
  final List<dynamic> daysworked; // Empty arrays in JSON, keeping as dynamic

  TaskItem({
    required this.tsktitle,
    this.tasktype,
    this.substatus,
    required this.tskdetail,
    required this.intskId,
    required this.assignedengineer,
    required this.intskstId,
    required this.tskstatus,
    required this.inidId,
    required this.created,
    required this.escalate,
    required this.eventloc,
    required this.custName,
    required this.contactName,
    this.busiPh,
    required this.mobno,
    this.prefix,
    required this.casePrefix,
    this.checkIn,
    required this.daysworked,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      tsktitle: json['tsktitle'] as String,
      tasktype: json['tasktype'] as String?,
      substatus: json['substatus'] as String?,
      tskdetail: json['tskdetail'] as String,
      intskId: json['intsk_id'] as String,
      assignedengineer: json['assignedengineer'] as String,
      intskstId: json['intskst_id'] as String,
      tskstatus: json['tskstatus'] as String,
      inidId: json['inid_id'] as String,
      created: json['created'] as String,
      escalate: json['escalate'] as bool,
      eventloc: json['eventloc'] as String,
      custName: json['cust_name'] as String,
      contactName: json['contact_name'] as String,
      busiPh: json['busi_ph'] as String?,
      mobno: json['mobno'] as String,
      prefix: json['prefix'] as String?,
      casePrefix: json['case_prefix'] as String,
      checkIn: json['check_in'] as bool?,
      daysworked: json['daysworked'] as List<dynamic>,
    );
  }

  factory TaskItem.dummy(int index) => TaskItem(
    tsktitle: 'Task $index',
    tasktype: null,
    substatus: 'Action Case',
    tskdetail: 'Detail $index',
    intskId: '56983$index',
    assignedengineer: 'AT engineer',
    intskstId: '1001',
    tskstatus: index % 2 == 0 ? 'Open' : 'Closed',
    inidId: '55873$index',
    created: '29-07-2024',
    escalate: false,
    eventloc: 'Pune, Maharashtra',
    custName: 'Customer $index',
    contactName: 'Contact $index',
    busiPh: null,
    mobno: '9987647252',
    prefix: 'T2024/$index/56983$index',
    casePrefix: 'C2024/55873$index',
    checkIn: false,
    daysworked: [],
  );
}