//
//  Readme.h
//  CbaMentorAssignment
//
//  Created by Brian Anderson on 16/05/2017.
//  Copyright © 2017 Mark Varney. All rights reserved.
//


/*

Mark, good work so far. Here are a few suggestions, and answers to your questions:

1   Make the ios Deployment target 10.2 in project settings. I dont have the simulators for 10.3 and cant run up the app
2   Maybe worthwhile renaming the app to something like "TutorFinder" - your choice. See how you go. Its not that easy to rename an app. Search on Stack Overflow
3   In your storyboards, every VC is called ViewController, except the first, which is TableViewController. Make the VC names reflect what they do. Suggest you rename TableViewController to MenuViewController. And you'll also have MessageViewConroller, SearchViewController etc. You need to rename in several places. filename and references. Do a project wide search on tableviewcontroller
4   Making the keyboard disappear. Firstly you'll need to wire up the search view controller in the storyboard to a SearchViewController subclass of UIViewController. You'll need to get the actual typed in values into that VC. That will mean setting the UITexField delegate to your view controller. You can do this in the storyboard. When you are able to get input into the VC, take a look at [self.view endEditing: yes]; That should do the trick
 5  Dont worry about the login screens for now. We can add those later.
 6  Of your four menu options, think about which row you'll implement first. I think Search For Tutor since that will get us into the API, JSON, model objects etc. What's your preference?
 
 
May 22, 2017
 
 More good progress. Except for the map display I think the functionality is more or less right for MVP. As I see it there are 3 remaining things to do:
 
 1  Implement proper service call methodology using mock data to simulate how the real service would work over the network
 2  Implement the map screen
 3  Skin the product - ie apply fonts, colors, visual design to turn the current wireframe solution into a polished app.
 
 If we can pull these off, then you're over the line!
 
 I suggest we turn attention to (2) - service all implementation.Then (1), then (3)
 
 
 Mock data - service request:
 =============================
 
 The general principle is that view controllers should not access the service layer directly. We need to put a manager in place which the VC can call. The manager in turn will contact the service.
 
 The general flow is:
 
 a) VC asks the manager to rerieve list of tutor objects
 b) Manager formulates a the paramaters for the service and calls the service
 c) Service retrieves the data from the network as JSON and converts it to an array of dictionaries
 d) Manager converts the array of dictionaries into an array of strongly typed Tutor objects and passes these back to the VC
 e) VC displays on screen
 
To do this:
 
 a) create a Service class. This will consist only of class level calls +(void) returns instead of -(void) returns. Make sure you understand the difference
 
 b) in the service class, create a method with this signature:
 
 + (NSDictionary *)synchronousGetFromFile(NSString *endpoint)
 
 Here, endpoint is the name of a file to read from local data. It will look like eg, tutors-10-maths (find all maths tutors within 10 km)
 This function will interpret the endpoint as a filename (tutor-10-maths.json), will read the file into an NSData structure, then call NSJSONSerialization to convert the NSData to a dictionary. this dictionary is returned to the caller.
 
 You will need to create a json file as part of the project so it can be read. Dont forget to include this file in the target so it is part of the bundle The Json file will contain the array of tutors, in json format.

 See how you go with this. Get it to the point where a valid NSDictionary object is returned.
 
 
 c) the problem with the above function (as the name implies) is that it is a synchronous call. If you call this directly it will block the main thread and cause glitchy UI. You need to wrap this function in an asynchronous request. It will use a block handler signature. You'll need to do some reading on how blocks work.
 
 d) create a function in the service class with this signature:
 
 + (void)asynchronousGetFromFile(NSString *endpoint, completion: (void (^)(BOOL success, NSDictionary *json))completionHandler
 
 This function is going to use dispath_async to call the synchronous version in (b) above. It returns nothing. ( the return type is void) but when the data becomes available, it will call the completion handler as a function, by providing two parameters - a bool flag indicating success/ failure and if success, a json dictionary object. This function (the supplied completion handler block) will get executed 
 
 
 Thats a lot of learning. See if you can implement a and b to start, then we can discuss c in more detail. Hint - make up the Json file first up. File a PR so I can check if its valid json, then do the synchronous call.
 
 

 

 

 
 

 

 
 
 

 

 

 

 
 
 
 



 
 
 */
