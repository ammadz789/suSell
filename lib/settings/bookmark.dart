import 'package:flutter/material.dart';


class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  _favoriteState createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My favorites'),
        backgroundColor: Colors.black,
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


class order extends StatefulWidget {
  const order({Key? key}) : super(key: key);

  @override
  _orderState createState() => _orderState();
}

class _orderState extends State<order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My orders'),
        backgroundColor: Colors.black,
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


