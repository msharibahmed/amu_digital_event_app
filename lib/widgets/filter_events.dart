import 'package:amui_digital_event_app/providers/https.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterEvents extends StatefulWidget {
  @override
  _FilterEventsState createState() => _FilterEventsState();
}

class _FilterEventsState extends State<FilterEvents> {
  var _value1 = 1;
  var _value2 = 1;
  var _value3 = 1;
  var facNames = [
    {0: 'hello'},
    {1: 'world'},
    {2: 'whatsup'}
  ];
  var depNames = [
    {0: 'no'},
    {1: 'why'},
    {2: 'there'},
    {3: 'love'}
  ];
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Https>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: [
          const Text('Filter Events',
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Radio(
                value: 1,
                groupValue: _value3,
                onChanged: (value) {
                  setState(() {
                    _value3 = value;
                  });
                  data.changeSortEvent('All',0);
                },
              ),
              const Text('All'),
              const SizedBox(
                width: 8,
              ),
              Radio(
                value: 2,
                groupValue: _value3,
                onChanged: (value) {
                  setState(() {
                    _value3 = value;
                  });
                },
              ),
              const Text('by faculty'),
              const SizedBox(
                width: 8,
              ),
              Radio(
                value: 3,
                groupValue: _value3,
                onChanged: (value) {
                  setState(() {
                    _value3 = value;
                  });
                },
              ),
              const Text('by department'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_value3 == 2)
                DropdownButton(
                  icon: const Icon(Icons.sort_rounded, color: Colors.black),
                  elevation: 16,
                  isDense: true,
                  value: _value1,
                  dropdownColor: Colors.indigo[200],
                  onChanged: (value) {
                    setState(() {
                      _value1 = value;
                    });
                  },
                  items: facNames
                      .map(
                        (name) => DropdownMenuItem(
                          child: Text(name.values.toList()[0]),
                          value: name.keys.toList()[0],
                          onTap: () {
                            data.changeSortEvent(name.values.toList()[0],1);
                          },
                        ),
                      )
                      .toList(),
                  hint: const Text('by faculty',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20)),
                ),
              if (_value3 == 3)
                DropdownButton(
                    icon: const Icon(Icons.sort_rounded, color: Colors.black),
                    elevation: 16,
                    isDense: true,
                    value: _value2,
                    dropdownColor: Colors.indigo[200],
                    onChanged: (value) {
                      setState(() {
                        _value2 = value;
                      });
                    },
                    items: depNames
                        .map(
                          (name) => DropdownMenuItem(
                            child: Text(name.values.toList()[0]),
                            value: name.keys.toList()[0],
                            onTap: () {
                              data.changeSortEvent(name.values.toList()[0],2);
                            },
                          ),
                        )
                        .toList(),
                    hint: const Text('by department',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20)))
            ],
          )
        ],
      ),
    );
  }
}
