import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

enum ShiftStatus {
  none,
  denied,
  approved,
}

String getShiftStatusValue(ShiftStatus shiftStatus) {
  if (shiftStatus == ShiftStatus.none)
    return "none";
  else if (shiftStatus == ShiftStatus.approved)
    return "approved";
  else
    return "denied";
}

ShiftStatus parseShiftStatus(String shiftStatus) {
  if (shiftStatus == "none" || shiftStatus == null) {
    return ShiftStatus.none;
  } else if (shiftStatus == "approved") {
    return ShiftStatus.approved;
  } else {
    return ShiftStatus.denied;
  }
}

class Shift {
  final String shiftId;
  final String uid;
  final String firstName;
  final String lastName;

  final String date;
  final String time;
  final String area;
  final String notes;
  final String break_;
  final ShiftStatus isApproved;

  Shift({
    this.shiftId,
    this.uid,
    this.firstName,
    this.lastName,
    this.date,
    this.time,
    this.area,
    this.notes,
    this.break_,
    this.isApproved = ShiftStatus.none,
  
  });

  Map<String, dynamic> toMap() {
    return {
      'shiftId': shiftId,
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'Date': date,
      'Time': time,
      'Area': area,
      'Break': break_,
      "Add Notes" : notes,
      "isApproved": getShiftStatusValue(isApproved),
    };
  }

  static Shift fromDoc(DocumentSnapshot map) {
    if (map == null) return null;
    return Shift(
      shiftId: map.documentID,
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      date: map['Date'],
      time: map['Time'],
      area: map['Area'],
      break_: map['Break'],
      notes: map['Add Notes'],
      isApproved: parseShiftStatus(map['isApproved']),
    );
  }

  static Shift fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Shift(
      shiftId: map['shiftId'],
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      date: map['Date'],
      time: map['Time'],
      area: map['Area'],
      notes: map['Add Notes'],
      break_: map['Break'],
      isApproved: parseShiftStatus(map['isApproved']),
    );
  }

  String toJson() => json.encode(toMap());

  static Shift fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Shift(shiftId: $shiftId, uid: $uid, firstName: $firstName, lastName: $lastName,}';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Shift &&
        o.shiftId == shiftId &&
        o.uid == uid &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.area == area &&
        o.date == date &&
        o.notes == notes &&
        o.time == time &&
        o.isApproved == isApproved &&
        o.break_ == break_;
  }

  @override
  int get hashCode {
    return shiftId.hashCode ^
        uid.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        isApproved.hashCode ^
        date.hashCode ^
        notes.hashCode ^
        time.hashCode ^
        area.hashCode ^
        break_.hashCode;
  }

  Shift copyWith({ShiftStatus shiftStatus}) {
    return Shift(
        uid: uid,
        area: area,
        break_: break_,
        date: date,
        firstName: firstName,
        isApproved: shiftStatus,
        lastName: lastName,
        notes: notes,
        shiftId: shiftId,
        time: time);
  }
}
