//
//  SearchEventsViewController.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// ------------------------------------
// ¦ViewController of the SearchScreen¦
// ------------------------------------


#import <UIKit/UIKit.h>
#import "Earthquakes.h"
#import "LastEventsViewController.h"

@interface SearchEventsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property IBOutlet UITextField *magnitudeMin;
@property IBOutlet UIButton *search;
@property IBOutlet UITextField *country;
@property IBOutlet UITextField *city;

@property (weak) IBOutlet UIPickerView *picker;

@property (strong) Earthquakes *earthquakes;

-(void) searchEarthquakes;

@end
