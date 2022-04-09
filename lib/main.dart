import 'package:flutter/material.dart';

void main() {
  runApp(Convertor());
}

class Convertor extends StatefulWidget {
  @override
  State<Convertor> createState() => _ConvertorState();
}

class _ConvertorState extends State<Convertor> {
  final Map<String, int> _measuresMap = {
  'meters' : 0,
  'kilometers' : 1,
  'grams' : 2,
  'kilograms' : 3,
  'feet' : 4,
  'miles' : 5,
    'pounds (lbs)' : 6,
    'ounces' : 7,
  };
  final dynamic _formulas = {
    '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
    '1':[1000,1,0,0,3280.84,0.621371,0,0],
    '2':[0,0,1,0.001,0,0,0.00220462,0.035274],
    '3':[0,0,1000,1,0,0,2.20462,35.274],
    '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
    '5':[1609.34, 1.60934,0,0,5280,1,0,0],
    '6':[0,0,453.592,0.453592,0,0,1,16],
    '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
  };

  var _startMeasure  ;
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];
 var _resultMessage;

  var _convertmeasure;
  var _numberFrom;
  var _chosenValue;


  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from] as int;
    int nTo = _measuresMap[to] as int ;
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    }
    else {
      _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertmeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });

  }
  @override
  void initState() {

    super.initState();
  }
   final TextStyle inputStyle = TextStyle(
     fontSize: 20,
     color: Colors.blue[900],
   );
   final TextStyle labelStyle = TextStyle(
     fontSize: 24,
     color: Colors.grey[700],
   );

   Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Measures Converter'),
        ),
        body: Container(
          padding: EdgeInsets.all( 20),

          child:
        SingleChildScrollView(
          child: Column(
    children: [
      //Spacer(),
      SizedBox(height: 10,),
      Text(
          'Value',style: labelStyle,
      ),
      TextField(
        style: inputStyle,
        decoration: InputDecoration(
          hintText: "Please insert the measure to be converted",
        ),

        onChanged: (text) {
            var rv = double.tryParse(text);
            if (rv != null) {
              setState(() {
                _numberFrom = rv;


              });
            }
          },
      ),
      SizedBox.fromSize(size: Size.fromHeight(10),),
      Text(
          'From',style: labelStyle,
      ),

      SizedBox(height: 20,),
      DropdownButton<String>(
          //focusColor:Colors.white,
          value: _startMeasure,
          //elevation: 5,
       // style: TextStyle(color: Colors.white),
          //iconEnabledColor:Colors.black,
          items: <String>[
            'meters',
            'kilometers',
            'grams',
            'kilograms',
            'feet',
            'miles',
            'pounds (lbs)',
            'ounces',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style:TextStyle(color:Colors.black),),
            );
          }).toList(),
          // hint:Text(
          //   "Please choose a langauage",
          //   style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 14,
          //       fontWeight: FontWeight.w500),
          // ),
        isExpanded: true,
          onChanged: (value) {
            setState(() {
              _startMeasure = value;
            });
          },
      ),
      SizedBox.fromSize(size: Size.fromHeight(10),),
      Text(
          'To',style: labelStyle,
      ),
      SizedBox.fromSize(size: Size.fromHeight(10),),
      DropdownButton(
        isExpanded: true,
       value: _convertmeasure,
          items: _measures.map((String kvalue) {
            return DropdownMenuItem<String>(value: kvalue, child:
            Text(kvalue),);
          }).toList(),
          onChanged: (kvalue) {
            setState(() {
              _convertmeasure = kvalue.toString();
            });
          },
      ),
Icon( Icons.change_circle),
      ElevatedButton(
        child: Text('Convert', style: inputStyle),
        onPressed: () {
          if (_startMeasure.isEmpty || _convertmeasure.isEmpty ||
              _numberFrom==0) {
            return;
          }
          else {
            convert(_numberFrom, _startMeasure, _convertmeasure);
          }
        },
      ),
      Text((_resultMessage == null) ? '' : _resultMessage,
          style: labelStyle),



      //   TextField(
    // onChanged: (text) {
    // var rv = double.tryParse(text);
    // if (rv != null) {
    // setState(() {
    // _numberFrom = rv;
    //
    //
    // });
    // }
    // },
    // ),
     // Text((_numberFrom == null) ? '\n' : _numberFrom.toString())
    ],
          ),
        ),
        ),
        ),
    );
    }
}
