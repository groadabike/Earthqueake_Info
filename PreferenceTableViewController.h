//
//  PreferenceTableViewController.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// -----------------------------------------
// ¦ViewController of the Preference Screen¦
// -----------------------------------------


#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "User.h"
#import "AppDelegate.h"

@interface PreferenceTableViewController : UITableViewController

@property (strong) NSArray *moduleList;
@property (strong) NSArray *sectionsTitles;
@property (strong) NSArray *sectionsLables;
@property (strong) NSArray *subTitleList;

@property (strong) User *preUser;

@property (strong) CMMotionManager *motionManager;
@property (strong) NSTimer *timer;
@property (strong) UISwitch *alarmSwitch;
@property (assign) int alarmS;
@property (weak) IBOutlet UITextField *magSelected;
@property (strong) UIButton *magButton;

-(void) updateInfo;

@end
