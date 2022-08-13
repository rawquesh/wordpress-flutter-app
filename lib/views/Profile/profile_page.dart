import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'components/biography_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
late TabController _tabController;
int _indexTab = 0;
@override
void initState() {
  // TODO: implement initState
  super.initState();
  _tabController = TabController(length: 3, vsync: this);

}

@override
void dispose() {
  // TODO: implement dispose
  _tabController.dispose();

  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:HexColor("#006199"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),

        title: Text('About',
           style: TextStyle(
             color: Colors.white,
             fontSize: 22,
             fontFamily: 'FreightText-Book.otf'
           ),
        ),

      ),

      body:ListView(
        children: [
          TabBar(

          onTap: (value) {
    setState(() {
    _indexTab = value;
    });
    },
      controller: _tabController,

      unselectedLabelColor:
      Color.fromRGBO(169, 184, 189, 1),
      labelColor: Color.fromRGBO(50, 68, 82, 1),
          tabs: [
            Text('Biography',style: TextStyle(fontSize: 16),),
            Text('Eduction',style: TextStyle(fontSize: 16),),
            Text('Life',style: TextStyle(fontSize: 16),),
            // Text('Family'),

          ],
          ),

          IndexedStack(
            index: _indexTab,
            children: [
              // Biography
             BiographyWidget(),

              // Eduction
              Text('Eduction',
                textAlign: TextAlign.center,
              ),


              // Life
              Text('Life',
                textAlign: TextAlign.center,
              ),

            ],
          ),










        ],
    ),
      );

  }
}
