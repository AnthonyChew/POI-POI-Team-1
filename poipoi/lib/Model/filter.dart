import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String? type;
  bool freshfruits=false;
  bool wholegrains=false;
  bool lowfatdairy=false;
  bool teamSports = false;
  bool indSports= false;
  bool dualSports=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200],
      appBar: AppBar(
        title: Text('FILTER', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'NotoSans',letterSpacing:2.0,)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children:[

          Column(
            children:[
              new Container(
                //color: Colors.grey[300],
                height: 180,
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                child:Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text('Type',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[600],
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RadioListTile(
                        title: Text('Healthy Food'),
                        value: "healthy food",
                        groupValue: type,
                        onChanged: (value){
                          print("$value");
                          setState((){
                            type = value as String?;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Sports'),
                        value: "sports",
                        groupValue: type,
                        onChanged: (value){
                          print("$value");
                          setState((){
                            type = value as String?;
                          });
                        },),
                    ],),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow:[
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius:10,
                      offset: Offset(4,8),
                    ),
                  ],
                ),
              ),
              new Visibility(
                visible: type=="healthy food",
                child:Column(
                  children:[
                    Container(
                      height: 230,
                      width: double.infinity,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius:10,
                            offset: Offset(4,8),
                          ),
                        ],
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text('Type of Healthy Foods',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text("Fresh Fruits"),
                              checkColor: Colors.black,
                              activeColor:Colors.blue,
                              value: freshfruits,
                              onChanged:(freshfruits) {
                                setState(() {
                                  freshfruits = true;
                                });
                              },),
                            CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text("Whole Grains"),
                              checkColor: Colors.black,
                              activeColor:Colors.blue,
                              value: wholegrains,
                              onChanged:(wholegrains) {
                                setState(() {
                                  wholegrains = true;
                                });
                              },),
                            CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text("Low Fat Dairy"),
                              checkColor: Colors.black,
                              activeColor:Colors.blue,
                              value:lowfatdairy,
                              onChanged:(lowfatdairy) {
                                setState(() {
                                  lowfatdairy = true;
                                });
                              },),
                          ],),),
                    ),
                  ],
                ),
              ),

              //sports options
              Visibility(
                visible: type=="sports",
                child:Container(
                  height: 230,
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow:[
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius:10,
                        offset: Offset(4,8),
                      ),
                    ],
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text('Type of Sports',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600],
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text("Team Sports"),
                          checkColor: Colors.black,
                          activeColor:Colors.blue,
                          value: teamSports,
                          onChanged:(teamSports) {
                            setState(() {
                              teamSports = true;
                            });
                          },),

                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text("Dual Sports"),
                          checkColor: Colors.black,
                          activeColor:Colors.blue,
                          value: dualSports,
                          onChanged:(dualSports) {
                            setState(() {
                              dualSports = true;
                            });
                          },),
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text("Individual Sports"),
                          checkColor: Colors.black,
                          activeColor:Colors.blue,
                          value:indSports,
                          onChanged:(indSports) {
                            setState(() {
                              indSports = true;
                            });
                          },),
                      ],),),
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }
}


