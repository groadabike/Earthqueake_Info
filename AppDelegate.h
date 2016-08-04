//
//  AppDelegate.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// --------------------
// ¦App Delegate file ¦
// --------------------


#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "EarthquakeEvent.h"
#import "Earthquakes.h"
#import <CoreData/CoreData.h>
#import "FirstScreenViewController.h"
#import "User.h"
#import "SourceData_USGS.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) Earthquakes *earthquakes;
@property (strong) SourceData_USGS *sourceUSGS;
@property (strong) User *myUser;

@end

