//
//  LastEventsViewController.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// ----------------------------------
// ¦ViewController of the LastEvents¦
// ----------------------------------

#import <UIKit/UIKit.h>
#import "Earthquakes.h"
#import "EarthquakeEvent.h"
#import "DetailViewController.h"
#import "ImageCreator.h"
#import "DateManage.h"
#import "SourceData_USGS.h"
#import "AppDelegate.h"


@interface LastEventsViewController : UITableViewController

@property (strong) NSMutableDictionary *dictionaryEarthquakes;
@property (weak) Earthquakes *earthquakes;
@property (strong) SourceData_USGS *sourceUSGS;
@property (strong) Earthquakes *nextEarthquakes;
@property (strong) NSArray *tableTitles;
@property (assign) int lines;
@property (assign) int origen;


@end
