import 'package:flutter/material.dart';

class card extends StatefulWidget {
  const card({Key? key}) : super(key: key);

  @override
  _cardState createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My card'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt),),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5,
                child: InkWell(
                  splashColor: Colors.red.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: Row(
                    children: [

                      Column(
                        children: [
                          Image.asset(
                            'lib/images/book.jpg',
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Book'),
                        ],
                      ),
                      SizedBox(width: 150,),
                      Column(

                        children: [
                          Text('60 TL'),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.close, size: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: InkWell(
                  splashColor: Colors.red.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: Row(
                    children: [

                      Column(
                        children: [
                          Image.asset(
                            'lib/images/book.jpg',
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Book'),
                        ],
                      ),
                      SizedBox(width: 150,),
                      Column(

                        children: [
                          Text('60 TL'),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.close, size: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: InkWell(
                  splashColor: Colors.red.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: Row(
                    children: [

                      Column(
                        children: [
                          Image.asset(
                            'lib/images/book.jpg',
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Book'),
                        ],
                      ),
                      SizedBox(width: 150,),
                      Column(

                        children: [
                          Text('60 TL'),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.close, size: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: InkWell(
                  splashColor: Colors.red.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: Row(
                    children: [

                      Column(
                        children: [
                          Image.asset(
                            'lib/images/book.jpg',
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Book'),
                        ],
                      ),
                      SizedBox(width: 150,),
                      Column(

                        children: [
                          Text('60 TL'),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.close, size: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: InkWell(
                  splashColor: Colors.red.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: Row(
                    children: [

                      Column(
                        children: [
                          Image.asset(
                            'lib/images/book.jpg',
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Book'),
                        ],
                      ),
                      SizedBox(width: 150,),
                      Column(

                        children: [
                          Text('60 TL'),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.close, size: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
