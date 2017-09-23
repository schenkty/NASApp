# NASApp
Treehouse TechDegree Project #12

Your mission, should you choose to accept it, is to build an iOS app in Swift using the the NASA API. You need to implement two required features, and an optional one. We expect you to use different skills in different ways and encourage you to go above and beyond the requirements stated in terms of usage of APIs and iOS capabilities. This is the opportunity to make a really nice portfolio piece, and we hope you make it your own! While mockups are provided, they represent just one of the many possible ways the finished app could look. We hope you will get creative and base your layouts and design on the particular functionalities of your app.

Rover Postcard Maker: Access the Mars Rover Imagery API and display a selected, filtered, or randomized image from the Mars Rover.

Eye-In-the-Sky: Build a tool to access the Earth Imagery API and display a photo of a user specified area.

Optional Custom Feature: Create your own app feature using the NASA API! Get creative and showcase everything that you are able to do!

You can submit this project in either Swift 2.3 or Swift 3. If you are using Xcode 8.x and Swift 2.3, you will need to download and use the empty Swift 2.3 starter files template to start your project. (Xcode 8 might still prompt you to convert the starter file, if so, please select “convert” and “Swift 2.3”. It should then tell you that there is nothing that needs to be changed.)

The app must have a landing screen and 2 main areas, one for each of the functionalities described below.

Rover Postcard Maker: Access the Mars Rover Imagery API and display a selected, filtered, or randomized image from the Mars Rover. You should also build functionalities such that a user can add text over the image and then flatten the new image and send through a pre-populated email address (you may hard-code the email address). Please clearly indicate in a comment where this email address is in the code, such that the reviewer can alter it for testing.

Eye-In-the-Sky: Build a tool to access the Earth Imagery API. Users should be able to, at a minimum, query the most recent photo of a particular location on earth. You can also let the user search for an address, get the location information based on an interactive map, import addresses from contacts, or even another API (such as Foursquare).

The app MUST make use of UICollectionViews, ScrollViews, Animation, Unit Testing, and Error Handling.

In your implementation, be sure to utilize asynchronous networking code and where possible, make your code reusable for the different items you’ll be displaying.

Ensure that you implement Unit Testing to test the code which downloads and parses the data from the API. In addition, test any edge cases, such as not receiving latitude and longitude data.

If you use any third party libraries, please also include details in a readme.md file on how to install, configure, and load the third party libraries such that the project reviewer can configure it on their machine.

Ensure that your app performs well. You should test all functionalities in Xcode Instruments and describe what performance testing you did in a code comment in the AppDelegate.swift file

Since this is the capstone project, you will be graded on the following:
* Good Object Oriented Design and implementation (e.g. proper usage of classes, structs, composition, inheritance, protocols, and extensions)
* Efficient API consumption (e.g. Are asynchronous networking calls being used?)
* UI layout is clean and professional and user workflow is intuitive; App icon is setup properly
* Error handling is robust
* Sufficient Unit Testing is included
* App performance is good (e.g. User does not need to wait more than a couple of seconds for each action)
* Code is organized with with useful comments


# How to run
Run ``pod install`` then open xcodeworkspace
