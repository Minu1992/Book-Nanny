// part of EnviroKlenzImportBundle;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_new_app/ApiService.dart';
import 'package:my_new_app/Modelclass.dart';
import 'package:my_new_app/Nextpage.dart';
import 'package:my_new_app/SizeConfig.dart';
import 'package:my_new_app/main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isPhone = false;
  late Future<List<Package>> packagesFuture;
  late Future<List<Booking>> bookingsFuture;

  @override
  void initState() {
    packagesFuture = ApiService().fetchPackages();
    bookingsFuture = ApiService().fetchCurrentBookings();
    super.initState();

    isPhone = getDeviceType() == "phone";
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (!isPhone) {
          //  PopupHandler.addEvent({"type": 'device_not_compatible'});
        } else {}
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          backgroundColor: Color.fromRGBO(243, 243, 217, 1),
          resizeToAvoidBottomInset: true,
          body: Stack(children: [scrollingwift(), Bottmnavbar()])),
    );
  }

  Widget scrollingwift() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Stack(
        children: [
          // Full-screen scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                middlepaneldata(), // The main scrollable content
                SizedBox(
                  height: 80 *
                      SizeConfig
                          .blockSizeVertical, // Add extra space at the bottom for the bottom container
                ),
              ],
            ),
          ),
          // The right 30% clickable container
          Positioned.fill(
            child: Row(
              children: [
                // Non-clickable left 70%
                Expanded(
                  flex: 6,
                  child: IgnorePointer(
                    child: Container(
                      color: Colors.transparent, // No interaction here
                    ),
                  ),
                ),
                // Clickable right 30%
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {
                      print("Right 30% tapped!");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage()),
                      );
                      // Perform any action here
                    },
                    child: Container(
                      color: Colors.transparent, // Make this area clickable
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Bottmnavbar() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 247, 217, 1), //

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1), // Shadow offset
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 15 * SizeConfig.blockSizeHorizontal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Non-clickable Home
              IgnorePointer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 2),
                    IgnorePointer(
                      child: _buildDeviceBlock(
                        Icons.home_outlined,
                        "Home",
                        Color.fromARGB(209, 220, 65, 91),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 2,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            209, 220, 65, 91), // Pink dot for Home
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(height: 1),
                  ],
                ),
              ),

              // Non-clickable Packages
              IgnorePointer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  SvgPicture.asset(
                    'assets/discount.svg',
                    height: 25 * SizeConfig.blockSizeVertical,
                    color: Colors.black87,
                  ),
                  // SvgPicture.asset(
                  //   assetPath,
                  //   height: 25 * SizeConfig.blockSizeVertical,
                  //   color: colors,
                  //   width: 0.5,
                  // ),
                  //  SizedBox(height: 2 * SizeConfig.blockSizeVertical),
                  Text(
                    'Packages',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 11 * SizeConfig.blockSizeVertical),
                  ),
                ],
              )),
              // Clickable Bookings
              IgnorePointer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  SvgPicture.asset(
                    'assets/time.svg',
                    height: 25 * SizeConfig.blockSizeVertical,
                    color: Colors.black87,
                    width: 0.5,
                  ),
                  Text(
                    'Bookings',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 11 * SizeConfig.blockSizeVertical),
                  ),
                ],
              )),
              // Clickable Profile
              IgnorePointer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  SvgPicture.asset(
                    'assets/adduser.svg',
                    height: 25 * SizeConfig.blockSizeVertical,
                    color: Colors.black,
                    width: 0.5,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 11 * SizeConfig.blockSizeVertical),
                  ),
                ],
              )),
              // Cl
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceBlock(assetPath, String label, Color colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 0),
        Icon(
          assetPath, // Replace with your specific icon
          size: 30 * SizeConfig.blockSizeVertical,
          color: colors,
        ),
        Text(
          label,
          style: TextStyle(
              color: Color.fromARGB(209, 220, 65, 91),
              fontSize: 11 * SizeConfig.blockSizeVertical),
        ),
      ],
    );
  }

  Widget menuicon() {
    return Padding(
      padding:
          EdgeInsets.only(right: 30), // Adjust space from the right as needed
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 20,
          width: 20, // Width of the container to fit the lines
          child: Stack(
            alignment: Alignment.centerRight, // Align stack to the right
            children: [
              // First Line
              Positioned(
                top: 0,
                child: Container(
                  height: 1.5,
                  width: 30, // Width of the first line
                  color: Colors.pink,
                ),
              ),
              // Second Line (Shorter)
              Positioned(
                top: 7, // Adjust top position for spacing
                child: Container(
                  height: 1.5,
                  width: 15, // Shorter width for the second line
                  color: Colors.pink,
                ),
              ),
              // Third Line
              Positioned(
                top: 14, // Adjust top position for spacing
                child: Container(
                  height: 1.5,
                  width: 30, // Width of the third line
                  color: Colors.pink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Profileimage() {
    return Container(
      margin: EdgeInsets.only(left: 25 * SizeConfig.blockSizeHorizontal),
      padding: EdgeInsets.only(
          left: 10 * SizeConfig.blockSizeHorizontal,
          bottom: 10 * SizeConfig.blockSizeVertical),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // CircleAvatar with image
          Center(
              child: Container(
            width: 50.0, // Size of the CircleAvatar
            height: 50.0, // Size of the CircleAvatar
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.fromARGB(255, 245, 109, 132), // Border color
                width: 1, // Border width
              ),
            ),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/girl.jpg'), // Re/ Your image here
              radius: 32.0, // Adjust based on your container size
            ),
          )),
          SizedBox(width: 5), // Space between CircleAvatar and text
          // User name text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54.withOpacity(0.8)),
              ),
              Text(
                'Emily Cyrus',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(230, 219, 75, 99),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget Booknowwuthbnanny() {
    return Stack(
      clipBehavior:
          Clip.none, // Allows the image to exceed the container bounds
      children: [
        // Pink Container with Text and Button
        Booknow(),

        // Nanny and Baby Image positioned over the container
        Positioned(
          right: -6 *
              SizeConfig
                  .blockSizeVertical, // Moves the image further right, outside the container
          top: -110, // Moves the image upward, outside the container
          child: Image.asset(
            'assets/nannybaby.png', // Ensure you use the correct path to the image asset
            height: 350, // Larger than the container height
            width: 350, // Adjust width as per your requirement
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget middlepaneldata() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Space from the top
        SizedBox(height: 50 * SizeConfig.blockSizeVertical),
        menuicon(),
        Profileimage(),

        SizedBox(height: 20 * SizeConfig.blockSizeVertical),
        Booknowwuthbnanny(),

        // Space between the user info and the new text
        SizedBox(height: 17 * SizeConfig.blockSizeVertical),

        // New text with specific padding and width
        Container(
          margin: EdgeInsets.only(left: 25 * SizeConfig.blockSizeHorizontal),
          padding:
              EdgeInsets.only(left: 10), // Match left padding with the image
          child: Text(
            'Your Current Booking',
            style: TextStyle(
              color: Color.fromRGBO(
                9,
                9,
                56,
                0.9,
              ),
              fontSize: 14, // Font size
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(height: 15 * SizeConfig.blockSizeVertical),
        currentbooking(),

        SizedBox(height: 15 * SizeConfig.blockSizeVertical),

        // New text with specific padding and width
        Container(
          margin: EdgeInsets.only(left: 25 * SizeConfig.blockSizeHorizontal),
          // padding:
          //     EdgeInsets.only(left: 10), // Match left padding with the image
          child: Text(
            'Packages',
            style: TextStyle(
              color: Color.fromRGBO(
                9,
                9,
                56,
                0.9,
              ),
              fontSize: 18 * SizeConfig.blockSizeVertical, // Font size
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        getpackagedetails(),
        SizedBox(height: 80 * SizeConfig.blockSizeVertical),
      ],
    );
  }

  // Color.fromRGBO(75, 132, 170, 0.8),
  Widget getpackagedetails() {
    List<Color> cardcolor = [
      Color.fromRGBO(255, 156, 157, 1),
      Color.fromRGBO(75, 132, 170, 0.8),
      Color.fromRGBO(255, 156, 157, 1),
      Color.fromRGBO(75, 132, 170, 0.8),
    ];

    List<Color> buttonclr = [
      Color.fromRGBO(221, 64, 145, 0.8),
      Color.fromRGBO(4, 131, 159, 0.859),
      Color.fromRGBO(221, 64, 145, 0.8),
      Color.fromRGBO(4, 131, 159, 0.859)
    ];
    // rgba(35, 186, 220, 1)

    return Container(
      //height: MediaQuery.of(context).size.height * 0.5,
      child: FutureBuilder<List<Package>>(
        future: packagesFuture,
        builder: (context, snapshot) {
          print("minuminmuinmunu$snapshot");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No packages available'));
          }

          final package = snapshot.data!;

          print("fminuminuminmu  $package");

          return Column(
            children: [
              Card(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                elevation: 0,
                color: cardcolor[0],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8, top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First row: Calendar symbol and Start container
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment
                                  .center, // Aligns both the text and icon at the center
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color.fromARGB(209, 220, 65, 91),
                                  size: 30 * SizeConfig.blockSizeVertical,
                                ),
                                Positioned(
                                  top:
                                      8, // Adjust this value to control the vertical position of "01"
                                  child: Text(
                                    "01",
                                    style: TextStyle(
                                      fontSize: 12 *
                                          SizeConfig
                                              .blockSizeVertical, // Adjust font size as needed
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.8,
                                      color: Color.fromARGB(209, 220, 65, 91),
                                    ),
                                  ),
                                ),
                              ],
                            ), // Calendar symbol
                            SizedBox(width: 10),
                            Spacer(),
                            Container(
                              //  padding: EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 2.2),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(209, 220, 65, 91),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Second row: Title and Price
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              package[0].title,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                    9,
                                    9,
                                    56,
                                    0.9,
                                  ),
                                  fontSize: 12,
                                  letterSpacing: -0.2,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '₹${package[0].price}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      //  SizedBox(height: 10 * SizeConfig.blockSizeVertical),
                      // Third row: Details
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Text(
                          package[0].desc + ' ' + package[0].desc,
                          maxLines: 2,
                          style: TextStyle(
                              letterSpacing: -0.4,
                              fontSize: 10 * SizeConfig.blockSizeVertical),
                        ),
                      ),
                      //SizedBox(height: 5 * SizeConfig.blockSizeVertical),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 28),
                elevation: 0,
                color: cardcolor[1],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8, top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First row: Calendar symbol and Start container
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment
                                  .center, // Aligns both the text and icon at the center
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.white.withAlpha(190),
                                  size: 30 * SizeConfig.blockSizeVertical,
                                ),
                                Positioned(
                                  top:
                                      8, // Adjust this value to control the vertical position of "01"
                                  child: Text(
                                    "03",
                                    style: TextStyle(
                                      fontSize: 12 *
                                          SizeConfig
                                              .blockSizeVertical, // Adjust font size as needed
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.8,
                                      color: Colors.white.withAlpha(190),
                                    ),
                                  ),
                                ),
                              ],
                            ), // Calen/ Calendar symbol
                            SizedBox(width: 10),
                            Spacer(),
                            Container(
                              //  padding: EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 2.2),
                                decoration: BoxDecoration(
                                  color: buttonclr[3],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Second row: Title and Price
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              package[1].title,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                    9,
                                    9,
                                    56,
                                    0.9,
                                  ),
                                  fontSize: 12,
                                  letterSpacing: -0.2,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '₹${package[1].price}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      //  SizedBox(height: 10 * SizeConfig.blockSizeVertical),
                      // Third row: Details
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Text(
                          package[1].desc + ' ' + package[1].desc,
                          maxLines: 2,
                          style: TextStyle(
                              letterSpacing: -0.4,
                              fontSize: 10 * SizeConfig.blockSizeVertical),
                        ),
                      ),
                      SizedBox(height: 10 * SizeConfig.blockSizeVertical),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                elevation: 0,
                color: cardcolor[2],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8, top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First row: Calendar symbol and Start container
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment
                                  .center, // Aligns both the text and icon at the center
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color.fromARGB(209, 220, 65, 91),
                                  size: 30 * SizeConfig.blockSizeVertical,
                                ),
                                Positioned(
                                  top:
                                      8, // Adjust this value to control the vertical position of "01"
                                  child: Text(
                                    "05",
                                    style: TextStyle(
                                      letterSpacing: -0.8,
                                      fontSize: 12 *
                                          SizeConfig
                                              .blockSizeVertical, // Adjust font size as needed
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(209, 220, 65, 91),
                                    ),
                                  ),
                                ),
                              ],
                            ), // Calen/ Calendar symbol
                            SizedBox(width: 10),
                            Spacer(),
                            Container(
                              //  padding: EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 2.2),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(209, 220, 65, 91),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Second row: Title and Price
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              package[2].title,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                    9,
                                    9,
                                    56,
                                    0.9,
                                  ),
                                  fontSize: 12,
                                  letterSpacing: -0.2,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '₹${package[2].price}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      //  SizedBox(height: 10 * SizeConfig.blockSizeVertical),
                      // Third row: Details
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Text(
                          package[2].desc + ' ' + package[2].desc,
                          maxLines: 2,
                          style: TextStyle(
                              letterSpacing: -0.4,
                              fontSize: 10 * SizeConfig.blockSizeVertical),
                        ),
                      ),
                      SizedBox(height: 10 * SizeConfig.blockSizeVertical),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 28),
                elevation: 0,
                color: cardcolor[3],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8, top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First row: Calendar symbol and Start container
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment
                                  .center, // Aligns both the text and icon at the center
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.white.withAlpha(190),
                                  size: 30 * SizeConfig.blockSizeVertical,
                                ),
                                Positioned(
                                  top:
                                      12, // Adjust this value to control the vertical position of "01"
                                  child: Icon(
                                    Icons.wb_sunny_outlined,
                                    color: Colors.white.withAlpha(190),
                                    size: 11 * SizeConfig.blockSizeVertical,
                                  ),
                                ),
                              ],
                            ), // // Calendar symbol
                            SizedBox(width: 10),
                            Spacer(),
                            Container(
                              //  padding: EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 2.2),
                                decoration: BoxDecoration(
                                  color: buttonclr[1],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Second row: Title and Price
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              package[3].title,
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                    9,
                                    9,
                                    56,
                                    0.9,
                                  ),
                                  fontSize: 12,
                                  letterSpacing: -0.2,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '₹${package[3].price}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      //  SizedBox(height: 10 * SizeConfig.blockSizeVertical),
                      // Third row: Details
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Text(
                          package[3].desc + ' ' + package[3].desc,
                          maxLines: 2,
                          style: TextStyle(
                              letterSpacing: -0.4,
                              color: Colors.white.withAlpha(190),
                              fontSize: 10 * SizeConfig.blockSizeVertical),
                        ),
                      ),
                      SizedBox(height: 10 * SizeConfig.blockSizeVertical),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // color: Color.fromARGB(255, 244, 166, 179),
  Widget Booknow() {
    return Container(
      margin: EdgeInsets.only(
        left: 30 * SizeConfig.blockSizeHorizontal,
        right: 30 * SizeConfig.blockSizeHorizontal,
      ),
      padding: EdgeInsets.only(
          left: 25, top: 22), // Added padding for internal spacing
      height: 155 * SizeConfig.blockSizeVertical,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 156, 157, 1),
        //  color: Color(0x#FFB3DE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns all to the left
        children: [
          SizedBox(height: 15 * SizeConfig.blockSizeVertical), // Spac
          Text(
            'Nanny And',
            style: TextStyle(
              fontSize: 15 * SizeConfig.blockSizeVertical,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
              color: Color.fromRGBO(
                9,
                9,
                56,
                0.9,
              ),
            ),
          ),
          SizedBox(
            height: 5 * SizeConfig.blockSizeVertical,
          ), // Space between Anny and Babysitting Services
          Text(
            'Babysitting Services',
            style: TextStyle(
              fontSize: 15 * SizeConfig.blockSizeVertical,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
              color: Color.fromRGBO(
                9,
                9,
                56,
                0.9,
              ),
            ),
          ),
          // Pushes the "Book Now" button to the bottom
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 2.2),
              decoration: BoxDecoration(
                color: Color.fromRGBO(
                  9,
                  9,
                  56,
                  0.9,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'Book Now',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget currentbooking() {
    return Container(
        margin: EdgeInsets.only(
            left: 25 * SizeConfig.blockSizeHorizontal,
            right: 20 * SizeConfig.blockSizeHorizontal),
        padding: EdgeInsets.only(left: 10),
        height: 160 * SizeConfig.blockSizeVertical,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 247, 217, 1), //
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1), // Shadow offset
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10 * SizeConfig.blockSizeVertical,
            ),
            Container(
              margin:
                  EdgeInsets.only(right: 10 * SizeConfig.blockSizeHorizontal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'One Day Package',
                    style: TextStyle(
                      fontSize: 14 * SizeConfig.blockSizeVertical, // Font size
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                      color: Color.fromARGB(209, 220, 65, 91),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22, vertical: 2.2),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(209, 220, 65, 91),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Start',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 9 * SizeConfig.blockSizeVertical),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Left part

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: TextStyle(
                        fontSize:
                            12 * SizeConfig.blockSizeVertical, // Font size
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Color.fromARGB(209, 220, 65, 91),
                          size: 13 * SizeConfig.blockSizeVertical,
                        ), // Calendar icon
                        SizedBox(
                            width: 7 *
                                SizeConfig
                                    .blockSizeHorizontal), //ace between icon and date
                        Text(
                          '12.08.2020',
                          style: TextStyle(
                            fontSize: 13 * SizeConfig.blockSizeVertical,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 5 *
                            SizeConfig
                                .blockSizeVertical), // Space between calendar and timer
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: Color.fromARGB(209, 220, 65, 91),
                          size: 13 * SizeConfig.blockSizeVertical,
                        ), // Timer icon
                        SizedBox(
                            width: 5 *
                                SizeConfig
                                    .blockSizeHorizontal), //// Space between icon and time
                        Text(
                          '11 pm',
                          style: TextStyle(
                            fontSize: 14 * SizeConfig.blockSizeVertical,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Right part
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To',
                      style: TextStyle(
                        fontSize:
                            12 * SizeConfig.blockSizeVertical, // Font size
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 4 * SizeConfig.blockSizeVertical),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Color.fromARGB(209, 220, 65, 91),
                          size: 13 * SizeConfig.blockSizeVertical,
                        ), // Calendar icon
                        SizedBox(
                            width: 5 *
                                SizeConfig
                                    .blockSizeHorizontal), //ace between icon and date
                        Text(
                          '12.08.2020',
                          style: TextStyle(
                            fontSize: 13 * SizeConfig.blockSizeVertical,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 5 *
                            SizeConfig
                                .blockSizeVertical), // Space between calendar and timer
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: Color.fromARGB(209, 220, 65, 91),
                          size: 13 * SizeConfig.blockSizeVertical,
                        ), // Timer icon
                        SizedBox(
                            width: 5 *
                                SizeConfig
                                    .blockSizeHorizontal), //// Space between icon and time
                        Text(
                          '11 pm',
                          style: TextStyle(
                            fontSize: 14 * SizeConfig.blockSizeVertical,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 14 * SizeConfig.blockSizeVertical), //
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // Evenly spaces the containers
              children: [
                // First section
                Container(
                  height: 22 * SizeConfig.blockSizeVertical,
                  width: 65 * SizeConfig.blockSizeHorizontal, // Adjusted size
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(9, 9, 56, 0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_border_outlined,
                          color: Colors.white,
                          size: 12 * SizeConfig.blockSizeVertical),
                      SizedBox(
                          width: 2 *
                              SizeConfig
                                  .blockSizeHorizontal), // Reduced spacing for better alignment
                      Text(
                        "Rate Us",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10 *
                              SizeConfig
                                  .blockSizeVertical, // Adjusted font size
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Second section
                Container(
                  height: 22 * SizeConfig.blockSizeVertical,
                  width: 75 * SizeConfig.blockSizeHorizontal,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(9, 9, 56, 0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/scheduler_location.svg',
                        height: 12 * SizeConfig.blockSizeVertical,
                        color: Colors.white,
                      ),
                      Text(
                        "Geolocation",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10 *
                              SizeConfig
                                  .blockSizeVertical, // Adjusted font size
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Third section
                Container(
                  height: 22 * SizeConfig.blockSizeVertical,
                  width: 75 * SizeConfig.blockSizeHorizontal,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(9, 9, 56, 0.9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mic_none,
                          color: Colors.white,
                          size: 12 * SizeConfig.blockSizeVertical),
                      Text(
                        "Surveillance",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10 *
                              SizeConfig
                                  .blockSizeVertical, // Adjusted font size
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

Widget _buildBottomItemWithImage(String assetPath, String label) {
  return Expanded(
    child: InkWell(
      onTap: () {
        // Handle the tap event
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            width: 24,
            height: 24,
            color: Colors.white,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
