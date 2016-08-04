//
//  FirstScreenViewController.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// ----------------------------------
// ¦ViewController of the HomeScreen¦
// ----------------------------------

#import <UIKit/UIKit.h>
#import "LastEventsViewController.h"
#import "Earthquakes.h"
#import "ModalViewControllerDelegate.h"
#import "User.h"



@interface FirstScreenViewController : UIViewController <ModalViewControllerDelegate>

//  Button to Tabla of Last Events' Screen
@property IBOutlet UIButton *lastEventsButton;

//  Earthquake Object
//  This Object has a NSMutableArray with the selected Events
@property (strong) Earthquakes *earthquakes;

// *****new Lusia 11 Jan
@property (strong) UserData *userData;
@property (weak) IBOutlet UILabel *helloLabel;

@property (weak) User *myUser;
@property (assign) double mag;


@property (weak) IBOutlet UIBarButtonItem *Log;



//-(void) applicationDidEnterBackground:(UIApplication *)application;


// ******modified 11 jan Luisa
//  This methods are in blank
//  Declared just in case we need to implemented later
-(IBAction)lastEventsButtonPressed;

-(IBAction)logOff;



@end

