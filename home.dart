import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:secure_random/secure_random.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/services.dart'; 
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:algolia/algolia.dart';
import './AlgoliaApplication.dart';





class HomeScreen extends StatefulWidget {
    @override
    Home createState() => Home();
}

class Home extends State < HomeScreen > {
  final Algolia _algoliaApp = AlgoliaApplication.algolia;
  String _searchTerm;

   Future<List<AlgoliaObjectSnapshot>> _operation(String input) async {
    AlgoliaQuery query = _algoliaApp.instance.index("items").search(input);
    AlgoliaQuerySnapshot querySnap = await query.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits;
    return results;
  }
Future update(List<int> cartNumbers) async {
  WriteBatch batch = FirebaseFirestore.instance.batch();

  // 1. Get all items
  // 2. Iterate through each item
  // 3. Check if cart_numers contains item
  // 4. Change quantity

  FirebaseFirestore.instance.collection("items").get().then((querySnapshot) {
    querySnapshot.docs.forEach((document) {
      if (cartNumbers.contains(int.parse(document.id))) {
        batch.update(
          document.reference, {"quantity": document.data()["quantity"] - 1});
      }
    }); 
    return batch.commit();
  });
}

    var url =
        'https://firebasestorage.googleapis.com/v0/b/posweepay.appspot.com/o/black.jpg?alt=media&token=4ca8c008-e0db-495f-9ebb-80f095fb1e5e';

    var secureRandom = SecureRandom();
      FocusNode _focus = new FocusNode();
      FocusNode _focus2 = new FocusNode();


     


    File _imageFile;
    final picker = ImagePicker();
    List < String > cart = [];
    List < int > cart_numbers = []; // ================================================================AS YOU CAN SEE CART NUMBER ARRAY IS AN INT 

    PageController _pageController = PageController(
        initialPage: 0,
    );

    String user_id = "2467046743";
    String nav = 'Home';
    String current_category;
    var checkItems;
    int items = 0;
    double itemsvalue = 0.0;
    var imagenumber;

    TextEditingController c1 = TextEditingController();
    TextEditingController c2 = TextEditingController();
    TextEditingController c3 = TextEditingController();
    TextEditingController c4 = TextEditingController();
        TextEditingController search = TextEditingController();
                TextEditingController searchtwo = TextEditingController();



    Future < void > _signInAnonymously() async {
        try {
            await FirebaseAuth.instance.signInAnonymously();
        } catch (e) {
            print(e); // TODO: show dialog with error
        }
    }

    checkCategories() {
        var docSnapshot = FirebaseFirestore.instance
            .collection('category')
            .where('id', isEqualTo: user_id.toString())
            .snapshots();
        print("found data on cloudstore " + docSnapshot.toString());

        return docSnapshot;
    }

    Future getImage() async {


        final pickedFile = await picker.getImage(source: ImageSource.gallery);

        setState(() {
            if (pickedFile != null) {
                _imageFile = File(pickedFile.path);
                print(_imageFile);
            } else {
                print('No image selected.');
            }
        });
    }
    Future upload() async {

        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("34343434343434");
        UploadTask uploadTask = ref.putFile(_imageFile);
        uploadTask.then((res) {


            print("Image Uploaded");
        });

    }



    //.snapshots();

    _onPageViewChange(int page) {
        print("Current Page: " + page.toString());

        if (page == 0) {
            setState(() {
                nav = 'Home';
            });
        } else {
            setState(() {
                nav = 'Today';
            });
        }
    }

    void _onFocusChange(){
    
    setState(() {
      searchpage = true;
      search1 = false;
      search2 = true;
        
                                                             donesearch = true;
                                                             closesearch = false;
    });
  }

    bool step1 = true;
    bool step2 = false;
    bool showbutton = false;
    bool viewproduct = true;
    bool addproduct = false;
    bool payone = true;
    bool paytwo = false;
    bool uploadimage = true;
    bool savecard = false;
    bool removeCategory = false;
    bool shimmer = true;
    bool searchpage = false;
    bool donesearch = true;
    bool closesearch = false;
    bool search1 = true;
    bool search2 = false;

    @override
    void initState() {
        super.initState();
        _signInAnonymously();
            _focus.addListener(_onFocusChange);

    }

    @override
    Widget build(BuildContext context) {
      Future.delayed(Duration(milliseconds: 15000)).then((v) {
      
    setState(() {
      shimmer= false;
    });

    });
        OverlayScreen().saveScreens({
            "addcard": CustomOverlayScreen(
                backgroundColor: Colors.transparent,
                content: ShowUpAnimation(
                    delayStart: Duration(seconds: 0),
                    animationDuration: Duration(seconds: 1),
                    direction: Direction.vertical,
                    offset: 1,
                    child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: < Widget > [
                                Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Color(0xff202022),
                                        borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: MediaQuery.of(context).size.width * 90 / 100,
                                    height: MediaQuery.of(context).size.height * 40 / 100,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: < Widget > [

                                            Container(child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: < Widget > [


                                                    Transform.scale(
                                                        scale: 0.8,
                                                        child: IconButton(
                                                            icon: Image.asset(
                                                                'assets/images/cancel.png',
                                                                width: 100,
                                                                height: 100,
                                                                color: Color(0xff90939A),
                                                            ),
                                                            onPressed: () {
                                                                OverlayScreen().pop();
                                                            },
                                                        )), Spacer()



                                                ])),




                                            Container(height:50,
                                                margin: EdgeInsets.only(
                                                    top:0),
                                                width: MediaQuery.of(context).size.width *
                                                90 /
                                                100,
                                                child: Text('Card Name',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Color(0xffB9B9BA),
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w500))),
                                            Container(height:50,
                                                width: MediaQuery.of(context).size.width *
                                                40 /
                                                100,
                                                child: TextField(
                                                    controller: c4,
                                                    decoration: InputDecoration(
                                                        counterText: "",
                                                    ),
                                                    maxLength: 25,
                                                    textAlign: TextAlign.center,
                                                    style:
                                                    TextStyle(color: Color(0xffB9B9BA)))),

                                            Visibility(
                                                visible: uploadimage,
                                                child: Bounce(
                                                    duration: Duration(milliseconds: 110),
                                                    onPressed: () {

                                                        getImage();

                                                        setState(() {




                                                        });



                                                    },
                                                    child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 3/100), decoration: BoxDecoration(
                                                            color: Color(0xff2B6FD0),


                                                            borderRadius: BorderRadius.circular(10),




                                                        ), width: MediaQuery.of(context).size.width * 40 / 100, height: MediaQuery.of(context).size.height * 5 / 100,

                                                        child: Row(

                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: < Widget > [Text("Upload Image", style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 17,
                                                                    fontWeight: FontWeight.w500))



                                                            ])




                                                    ))),

                                            Spacer(),
                                            Bounce(
                                                duration: Duration(milliseconds: 110),
                                                onPressed: () {

                                                    if (c4.text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg: "Enter Card Name",
                                                            toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.CENTER,
                                                            timeInSecForIosWeb: 1,
                                                            backgroundColor: Colors.black,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0);
                                                    } else {

                                                       // upload();
                                                        FirebaseFirestore.instance
                                                            .collection("category")
                                                            .add({
                                                                'id': user_id.toString(),
                                                                'image': 'laptop.jpg',
                                                                'title': c4.text.toString(),
                                                            }).then((value) {
                                                                c4.clear();

                                                                print(
                                                                    "================================sucess=============================================================");
                                                                print(value.documentID);

                                                                OverlayScreen().pop();
                                                                Fluttertoast.showToast(
                                                                    msg: "Card Created Successfully",
                                                                    toastLength: Toast.LENGTH_LONG,
                                                                    gravity: ToastGravity.CENTER,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.black,
                                                                    textColor: Colors.white,
                                                                    fontSize: 17.0);
                                                            });
                                                    }

                                                },
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width *
                                                    90 /
                                                    100,
                                                    child: Text("Save Card",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color(0xffB9B9BA),
                                                            fontFamily: 'Montserrat',
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w500))))
                                        ]))
                            ]))))
        });
        return Scaffold(
            backgroundColor: Color(0xff0B0B0B),
            body: Stack(children: < Widget > [
                SafeArea(
                    child:

                    /* PageIndicatorContainer( 
                        
                        
                        align: IndicatorAlign.bottom,
                        length: 2,
                        indicatorSpace: 5.0, 
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*6.5/100 + 7,),
                        indicatorColor: Colors.white, 
                        indicatorSelectorColor: Color(0xff00bdf4),
                        shape: IndicatorShape.circle(size: 6),
                        
                                      child:*/
                    PageView(
                        controller: _pageController,
                        onPageChanged: _onPageViewChange,
                        children: < Widget > [

                         
                             Container(
                                color: Color(0xff0B0B0B),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: < Widget > [


                                      Visibility( visible: search2 ,child:Center(
                                            child:
 
 
 
 Container(
                                                margin: EdgeInsets.only(top: 10),
                                                width: MediaQuery.of(context).size.width *
                                                90 /  
                                                100,
                                                height: MediaQuery.of(context).size.height *
                                                6.5 / 
                                                100,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Color(0xff323336),
                                                ),
                                                child: TextField(focusNode: _focus2, controller: searchtwo, onChanged: (val) {
                  setState(() {
                    _searchTerm = val;
                  });
                },
                                                    style: TextStyle(
                                                        color: Color(0xfffA3A3AB),
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500),
                                                    decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.only(
                                                                top: 13, left: 0),
                                                            prefixIcon: Padding(
                                                                 padding: const EdgeInsets.only(top:10.0,left:10.0,bottom:10.0),
                                                                    child: Transform.scale(
                                                                        scale: 1.8, 
                                                                        child:  IconButton(
                                                                            icon: Image.asset(
                                                                                'assets/images/back_button.png',
                                                                                width: 100,
                                                                                height: 100,
                                                                                color: Color(0xff90939A),
                                                                            ),
                                                                            onPressed: () {
                                                                                print('pressed');
                                                                                 setState(() {
                                                                 
                                                                 searchpage = false;
                                                              searchtwo.clear();
                                                              search1 = true;
                                                              search2 = false;
                                                              FocusManager.instance.primaryFocus.unfocus();
 
                                                               });
                                                                            },
                                                                        )),
                                                            ),
                                                            suffixIcon: Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                    child: Transform.scale(
                                                                        scale: 1.8,
                                                                        child: IconButton(
                                                                            icon: Image.asset(
                                                                                'assets/images/cancel.png',
                                                                                width: 100,
                                                                                height: 100,
                                                                                color: Color(0xff90939A),
                                                                            ),
                                                                            onPressed: () {
                                                                                print('pressed');
                                                                                 setState(() {
                                                                
                                                              FocusManager.instance.primaryFocus.unfocus();
 
                                                               });
                                                                            },
                                                                        ))),
                                                            border: InputBorder.none,
                                                            hintText: 'Search',
                                                            hintStyle: TextStyle(
                                                                color: Color(0xffBABABD),
                                                                fontSize: 19,
                                                                fontWeight: FontWeight.w500)),
                                                ))
                                                
                                                
                                                )),
                                        Visibility( visible: search1 ,child:Center(
                                            child: Container(
                                                margin: EdgeInsets.only(top: 10),
                                                width: MediaQuery.of(context).size.width *
                                                90 /
                                                100,
                                                height: MediaQuery.of(context).size.height *
                                                6.5 / 
                                                100,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Color(0xff323336),
                                                ),
                                                child: TextField(focusNode: _focus, controller: search,
                                                    style: TextStyle(
                                                        color: Color(0xfffA3A3AB),
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500),
                                                    decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.only(
                                                                top: 13, left: 0),
                                                            prefixIcon: Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                    child: Transform.scale(
                                                                        scale: 1.2,
                                                                        child: Image.asset(
                                                                            'assets/images/search.png',
                                                                            width: 10,
                                                                            height: 10,
                                                                            fit: BoxFit.contain,
                                                                            color: Color(0xff90939A),
                                                                        )),
                                                            ),
                                                            suffixIcon: Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                    child: Transform.scale(
                                                                        scale: 1.8,
                                                                        child: IconButton(
                                                                            icon: Image.asset(
                                                                                'assets/images/bar_code_scanner.png',
                                                                                width: 100,
                                                                                height: 100,
                                                                                color: Color(0xff90939A),
                                                                            ),
                                                                            onPressed: () {
                                                                                print('pressed');
                                                                            },
                                                                        ))),
                                                            border: InputBorder.none,
                                                            hintText: 'Search',
                                                            hintStyle: TextStyle(
                                                                color: Color(0xffBABABD),
                                                                fontSize: 19,
                                                                fontWeight: FontWeight.w500)),
                                                )))),
                                        
                                        //addhere
                                         Stack(children: < Widget > [
                                        Container(
                                            height:
                                            MediaQuery.of(context).size.height * 85 / 100,
                                            decoration: BoxDecoration(),
                                            child: Stack(children: < Widget > [
                                                Container(
                                                    color: Color(0xff0B0B0B),
                                                    height: MediaQuery.of(context).size.height *
                                                    89 /
                                                    100,
                                                    padding: EdgeInsets.only(
                                                        left:
                                                        MediaQuery.of(context).size.width *
                                                        5 /
                                                        100,
                                                        right:
                                                        MediaQuery.of(context).size.width *
                                                        5 /
                                                        100,
                                                        top: MediaQuery.of(context).size.width *
                                                        5 /
                                                        100),
                                                    child: SingleChildScrollView(
                                                        child: ConstrainedBox(
                                                            constraints: BoxConstraints(
                                                                minHeight: 1300,
                                                            ),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                                children: < Widget > [
                                                                    StreamBuilder(
                                                                        stream: checkCategories(),
                                                                        builder:
                                                                        (context, snapshot) {
                                                                            if (snapshot.hasData) {
                                                                                if (snapshot
                                                                                    .data
                                                                                    .documents
                                                                                    .isEmpty) {
                                                                                    print(
                                                                                        "noooooooooooooooooooooooooooooooooooooooooooooooooo");

                                                                                    return Text(
                                                                                        "No Data Found",
                                                                                        style: TextStyle(
                                                                                            color: Colors
                                                                                            .white));
                                                                                } else if (snapshot
                                                                                    .data
                                                                                    .documents
                                                                                    .isNotEmpty) {
                                                                                    print(
                                                                                        "yessssssssssssssssssssssssssssssssssssssssssssssssssss");

                                                                                    return GridView
                                                                                        .builder(
                                                                                            physics: ScrollPhysics(),

                                                                                            shrinkWrap: true,
                                                                                            itemCount:
                                                                                            snapshot
                                                                                            .data
                                                                                            .documents
                                                                                            .length,
                                                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                                crossAxisSpacing:
                                                                                                20,
                                                                                                mainAxisSpacing:
                                                                                                20,
                                                                                                childAspectRatio:
                                                                                                1.7,
                                                                                                crossAxisCount:
                                                                                                2),
                                                                                            itemBuilder:
                                                                                            (BuildContext context,
                                                                                                int index) {
                                                                                                checkItems = FirebaseFirestore
                                                                                                    .instance
                                                                                                    .collection(
                                                                                                        'items');

                                                                                                checkItems = checkItems..where('id',
                                                                                                    isEqualTo:
                                                                                                    user_id
                                                                                                    .toString());

                                                                                                DocumentSnapshot
                                                                                                thesnapshot =
                                                                                                    snapshot.data
                                                                                                    .docs[
                                                                                                        index];

                                                                                                url = 'https://firebasestorage.googleapis.com/v0/b/posweepay.appspot.com/o/' +
                                                                                                    thesnapshot
                                                                                                    .data()[
                                                                                                        'image']
                                                                                                    .toString() +
                                                                                                    '?alt=media';

                                                                                                return thesnapshot.data()[
                                                                                                        'use'] ==
                                                                                                    'add' ?
                                                                                                    Bounce(
                                                                                                        duration: Duration(
                                                                                                            milliseconds:
                                                                                                            110),
                                                                                                        onPressed:
                                                                                                        () {
                                                                                                            OverlayScreen()
                                                                                                                .show(
                                                                                                                    context,
                                                                                                                    identifier:
                                                                                                                    'addcard',
                                                                                                                );
                                                                                                        },
                                                                                                        child: Container(
                                                                                                            margin: EdgeInsets.only(),
                                                                                                            decoration: BoxDecoration(
                                                                                                                border: Border.all(width: 2, color: Color(0xff2B6FD0).withOpacity(0.5)),
                                                                                                                color: Color(0xff0B0B0B),
                                                                                                                borderRadius: BorderRadius.circular(5),
                                                                                                            ),
                                                                                                            child: Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                    color: Color(0xff0B0B0B),
                                                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                                                ),
                                                                                                                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 4 / 100),
                                                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: < Widget > [
                                                                                                                    Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: < Widget > [
                                                                                                                        Container(
                                                                                                                            width: MediaQuery.of(context).size.width * 6 / 100,
                                                                                                                            child: FittedBox(
                                                                                                                                child: IconButton(
                                                                                                                                    icon: Image.asset(
                                                                                                                                        'assets/images/add.png',
                                                                                                                                        color: Color(0xff2B6FD0),
                                                                                                                                    ),
                                                                                                                                    onPressed: () {
                                                                                                                                        print("pressed");
                                                                                                                                    },
                                                                                                                                ))),
                                                                                                                        Spacer(),
                                                                                                                        Container(
                                                                                                                            width: MediaQuery.of(context).size.width * 20 / 100,
                                                                                                                            child: AutoSizeText('Add Card', 
                                                                                                                                style: TextStyle(
                                                                                                                                    color: Colors.white,
                                                                                                                                    fontFamily: 'Montserrat',
                                                                                                                                    height: 1.2,
                                                                                                                                    fontSize: 14,
                                                                                                                                ),
                                                                                                                                maxLines: 2))
                                                                                                                    ]),
                                                                                                                    Spacer()
                                                                                                                ])))) :
                                                                                                    Bounce(
                                                                                                        duration: Duration(milliseconds: 110),
                                                                                                        onPressed: () {
                                                                                                            current_category =
                                                                                                                thesnapshot.data()['title'];

                                                                                                            setState(
                                                                                                                () {
                                                                                                                    if (step2 ==
                                                                                                                        true) {
                                                                                                                        showbutton = true;
                                                                                                                        step2 = false;
                                                                                                                        step1 = false;

                                                                                                                        showMaterialModalBottomSheet(
                                                                                                                            isDismissible: false,
                                                                                                                            enableDrag: false,
                                                                                                                            expand: false,
                                                                                                                            context: context,
                                                                                                                            builder: (context, scrollController) => Container(
                                                                                                                                padding: EdgeInsets.all(20),
                                                                                                                                decoration: BoxDecoration(
                                                                                                                                    color: Color(0xff202022),
                                                                                                                                ),
                                                                                                                                height: MediaQuery.of(context).size.height * 50 / 100,
                                                                                                                                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                                                    Container(
                                                                                                                                        margin: EdgeInsets.only(bottom: 20),
                                                                                                                                        width: MediaQuery.of(context).size.width,
                                                                                                                                        child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                                                            Container(width: MediaQuery.of(context).size.width * 40 / 100, child: AutoSizeText('Product', maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500))),
                                                                                                                                            Container(width: MediaQuery.of(context).size.width * 20 / 100, child: AutoSizeText('Price', maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500))),
                                                                                                                                            Container(width: MediaQuery.of(context).size.width * 15 / 100, child: AutoSizeText('Quantity', maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500))),
                                                                                                                                        ])),
                                                                                                                                    Container(
                                                                                                                                        child: StreamBuilder(
                                                                                                                                            stream: checkItems.where('category', isEqualTo: thesnapshot.data()['title'].toString()).snapshots(),
                                                                                                                                            builder: (context, snapshot) {
                                                                                                                                                if (snapshot.hasData) {
                                                                                                                                                    if (snapshot.data.documents.isEmpty) {
                                                                                                                                                        print("noooooooooooooooooooooooooooooooooooooooooooooooooo");

                                                                                                                                                        return Center();
                                                                                                                                                    } else if (snapshot.data.documents.isNotEmpty) {
                                                                                                                                                        print("yessssssssssssssssssssssssssssssssssssssssssssssssssss");

                                                                                                                                                        return Container(
                                                                                                                                                            height: MediaQuery.of(context).size.height * 20 / 100,
                                                                                                                                                            child: ListView(scrollDirection: Axis.vertical, shrinkWrap: true, children: [
                                                                                                                                                                ListView.builder(
                                                                                                                                                                    shrinkWrap: true,
                                                                                                                                                                    padding: EdgeInsets.all(0),
                                                                                                                                                                    physics: NeverScrollableScrollPhysics(),
                                                                                                                                                                    itemCount: snapshot.data.documents.length,
                                                                                                                                                                    itemBuilder: (BuildContext context, int index) {
                                                                                                                                                                        DocumentSnapshot thesnapshot = snapshot.data.docs[index];

                                                                                                                                                                        int counter = index + 1;

                                                                                                                                                                        return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                                                                                            Container(
                                                                                                                                                                                width: MediaQuery.of(context).size.width,
                                                                                                                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                                                                                                    Container(width: MediaQuery.of(context).size.width * 40 / 100, child: AutoSizeText('$counter' + '. ' + thesnapshot.data()['name'], maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500))),
                                                                                                                                                                                    Container(width: MediaQuery.of(context).size.width * 20 / 100, child: AutoSizeText(thesnapshot.data()['price'].toString(), maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500))),
                                                                                                                                                                                    Container(width: MediaQuery.of(context).size.width * 7 / 100, child: AutoSizeText(thesnapshot.data()['quantity'].toString(), maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500))),
                                                                                                                                                                                    Container(
                                                                                                                                                                                        width: MediaQuery.of(context).size.width * 10 / 100,
                                                                                                                                                                                        child: Transform.scale(
                                                                                                                                                                                            scale: 1.0,
                                                                                                                                                                                            child: IconButton(
                                                                                                                                                                                                icon: Image.asset(
                                                                                                                                                                                                    'assets/images/add.png', 
                                                                                                                                                                                                    color: Color(0xff2B6FD0),
                                                                                                                                                                                                ),
                                                                                                                                                                                                onPressed: () { 
                                                                                                                                                                                                    setState(() {
                                                                                                                                                                                                        items = items + 1;
                                                                                                                                                                                                        itemsvalue = itemsvalue + thesnapshot.data()['price'];
                                                                                                                                                                                                        print(thesnapshot.data()['name']);
                                                                                                                                                                                                        cart.add(thesnapshot.data()['name']);
                                                                                                                                                                                                        cart_numbers.add(int.parse(thesnapshot.data()['productid'])); //===============================HERE IS WHERE THE IDS ARE SENT TO CART NUMBERS ARRAY AS USER CLICKS ===============================================================
                                                                                                                                                                                                        print('Youuuuuuur ccaaaaaaaaaaaaaaaaaaaaaaarrrtttttt  ' + cart.toString());
                                                                                                                                                                                                        print('Youuuuuuur ccaaaaaaaaaaaaaaaaaaaaaaarrrtttttt  ' + cart_numbers.toString());
                                                                                                                                                                                                    });

                                                                                                                                                                                                    print("pressed");
                                                                                                                                                                                                },
                                                                                                                                                                                            ))),
                                                                                                                                                                                    Container(
                                                                                                                                                                                        width: MediaQuery.of(context).size.width * 7 / 100,
                                                                                                                                                                                        child: Transform.scale(
                                                                                                                                                                                            scale: 1.6,
                                                                                                                                                                                            child: IconButton(
                                                                                                                                                                                                icon: Image.asset(
                                                                                                                                                                                                    'assets/images/minus.png',
                                                                                                                                                                                                    color: Color(0xff2B6FD0),
                                                                                                                                                                                                ),
                                                                                                                                                                                                onPressed: () {
                                                                                                                                                                                                    setState(() {
                                                                                                                                                                                                        FirebaseFirestore.instance.collection('items').doc(thesnapshot.reference.id).delete();
                                                                                                                                                                                                        setState(() {
                                                                                                                                                                                                            snapshot.data.documents.removeAt(index);
                                                                                                                                                                                                        });
                                                                                                                                                                                                    });

                                                                                                                                                                                                    print("pressed");
                                                                                                                                                                                                },
                                                                                                                                                                                            )))
                                                                                                                                                                                ]))
                                                                                                                                                                        ]);
                                                                                                                                                                    })
                                                                                                                                                            ]));
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                                return Container();
                                                                                                                                            })),
                                                                                                                                    Bounce(
                                                                                                                                        duration: Duration(milliseconds: 110),
                                                                                                                                        onPressed: () {
                                                                                                                                            setState(() {});

                                                                                                                                            showMaterialModalBottomSheet(
                                                                                                                                                isDismissible: false,
                                                                                                                                                enableDrag: false,
                                                                                                                                                expand: false,
                                                                                                                                                context: context,
                                                                                                                                                builder: (context, scrollController) => Container(
                                                                                                                                                    padding: EdgeInsets.all(20),
                                                                                                                                                    decoration: BoxDecoration(
                                                                                                                                                        color: Color(0xff202022),
                                                                                                                                                    ),
                                                                                                                                                    height: MediaQuery.of(context).size.height * 85 / 100,
                                                                                                                                                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                                                                        Container(
                                                                                                                                                            margin: EdgeInsets.only(bottom: 20),
                                                                                                                                                            width: MediaQuery.of(context).size.width,
                                                                                                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                                                                                Container(width: MediaQuery.of(context).size.width * 30 / 100, child: AutoSizeText('Product', maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500))),
                                                                                                                                                                Container(width: MediaQuery.of(context).size.width * 30 / 100, child: AutoSizeText('Price', maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500))),
                                                                                                                                                                Container(width: MediaQuery.of(context).size.width * 15 / 100, child: AutoSizeText('Quantity', maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500))),
                                                                                                                                                                Spacer()
                                                                                                                                                            ])),
                                                                                                                                                        Container(
                                                                                                                                                            padding: EdgeInsets.only(top: 0),
                                                                                                                                                            margin: EdgeInsets.only(bottom: 0),
                                                                                                                                                            width: MediaQuery.of(context).size.width,
                                                                                                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: < Widget > [
                                                                                                                                                                Container(
                                                                                                                                                                    width: MediaQuery.of(context).size.width * 28 / 100,
                                                                                                                                                                    child: TextField(
                                                                                                                                                                        controller: c1,
                                                                                                                                                                        decoration: InputDecoration(
                                                                                                                                                                            border: OutlineInputBorder(),
                                                                                                                                                                            counterText: "",
                                                                                                                                                                        ),
                                                                                                                                                                        maxLength: 25,
                                                                                                                                                                        textAlign: TextAlign.center,
                                                                                                                                                                        style: TextStyle(color: Color(0xffB9B9BA)))),
                                                                                                                                                                Container(
                                                                                                                                                                    width: MediaQuery.of(context).size.width * 28 / 100,
                                                                                                                                                                    child: TextField(
                                                                                                                                                                        controller: c2,
                                                                                                                                                                        decoration: InputDecoration(
                                                                                                                                                                            border: OutlineInputBorder(),
                                                                                                                                                                            counterText: "",
                                                                                                                                                                        ),
                                                                                                                                                                        maxLength: 25,
                                                                                                                                                                        textAlign: TextAlign.center,
                                                                                                                                                                        style: TextStyle(color: Color(0xffB9B9BA)))),
                                                                                                                                                                Container(
                                                                                                                                                                    width: MediaQuery.of(context).size.width * 28 / 100,
                                                                                                                                                                    child: TextField(
                                                                                                                                                                        controller: c3,
                                                                                                                                                                        decoration: InputDecoration(
                                                                                                                                                                            border: OutlineInputBorder(),
                                                                                                                                                                            counterText: "",
                                                                                                                                                                        ),
                                                                                                                                                                        maxLength: 25,
                                                                                                                                                                        textAlign: TextAlign.center,
                                                                                                                                                                        style: TextStyle(color: Color(0xffB9B9BA)))),
                                                                                                                                                            ])),
                                                                                                                                                        Spacer(),
                                                                                                                                                        Bounce(
                                                                                                                                                            duration: Duration(milliseconds: 110),
                                                                                                                                                            onPressed: () {
                                                                                                                                                                setState(() {});

                                                                                                                                                                if (c1.text.isEmpty) {
                                                                                                                                                                    Fluttertoast.showToast(msg: "Enter Product Name", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
                                                                                                                                                                } else if (c2.text.isEmpty) {
                                                                                                                                                                    Fluttertoast.showToast(msg: "Enter Product Price", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
                                                                                                                                                                } else if (c3.text.isEmpty) {
                                                                                                                                                                    Fluttertoast.showToast(msg: "Enter Product Quantity", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
                                                                                                                                                                } else {
                                                                                                                                                                    var number = secureRandom.nextString(length: 15, charset: '0123456789').toString();

                                                                                                                                                                    var mynumber = int.parse(c2.text);
                                                                                                                                                                    int mynumber2 = int.parse(c3.text);

                                                                                                                                                                    DocumentReference ref = FirebaseFirestore.instance.collection("items").doc(number.toString());

                                                                                                                                                                    print('seeeeeeeeeettttttting new productoooooooooo' + mynumber2.toString());

                                                                                                                                                                    ref.set({
                                                                                                                                                                        'productid': number.toString(),
                                                                                                                                                                        'category': current_category.toString(),
                                                                                                                                                                        'id': user_id.toString(),
                                                                                                                                                                        'name': c1.text.toString(),
                                                                                                                                                                        'quantity': mynumber2,
                                                                                                                                                                        'price': mynumber,
                                                                                                                                                                    }).then((value) {
                                                                                                                                                                        c1.clear();
                                                                                                                                                                        c2.clear();
                                                                                                                                                                        c3.clear();

                                                                                                                                                                        print("================================sucess=============================================================");

                                                                                                                                                                        Navigator.of(context).pop();
                                                                                                                                                                        Fluttertoast.showToast(msg: "Product Added", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
                                                                                                                                                                    });
                                                                                                                                                                }
                                                                                                                                                            },
                                                                                                                                                            child: Container(
                                                                                                                                                                margin: EdgeInsets.only(bottom: 0),
                                                                                                                                                                decoration: BoxDecoration(
                                                                                                                                                                    color: Color(0xff2B6FD0),
                                                                                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                                                                                ),
                                                                                                                                                                width: MediaQuery.of(context).size.width * 90 / 100,
                                                                                                                                                                height: MediaQuery.of(context).size.height * 5 / 100,
                                                                                                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                                                                                    Text("Add New Product", style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 17, fontWeight: FontWeight.w500))
                                                                                                                                                                ]))),
                                                                                                                                                        Bounce(
                                                                                                                                                            duration: Duration(milliseconds: 110),
                                                                                                                                                            onPressed: () {
                                                                                                                                                                setState(() {
                                                                                                                                                                    Navigator.of(context).pop();
                                                                                                                                                                });
                                                                                                                                                            },
                                                                                                                                                            child: Container(
                                                                                                                                                                padding: EdgeInsets.only(top: 10),
                                                                                                                                                                width: MediaQuery.of(context).size.width * 90 / 100,
                                                                                                                                                                height: MediaQuery.of(context).size.height * 5 / 100,
                                                                                                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                                                                                    Text("Cancel", style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 17, fontWeight: FontWeight.w500))
                                                                                                                                                                ])))
                                                                                                                                                    ])));
                                                                                                                                        },
                                                                                                                                        child: Container(padding: EdgeInsets.only(top: 45), width: MediaQuery.of(context).size.width * 90 / 100, child: AutoSizeText('Add New Product', maxLines: 1, textAlign: TextAlign.center, style: TextStyle(color: Color(0xff2B6FD0), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500)))),
                                                                                                                                    Spacer(),
                                                                                                                                    Bounce(
                                                                                                                                        duration: Duration(milliseconds: 110),
                                                                                                                                        onPressed: () {
                                                                                                                                            setState(() {
                                                                                                                                                Navigator.of(context).pop();
                                                                                                                                                showbutton = false;
                                                                                                                                                step2 = true;
                                                                                                                                            });
                                                                                                                                        },
                                                                                                                                        child: Container(
                                                                                                                                            margin: EdgeInsets.only(bottom: 0),
                                                                                                                                            decoration: BoxDecoration(
                                                                                                                                                color: Color(0xff2B6FD0),
                                                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                                                            ),
                                                                                                                                            width: MediaQuery.of(context).size.width * 90 / 100,
                                                                                                                                            height: MediaQuery.of(context).size.height * 5 / 100,
                                                                                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                                                                Text("Done", style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 17, fontWeight: FontWeight.w500))
                                                                                                                                            ])))
                                                                                                                                ])));
                                                                                                                    }
                                                                                                                });
                                                                                                        },
                                                                                                        child: GestureDetector( onLongPress: (){
                                                                                                              print("LONG PRESSS PRESSSSSED");


                                                                                                              setState(() {
                                                                                                                removeCategory = true;
                                                                                                                HapticFeedback.lightImpact();
                                                                                                              });


                                                                                                              Future.delayed(Duration(milliseconds: 10000)).then((v) {
                                                                                                                setState(() {
                                                                                                                removeCategory = false;
                                                                                                              });
    
    });


                                                                                                        },child:Container(
                                                                                                            margin: EdgeInsets.only(),
                                                                                                            decoration: BoxDecoration(
                                                                                                                image: new DecorationImage(
                                                                                                                    image: NetworkImage(url),
                                                                                                                    fit: BoxFit.cover,
                                                                                                                ),
                                                                                                                color: Color(0xff202022),
                                                                                                                borderRadius: BorderRadius.circular(5),
                                                                                                            ),
                                                                                                            child:  Shimmer(
    duration: Duration(seconds:1), //Default value
    interval: Duration(seconds: 1), //Default value: Duration(seconds: 0)
    color: Colors.white, //Default value
    enabled: shimmer, //Default value
    direction: ShimmerDirection.fromLTRB(),  //Default Value
    child:Container(
                                                                                                                padding: EdgeInsets.all(0), 
                                                                                                                color: Color(0xff0B0B0B).withOpacity(0.7),
                                                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: < Widget > [
                                                                                                                    Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: < Widget > [
                                                                                                                        Container(  decoration: BoxDecoration(
   
  ),padding: EdgeInsets.only( bottom: MediaQuery.of(context).size.width * 4 / 100,left:MediaQuery.of(context).size.width * 4 / 100),
                                                                                                                            width: MediaQuery.of(context).size.width * 30  / 100, 
                                                                                                                            child: AutoSizeText(thesnapshot.data()['title'].toString(),
                                                                                                                                style: TextStyle(
                                                                                                                                    color: Colors.white,
                                                                                                                                    fontFamily: 'Montserrat',
                                                                                                                                    height: 1.2,
                                                                                                                                    fontSize: 16,
                                                                                                                                ),
                                                                                                                                maxLines: 2))
                                                                                                                    ]),
                                                                                                                    Spacer(),

                                                                                                                       Column(mainAxisAlignment: MainAxisAlignment.start ,crossAxisAlignment: CrossAxisAlignment.end, children: < Widget > [
                                                                                                                        Container(  width:30, height:30,  decoration: BoxDecoration(
  
  ),   child: Transform.scale(
                                                        scale: 1.6,
                                                        child:Visibility( visible:removeCategory, child: IconButton(
                                                            icon: new Image.asset(
                                                                'assets/images/cancel.png',
                                                                width: 30,
                                                                height: 25, 
                                                                color: Colors.white
                                                            ),
                                                            tooltip: 'Closes application',
                                                            onPressed: () {

                                                                      FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "category")
                                                            .doc(thesnapshot
                                                                .reference.id)
                                                            .delete();
                                                        setState(() {
                                                          snapshot
                                                              .data.documents
                                                              .removeAt(index);
                                                        });

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("items").where('category',isEqualTo:thesnapshot.data()['title'].toString() ).get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      print(result.data());
      print(result.data()['id']);
               FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "items")
                                                            .doc(result.data()['id'])
                                                            .delete();
      print("Success");
    });
  });


                                                            },
                                                        )) )     )
                                                                                                                    ])
                                                                                                                ]))))));
                                                                                            },
                                                                                        );
                                                                                }
                                                                            }
                                                                            return Container();
                                                                        })
                                                                ])))),
                                                Visibility(
                                                    visible: step1,
                                                    child: Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: Bounce(
                                                            duration: Duration(milliseconds: 110),
                                                            onPressed: () {
                                                                setState(() {
                                                                    step1 = false;
                                                                    step2 = true;
                                                                    cart_numbers.clear();
                                                                });
                                                            },
                                                            child: Container(
                                                                margin: EdgeInsets.only(
                                                                    bottom: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    6.5 /
                                                                    100 +
                                                                    MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    3 /
                                                                    100),
                                                                decoration: BoxDecoration(
                                                                    color: Color(0xff2B6FD0),
                                                                    borderRadius:
                                                                    BorderRadius.circular(10),
                                                                ),
                                                                width: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                90 /
                                                                100,
                                                                height: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                7 /
                                                                100,
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.center,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.center,
                                                                    children: < Widget > [
                                                                        Text("Start Selling",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontFamily:
                                                                                'Montserrat',
                                                                                fontSize: 17,
                                                                                fontWeight:
                                                                                FontWeight.w500))
                                                                    ]))),
                                                    ),
                                                ),
                                                Visibility(
                                                    visible: step2,
                                                    child: Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: Bounce(
                                                            duration: Duration(milliseconds: 110),
                                                            onPressed: () {
                                                                if (items == 0) {
                                                                    Fluttertoast.showToast(
                                                                        msg: "No Items Selected",
                                                                        toastLength: Toast.LENGTH_LONG,
                                                                        gravity: ToastGravity.CENTER,
                                                                        timeInSecForIosWeb: 1,
                                                                        backgroundColor: Colors.black,
                                                                        textColor: Colors.white,
                                                                        fontSize: 16.0);
                                                                } else {
                                                                    showMaterialModalBottomSheet(
                                                                        isDismissible: false,
                                                                        enableDrag: false,
                                                                        expand: false,
                                                                        context: context,
                                                                        builder: (context,
                                                                            scrollController) =>
                                                                        Container(
                                                                            padding:
                                                                            EdgeInsets.all(20),
                                                                            decoration:
                                                                            BoxDecoration(
                                                                                color:
                                                                                Color(0xff202022),
                                                                            ),
                                                                            height: MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .height *
                                                                            40 /
                                                                            100,
                                                                            child: Column(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                .start,
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment
                                                                                .center,
                                                                                children: < Widget > [
                                                                                    Container(
                                                                                        padding: EdgeInsets.only(
                                                                                            bottom: 3,
                                                                                            top: MediaQuery.of(context)
                                                                                            .size
                                                                                            .width *
                                                                                            5 /
                                                                                            100),
                                                                                        width: MediaQuery.of(
                                                                                            context)
                                                                                        .size
                                                                                        .width,
                                                                                        child: Row(
                                                                                            mainAxisAlignment:
                                                                                            MainAxisAlignment
                                                                                            .start,
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                            .center,
                                                                                            children: <
                                                                                            Widget > [
                                                                                                Container(
                                                                                                    width: MediaQuery.of(context).size.width *
                                                                                                    30 /
                                                                                                    100,
                                                                                                    child: AutoSizeText('Sub Total:',
                                                                                                        maxLines: 1,
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w500))),
                                                                                                Spacer(),
                                                                                                Container(
                                                                                                    width: MediaQuery.of(context).size.width *
                                                                                                    30 /
                                                                                                    100,
                                                                                                    child: AutoSizeText('Mk: ' + itemsvalue.toString(),
                                                                                                        maxLines: 1,
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w500))),
                                                                                            ])),
                                                                                    Container(
                                                                                        padding: EdgeInsets
                                                                                        .only(
                                                                                            bottom:
                                                                                            3),
                                                                                        width: MediaQuery.of(
                                                                                            context)
                                                                                        .size
                                                                                        .width,
                                                                                        child: Row(
                                                                                            mainAxisAlignment:
                                                                                            MainAxisAlignment
                                                                                            .start,
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                            .center,
                                                                                            children: <
                                                                                            Widget > [
                                                                                                Container(
                                                                                                    width: MediaQuery.of(context).size.width *
                                                                                                    30 /
                                                                                                    100,
                                                                                                    child: AutoSizeText('Taxes & Fees: ',
                                                                                                        maxLines: 1,
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w500))),
                                                                                                Spacer(),
                                                                                                Container(
                                                                                                    width: MediaQuery.of(context).size.width *
                                                                                                    30 /
                                                                                                    100,
                                                                                                    child: AutoSizeText('Mk: 0.00',
                                                                                                        maxLines: 1,
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w500))),
                                                                                            ])),
                                                                                    Container(
                                                                                        padding: EdgeInsets
                                                                                        .only(
                                                                                            bottom:
                                                                                            3),
                                                                                        width: MediaQuery.of(
                                                                                            context)
                                                                                        .size
                                                                                        .width,
                                                                                        child: Row(
                                                                                            mainAxisAlignment:
                                                                                            MainAxisAlignment
                                                                                            .start,
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                            .center,
                                                                                            children: <
                                                                                            Widget > [
                                                                                                Container(
                                                                                                    width: MediaQuery.of(context).size.width *
                                                                                                    30 /
                                                                                                    100,
                                                                                                    child: AutoSizeText('Total: ',
                                                                                                        maxLines: 1,
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w500))),
                                                                                                Spacer(),
                                                                                                Container(
                                                                                                    width: MediaQuery.of(context).size.width *
                                                                                                    30 /
                                                                                                    100,
                                                                                                    child: AutoSizeText('Mk: ' + itemsvalue.toString(),
                                                                                                        maxLines: 1,
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w500))),
                                                                                            ])),
                                                                                    Spacer(),
                                                                                    Container(
                                                                                        width: MediaQuery.of(
                                                                                            context)
                                                                                        .size
                                                                                        .width,
                                                                                        child: Row(
                                                                                            mainAxisAlignment:
                                                                                            MainAxisAlignment
                                                                                            .start,
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                            .start,
                                                                                            children: <
                                                                                            Widget > [
                                                 //==================================================================================================================================================================================================                                           
                                                                                            ////HERE IS WHERE THE FUNCTION THE UPDATE FUTURE FUNCTION IS CALLED 
                                                                                                Bounce(
                                                                                                    duration:
                                                                                                    Duration(milliseconds: 110),
                                                                                                    onPressed: () {
                                                                                                        var number = secureRandom.nextString(length: 15, charset: '0123456789').toString();

                                                                                                        FirebaseFirestore.instance.collection("orders").add({
                                                                                                            'orderid': number.toString(),
                                                                                                            'cart': cart,
                                                                                                            'id': user_id.toString(),
                                                                                                            'total': itemsvalue
                                                                                                        }).then((value) {
                                                                                                            setState(() {
                                                                                                                items = 0;
                                                                                                                itemsvalue = 0.0;
                                                                                                                cart.clear();
                                                                                                                step1 = true;
                                                                                                                step2 = false;
                                                                                                            });

                                                                                                            Navigator.of(context).pop();

                                                                                                            Fluttertoast.showToast(msg: "Order Successful", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 18.0);

                                                                                                            print("================================sucess=============================================================");
                                                                                                            print(value.documentID); 
                                                                                                            update(cart_numbers); //==================================================================== RIGHT HERE AFTER USER PRESSESS COMPLETE ORDER BUTTON


                                                                                                           
                                                                                                          
                                                                                                        });
                                                                                                    },
                                                                                                    child: Center(
                                                                                                        child: Container(
                                                                                                            decoration: BoxDecoration(
                                                                                                                color: Color(0xff2B6FD0),
                                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                            ),
                                                                                                            width: MediaQuery.of(context).size.width * 88/ 100,
                                                                                                            height: MediaQuery.of(context).size.height * 7 / 100,
                                                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                                Text("Complete Order", style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 17, fontWeight: FontWeight.w500))
                                                                                                            ]))))
                                                                                            ])),
                                                                                    Spacer(),
                                                                                    Container(
                                                                                        width: MediaQuery.of(
                                                                                            context)
                                                                                        .size
                                                                                        .width,
                                                                                        child: Row(
                                                                                            mainAxisAlignment:
                                                                                            MainAxisAlignment
                                                                                            .start,
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                            .start,
                                                                                            children: <
                                                                                            Widget > [
                                                                                                Bounce(
                                                                                                    duration:
                                                                                                    Duration(milliseconds: 110),
                                                                                                    onPressed: () {
                                                                                                        setState(() {
                                                                                                            Navigator.of(context).pop();
                                                                                                        });
                                                                                                    },
                                                                                                    child: Container(
                                                                                                        child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: < Widget > [
                                                                                                            Container(width: MediaQuery.of(context).size.width * 88 / 100, child: AutoSizeText('Cancel', maxLines: 1, textAlign: TextAlign.center, style: TextStyle(color: Color(0xffB9B9BA), fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w500))),
                                                                                                        ])))
                                                                                            ]))
                                                                                ])));
                                                                }
                                                            },
                                                            child: SwipeTo(
                                                                child: Container(
                                                                    margin: EdgeInsets.only(
                                                                        bottom: MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                        6.5 /
                                                                        100 +
                                                                        MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                        3 /
                                                                        100),
                                                                    decoration: BoxDecoration(
                                                                        color: Color(0xff2B6FD0),
                                                                        borderRadius:
                                                                        BorderRadius.circular(10),
                                                                    ),
                                                                    width: MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                    90 /
                                                                    100,
                                                                    height: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    7 /
                                                                    100,
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        children: < Widget > [
                                                                            AutoSizeText(
                                                                                items.toString() +
                                                                                " Item - Mk " +
                                                                                itemsvalue
                                                                                .toString(),
                                                                                maxLines: 1,
                                                                                style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontFamily:
                                                                                    'Montserrat',
                                                                                    fontSize: 17,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                    .w500))
                                                                        ])),
                                                                iconOnRightSwipe: Icons.cancel,
                                                                iconColor: Color(0xff0B0B0B),
                                                                onRightSwipe: () {
                                                                    setState(() {
                                                                        items = 0;
                                                                        itemsvalue = 0.0;
                                                                        cart.clear();
                                                                        cart_numbers.clear();

                                                                        step1 = true;
                                                                        step2 = false;
                                                                    });
                                                                },
                                                            ),
                                                        ),
                                                    )),
                                                Visibility(
                                                    visible: showbutton,
                                                    child: Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: Bounce(
                                                            duration: Duration(milliseconds: 110),
                                                            onPressed: () {
                                                                setState(() {});
                                                            },
                                                            child: SwipeTo(
                                                                child: Container(
                                                                    margin: EdgeInsets.only(
                                                                        bottom: MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                        50 /
                                                                        100 +
                                                                        MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                        3 /
                                                                        100),
                                                                    decoration: BoxDecoration(
                                                                        color: Color(0xff2B6FD0),
                                                                        borderRadius:
                                                                        BorderRadius.circular(10),
                                                                    ),
                                                                    width: MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                    90 /
                                                                    100,
                                                                    height: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    7 /
                                                                    100,
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        children: < Widget > [
                                                                            AutoSizeText(
                                                                                items.toString() +
                                                                                " Item - Mk " +
                                                                                itemsvalue
                                                                                .toString(),
                                                                                maxLines: 1,
                                                                                style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontFamily:
                                                                                    'Montserrat',
                                                                                    fontSize: 17,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                    .w500))
                                                                        ])),
                                                                iconOnRightSwipe: Icons.cancel,
                                                                iconColor: Color(0xff0B0B0B),
                                                                onRightSwipe: () {
                                                                    setState(() {
                                                                        items = 0;
                                                                        itemsvalue = 0.0;
                                                                        cart.clear();
                                                                        cart_numbers.clear();
                                                                    });
                                                                },
                                                            ),
                                                        ),
                                                    ))
                                            ])),

                                             Visibility( 
                                               
                                               visible:searchpage,
                                               child:Container(
                                                    color: Color(0xff0B0B0B),width:MediaQuery.of(context).size.width,
                                                    height: MediaQuery.of(context).size.height *
                                                    80 /
                                                    100,
                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *
                                                        3 /
                                                        100 ,
                                                        left:
                                                        MediaQuery.of(context).size.width *
                                                        5 /
                                                        100,
                                                        right:
                                                        MediaQuery.of(context).size.width *
                                                        5 /
                                                        100,
                                                        top: MediaQuery.of(context).size.width *
                                                        10 /
                                                        100),
                                                        
                                                        child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: < Widget > [

                                   StreamBuilder<List<AlgoliaObjectSnapshot>>(
                  stream: Stream.fromFuture(_operation(_searchTerm)),  
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) return Text("Start Typing", style: TextStyle(color: Colors.white ),);
                    else{
                    List<AlgoliaObjectSnapshot> currSearchStuff = snapshot.data;

                    switch (snapshot.connectionState) {
                     case ConnectionState.waiting: return Container(child:CircularProgressIndicator());
                     default:
                       if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                       else
                    return CustomScrollView(shrinkWrap: true,
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            ( context,  index) {
                              return _searchTerm.length > 0 ? DisplaySearchResult(artDes: currSearchStuff[index].data["name"], artistName: currSearchStuff[index].data["price"].toString(), genre: currSearchStuff[index].data["quantity"].toString(),) :
                              Container();
                              
                            },
                            childCount: currSearchStuff.length ?? 0,
                          ),
                        ),
                    ],
                    );
                    
                    
                    }}
                    
                    
                    }),


                                    Spacer(),
                                 
                                
                                                   
                                                        
                                                        
                                                        
                                                        ]),
                                                        
                                                        
                                                        ))
                                    
                                    //searchpage
                                    ])
                                    
                                    
                                    
                                    ])
                                    
                                    
                                    
                                    ) 
                                    
                                   
                                   ,
                            Container(color: Colors.blue)
                        ]))

                /*) */
                ,
                SafeArea(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            color: Color(0xff202022),
                            height: MediaQuery.of(context).size.height * 6.5 / 100,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: < Widget > [
                                    Container(
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: < Widget > [
                                                Container(
                                                    //width:MediaQuery.of(context).size.width*20/100,

                                                    child: Transform.scale(
                                                        scale: 1.0,
                                                        child: IconButton(
                                                            icon: new Image.asset(
                                                                'assets/images/menu_icon.png',
                                                                width: 30,
                                                                height: 25,
                                                                color: Color(0xff98A0A5),
                                                            ),
                                                            tooltip: 'Closes application',
                                                            onPressed: () {},
                                                        ))),
                                                Container(
                                                    child: Text("$nav",
                                                        style: TextStyle(
                                                            color: Color(0xffB9B9BA),
                                                            fontFamily: 'Montserrat',
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500)),
                                                )
                                            ])),
                                    Container(
                                        width: MediaQuery.of(context).size.width *
                                        60 /
                                        100,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: < Widget > [
                                                Container(
                                                    child: Text("Raphael M.",
                                                        style: TextStyle(
                                                            color: Color(0xffB9B9BA),
                                                            fontFamily: 'Montserrat',
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w500))),
                                            ])),
                                    Container(
                                        width: MediaQuery.of(context).size.width *
                                        10 /
                                        100,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: < Widget > [
                                                CircleAvatar(
                                                    backgroundColor: Color(0xff339674),
                                                    radius: 7,
                                                )
                                            ]))
                                ])))),
            ]));
    }
}
class DisplaySearchResult extends StatelessWidget {
  final String artDes;
  final String artistName;
  final String genre;

  DisplaySearchResult({Key key, this.artistName, this.artDes, this.genre}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container( 
          width:MediaQuery.of(context).size.width *
                                        40 /
                                        100, child:
        Text(artDes ?? "", textAlign:TextAlign.left,style: TextStyle(
                                                        color: Color(0xffB9B9BA),
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w500))),
         Container( width:MediaQuery.of(context).size.width *
                                        25 /
                                        100,child:Text(artistName ?? "", textAlign:TextAlign.right, style:  TextStyle(
                                                        color: Color(0xffB9B9BA),
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w500),)),
         Container(width:MediaQuery.of(context).size.width *
                                        15 /
                                        100, child:Text(genre ?? "", textAlign:TextAlign.right,style:  TextStyle(
                                                        color: Color(0xffB9B9BA),
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w500),)),
       
      ]
    );
  }
}
