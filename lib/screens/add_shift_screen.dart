import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/shifts.dart';
import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/shared/constants.dart';
// import 'package:sqflite/sqflite.dart';

class AddShiftScreen extends StatefulWidget {
  static const routeName = '/add-shift';

  @override
  _AddShiftScreenState createState() => _AddShiftScreenState();
}

//typedef String OnTap();

class Entry {
  final String docId;
  String title;
  final IconData icon;
  final List<Entry> children;
  final Function onTap;
  String selectedValue;
  bool onlyAdminAllowed;
  TextFormField formField;

  Entry(
    this.title, [
    this.icon,
    this.children = const <Entry>[],
    this.onTap,
    this.selectedValue,
    this.docId,
    this.onlyAdminAllowed = false,
    this.formField,
  ]);
}

class EntryItem extends StatefulWidget {
  const EntryItem(this.entry);
  final Entry entry;

  @override
  _EntryItemState createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {
  Entry selectedEntry;
  String rootTitle;
  int index = 0;

  Widget _buildTiles(Entry root, Entry parent) {
    if (root.children.isEmpty) {
      return ListTile(
          leading: root.icon != null ? Icon(root.icon) : null,
          title: Text(root.selectedValue?.toString() ?? root.title),
          onTap: () async {
            if (parent != null) {
              setState(() {
                // root.title = parent;
                selectedEntry = root;
                rootTitle = selectedEntry.title;
                index++;
                parent.selectedValue = selectedEntry.title;
              });
            } else {
              if (rootTitle == 'Date') {
                final DateTime date = await root.onTap(
                    context: context,
                    initialDate: DateTime.now().add(Duration(seconds: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025));

                if (date == null)
                  setState(() {
                    selectedEntry =
                        root; //makes it so user can change date once clicked off.
                  });

                setState(() {
                  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
                  //root.title = dateFormat.format(date);
                  root.selectedValue = dateFormat.format(date);
                });
              } else if (rootTitle == 'Time') {
                final TimeOfDay tod = await root.onTap(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (tod == null)
                  setState(() {
                    selectedEntry = root;
                  });

                setState(() {
                  //root.title = tod.format(context);
                  root.selectedValue = tod.format(context);
                });
              } else if (rootTitle == 'Break') {
                final TimeOfDay tod = await root.onTap(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (tod == null)
                  setState(() {
                    selectedEntry = root;
                  });

                setState(() {
                  //root.title = tod.format(context);
                  root.selectedValue = tod.format(context);
                });
              } else if (rootTitle == 'Add Notes') {
                final String notes = await root.onTap(
                  context,
                );

                setState(() {
                  //root.title = tod.format(context);
                  root.selectedValue = notes;
                });
              }
            }
          });
    }
    return ExpansionTile(
      leading: Icon(root.icon),
      key: ValueKey<String>('${root.title}$index'),
      title: Text(rootTitle),
      onExpansionChanged: (isExpanding) {
        if (isExpanding && rootTitle != root.title) {
          setState(() {
            rootTitle = root.title;
          });
        }
      },
      children:
          root.children.map<Widget>((Entry e) => _buildTiles(e, root)).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    rootTitle = widget.entry.title;
  }

  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return _buildTiles(widget.entry, null);
  }
}

class _AddShiftScreenState extends State<AddShiftScreen> {
  TextEditingController _titleController;

  final List<Entry> data = <Entry>[
    Entry(
      'Area',
      Icons.card_travel,
      <Entry>[
        Entry(
          'Reception',
        ),
        Entry(
          'IT Department',
        ),
        Entry(
          'HR Department',
        ),
      ],
    ),
    Entry(
      'Date',
      Icons.calendar_today,
      const <Entry>[],
      showDatePicker,
    ),
    Entry(
      'Time',
      Icons.schedule,
      <Entry>[],
      showTimePicker,
    ),
    Entry(
      'Break',
      Icons.local_dining,
      <Entry>[],
      showTimePicker,
    ),
    Entry(
      'Add Employee',
      Icons.person_add,
      <Entry>[Entry('Open Shift'), Entry('[Employee Names Here]')],
      null, null, null, true
    ),
    Entry(
      'Add Notes',
      Icons.note_add,
      <Entry>[],
      showNotesText,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final allowedEntries = isAdmin
        ? data
        : data.where((element) => element.onlyAdminAllowed == false).toList();

    print(
        'allowedEntries: ${allowedEntries.fold("", (previousValue, element) => previousValue + element.title + " ")}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Shift'),
      ),
      body: ListView.separated(
        itemCount: allowedEntries.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) => EntryItem(
          allowedEntries[index],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RaisedButton(
        child: Text(
          'Confirm Shift',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          //TO DO:
          print('Confirm Shift Button Pressed');
          Navigator.of(context).pop();
          final Map<String, dynamic> shiftData = {};
          allowedEntries.forEach((element) {
            if (element.selectedValue != null) {
              shiftData[element.title] = element.selectedValue;
            }
          });
          final User user = await DBService().getCurrentUserDetails();

          shiftData.addEntries(user.toMap().entries);
          shiftData["isApproved"] = getShiftStatusValue(ShiftStatus.none);

          // shiftData["firstname"] =

          await Firestore.instance.collection("shift").add(shiftData);
        },
        color: Theme.of(context).accentColor,
      ),

      // Column(
      //   children: <Widget>[
      //     ExpansionTile(
      //       leading: Icon(Icons.card_travel),
      //       title: Text('Area'),
      //     ),
      //     Divider(),
      //     ExpansionTile(
      //       leading: Icon(Icons.calendar_today),
      //       title: Text('Date'),
      //     ),
      //     Divider(),
      //     ExpansionTile(
      //       leading: Icon(Icons.access_time),
      //       title: Text('Area'),
      //     ),
      //     Divider(),
      //     ExpansionTile(
      //       leading: Icon(Icons.chat),
      //       title: Text('Notes'),
      //     ),
      //     Divider(),
    );
  }

  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    DBService()
        .getCurrentUserDetails()
        .then((value) {
          print('here: ${value.toString()}');
          return value;
        })
        .then((user) => user.isAdmin)
        .then((value) {
          print('isAdmin=> $value');
          if (value) {
            print('value : $value');
            this.isAdmin = true;
            setState(() {});
          }
        });
  }
}

class NotesTextField extends StatefulWidget {
  final Function textListener;
  NotesTextField({this.textListener});
  @override
  _NotesTextFieldState createState() => _NotesTextFieldState();
}

class _NotesTextFieldState extends State<NotesTextField> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 350,
          child: TextField(
            decoration: textInputDecoration.copyWith(hintText: 'Enter notes'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: _controller,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.removeListener(_onTextChanged);
    _controller.toString();
  }

  void _onTextChanged() {
    widget.textListener(_controller.text);
  }
}

Future<String> showNotesText(BuildContext context) async {
  String text = "";
  final textListener = (String value) {
    text = value;
  };
  await showModalBottomSheet(
      context: context,
      builder: (context) {
        return NotesTextField(
          textListener: textListener,
        );
      });

  return text;
}
