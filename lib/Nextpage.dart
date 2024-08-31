import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_new_app/SizeConfig.dart';
import 'package:my_new_app/main.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<NextPage> {
  bool isPhone = false;

  @override
  void initState() {
    super.initState();

    isPhone = getDeviceType() == "phone";
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (!isPhone) {
          //can show popup for ipad
        } else {}
      },
    );
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Row(
        children: [
          // 70% section - Clickable
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color:
                    Colors.transparent, // Ensures the entire area is clickable
                child: Column(
                  children: [
                    Expanded(
                        child: Menudata()), // Expands to fill available space
                  ],
                ),
              ),
            ),
          ),
          // 30% section - Static
          Expanded(
            flex: 4,
            child: Container(
              child: Center(child: RightsideContainer()),
            ),
          ),
        ],
      ),
    );
  }

  Widget Menudata() {
    return Column(
      children: [
        SizedBox(height: 70 * SizeConfig.blockSizeVertical),
        Center(
            child: Container(
          width: 65.0, // Size of the CircleAvatar
          height: 65.0, // Size of the CircleAvatar
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
        SizedBox(height: 10 * SizeConfig.blockSizeVertical),
        // User name text
        Text(
          'Emily Cyrus',
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(230, 219, 75, 99),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10 * SizeConfig.blockSizeVertical),

        leftmenubar()
      ],
    );
  }

  Widget leftmenubar() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25), //
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          menucontainer("Home"),
          menucontainer("Book A Nanny"),
          menucontainer("How It Works"),
          menucontainer("Why Nanny Vanny"),
          menucontainer("My Bookings"),
          menucontainer("My Profile"),
          menucontainer("Support"),
          Container(),

          // Book a Nanny Tab
        ],
      ),
    );
  }

  Widget menucontainer(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Spacing (before title)
        SizedBox(height: 8 * SizeConfig.blockSizeVertical),

        // Title Text
        Text(
          title,
          style: TextStyle(
            fontSize: 16 * SizeConfig.blockSizeVertical,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Spacing between the title and line
        SizedBox(height: 10 * SizeConfig.blockSizeVertical),

        // Line (shown below the title)
        Container(
          height: 0.5,
          color: Color.fromARGB(255, 245, 109, 132), // Line color
        ),

        // Bottom Spacing (after line)
        SizedBox(height: 8 * SizeConfig.blockSizeVertical),
      ],
    );
  }

  Widget RightsideContainer() {
    return Container(
        height: 580 * SizeConfig.blockSizeVertical,
        decoration: BoxDecoration(
          color: Colors.white, // Card background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Shadow offset
            ),
          ],
        ),
        child: Column(children: [Rightsidedata(), bottomnavbar()]));
  }

  Widget Rightsidedata() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 30), //
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Profilecontainer(),
          SizedBox(height: 20 * SizeConfig.blockSizeVertical),
          booknany(),
          SizedBox(height: 15 * SizeConfig.blockSizeVertical),

          // New text with specific padding and width
          Container(
            //  margin: EdgeInsets.only(left: 40 * SizeConfig.blockSizeHorizontal),
            // padding:
            //     EdgeInsets.only(left: 10), // Match left padding with the image
            child: Text(
              'Your Current Booking',
              style: TextStyle(
                color: Color.fromRGBO(
                  9,
                  9,
                  56,
                  0.9,
                ),
                letterSpacing: -0.3,
                fontSize: 12, // Font size
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(height: 15 * SizeConfig.blockSizeVertical),
          getpackagedetails(),

          SizedBox(height: 15 * SizeConfig.blockSizeVertical),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Packages',
              style: TextStyle(
                color: Color.fromRGBO(
                  9,
                  9,
                  56,
                  0.9,
                ),
                fontSize: 12, // Font size
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(height: 12 * SizeConfig.blockSizeVertical),
          currentbooking(),
          SizedBox(height: 12 * SizeConfig.blockSizeVertical),
          //  stackcontainer(),
          stackcurrentcurrentbooking(),
          //  bottomnavbar()
        ],
      ),
    );
  }

  Widget bottomnavbar() {
    return Container(
      height: 62 * SizeConfig.blockSizeVertical,
      padding: EdgeInsets.only(left: 25 * SizeConfig.blockSizeHorizontal),
      decoration: BoxDecoration(
        color: Colors.white, // Card background color
        borderRadius: BorderRadius.only(
          //  topLeft: Radius.circular(6.0),
          bottomLeft: Radius.circular(12.0),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1), // Shadow offset
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IgnorePointer(
                  child: _buildDeviceBlock(
                    Icons.home_outlined,
                    "Home",
                    Color.fromARGB(209, 220, 65, 91),
                  ),
                ),
                Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.pink, // Pink dot for Home
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 2 * SizeConfig.blockSizeVertical),
              ],
            ),
          ),
          SizedBox(height: 1 * SizeConfig.blockSizeVertical),
          Expanded(
            child: IgnorePointer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 1 * SizeConfig.blockSizeVertical),
                SvgPicture.asset(
                  'assets/discount.svg',
                  height: 25 * SizeConfig.blockSizeVertical,
                  color: Colors.black54,
                  width: 0.5,
                ),
                SizedBox(height: 5 * SizeConfig.blockSizeVertical),
                Text(
                  'Packages',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 8 * SizeConfig.blockSizeVertical),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget getpackagedetails() {
    return Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white, // Card background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0),
            bottomLeft: Radius.circular(6.0),
          ),

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6 * SizeConfig.blockSizeVertical),
            Container(
                margin:
                    EdgeInsets.only(left: 10 * SizeConfig.blockSizeHorizontal),
                child: Text(
                  "Overnight Package ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 245, 109, 132),
                    fontSize: 10, // Font size
                    fontWeight: FontWeight.w300,
                  ),
                )),
            SizedBox(height: 10 * SizeConfig.blockSizeVertical),
            Container(
                margin:
                    EdgeInsets.only(left: 10 * SizeConfig.blockSizeHorizontal),
                child: Text(
                  "From ",
                  style: TextStyle(
                    //  color: Color.fromARGB(255, 245, 109, 132),
                    fontSize: 9, // Font size
                    fontWeight: FontWeight.w300,
                  ),
                )),
            SizedBox(height: 5 * SizeConfig.blockSizeVertical),
            Container(
              margin:
                  EdgeInsets.only(left: 10 * SizeConfig.blockSizeHorizontal),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Color.fromARGB(209, 220, 65, 91),
                    size: 8 * SizeConfig.blockSizeVertical,
                  ), // Calendar icon
                  SizedBox(
                      width: 2 *
                          SizeConfig
                              .blockSizeHorizontal), //ace between icon and date
                  Text(
                    '12/08/2020',
                    style: TextStyle(
                      fontSize: 10 * SizeConfig.blockSizeVertical,
                    ),
                  ),
                  SizedBox(width: 5 * SizeConfig.blockSizeHorizontal),
                  Icon(Icons.timer_outlined,
                      color: Color.fromARGB(209, 220, 65, 91),
                      size: 8), // Timer icon
                  SizedBox(
                      width: 2 *
                          SizeConfig
                              .blockSizeHorizontal), //// Space between icon and time
                  Text(
                    '11 pm',
                    style: TextStyle(
                        fontSize: 10 * SizeConfig.blockSizeVertical,
                        letterSpacing: -0.5),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget currentbooking() {
    return Container(
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromRGBO(246, 169, 191, 01),

          /// background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0),
            bottomLeft: Radius.circular(6.0),
          ),

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8 * SizeConfig.blockSizeVertical),
            Container(
                padding:
                    EdgeInsets.only(left: 15 * SizeConfig.blockSizeHorizontal),
                child: Stack(
                  alignment: Alignment
                      .center, // Aligns both the text and icon at the center
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Color.fromARGB(209, 220, 65, 91),
                      size: 25 * SizeConfig.blockSizeVertical,
                    ),
                    Positioned(
                      top:
                          10, // Adjust this value to control the vertical position of "01"
                      child: Text(
                        "01",
                        style: TextStyle(
                          fontSize: 8 *
                              SizeConfig
                                  .blockSizeVertical, // Adjust font size as needed
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.8,
                          color: Color.fromARGB(209, 220, 65, 91),
                        ),
                      ),
                    ),
                  ],
                )), // Cal),
            SizedBox(height: 10 * SizeConfig.blockSizeVertical),
            Container(
                margin:
                    EdgeInsets.only(left: 12 * SizeConfig.blockSizeHorizontal),
                child: Text(
                  "One Day Packages ",
                  style: TextStyle(
                    //  color: Color.fromARGB(255, 245, 109, 132),
                    fontSize: 9, // Font size
                    fontWeight: FontWeight.w500,
                  ),
                )),
            SizedBox(height: 3 * SizeConfig.blockSizeVertical),
            Container(
              margin:
                  EdgeInsets.only(left: 12 * SizeConfig.blockSizeHorizontal),
              child: Row(
                children: [
                  //ace between icon and date
                  Text(
                    'Lorem ipsum dolor sit ame',
                    style: TextStyle(
                        fontSize: 9.5 * SizeConfig.blockSizeVertical,
                        letterSpacing: -0.5),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget stackcurrentcurrentbooking() {
    return Container(
        height: 70,
        decoration: BoxDecoration(
          color: Color.fromRGBO(75, 132, 170, 0.8), //background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0),
          ),

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8 * SizeConfig.blockSizeVertical),
            Container(
                margin:
                    EdgeInsets.only(left: 15 * SizeConfig.blockSizeHorizontal),
                child: Stack(
                  alignment: Alignment
                      .center, // Aligns both the text and icon at the center
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white.withAlpha(190),
                      size: 25 * SizeConfig.blockSizeVertical,
                    ),
                    Positioned(
                      top:
                          10, // Adjust this value to control the vertical position of "01"
                      child: Text(
                        "03",
                        style: TextStyle(
                          fontSize: 8 *
                              SizeConfig
                                  .blockSizeVertical, // Adjust font size as needed
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.8,
                          color: Colors.white.withAlpha(190),
                        ),
                      ),
                    ),
                  ],
                )), // Cal),
            SizedBox(height: 8 * SizeConfig.blockSizeVertical),
            Container(
                margin:
                    EdgeInsets.only(left: 12 * SizeConfig.blockSizeHorizontal),
                child: Text(
                  "One Day Packages ",
                  style: TextStyle(
                      //  color: Color.fromARGB(255, 245, 109, 132),
                      fontSize: 9, // Font size
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.3),
                )),
            SizedBox(height: 3 * SizeConfig.blockSizeVertical),
            Container(
              margin:
                  EdgeInsets.only(left: 12 * SizeConfig.blockSizeHorizontal),
              child: Row(
                children: [
                  //ace between icon and date
                  Text(
                    'Lorem ipsum dolor sit ame',
                    style: TextStyle(
                        fontSize: 9.5 * SizeConfig.blockSizeVertical,
                        letterSpacing: -0.5),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget Profilecontainer() {
    return Row(
      children: [
        Container(
          width: 40.0, // Size of the CircleAvatar
          height: 40.0, // Size of the CircleAvatar
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
            radius: 20.0, // Adjust based on your container size
          ),
        ),
        SizedBox(width: 13), // Space between CircleAvatar and text
        // User name text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Emily Cysr',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(230, 219, 75, 99),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget booknany() {
    return Container(
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromRGBO(246, 169, 191, 01), //
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 25, top: 30), // Padding around the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Text
              Text(
                'Nanny And B',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15), // Space between the two texts
              // Second Text (Book Now)
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
        ));
  }

  Widget _buildDeviceBlock(assetPath, String label, Color colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 1),
        Icon(
          assetPath, // Replace with your specific icon
          size: 30 * SizeConfig.blockSizeVertical,
          color: colors,
        ),
        Text(
          label,
          style: TextStyle(
              color: colors, fontSize: 8 * SizeConfig.blockSizeVertical),
        ),
      ],
    );
  }
}
