//
//  DetailViewController.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// --------------------------------------
// ¦ViewController of the Details Screen¦
// --------------------------------------


#import <UIKit/UIKit.h>
#import "EarthquakeEvent.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Social/Social.h>


@interface DetailViewController : UIViewController <MKMapViewDelegate>{
    IBOutlet UIButton *twitterButton;
    IBOutlet UIButton *facebookButton;
    IBOutlet SLComposeViewController *twitter;
    IBOutlet SLComposeViewController *facebook;
}

@property (strong, nonatomic) EarthquakeEvent *detailItem;

@property (weak) IBOutlet MKMapView *map;
@property (weak) IBOutlet UISegmentedControl *mapType;

@property (weak) IBOutlet UILabel *country;
@property (weak) IBOutlet UILabel *city;
@property (weak) IBOutlet UILabel *date;
@property (weak) IBOutlet UILabel *time;
@property (weak) IBOutlet UILabel *magnitude;
@property (weak) IBOutlet UILabel *latitude;
@property (weak) IBOutlet UILabel *longitude;
@property (weak) IBOutlet UILabel *depht;


- (void)setDetailItem:(EarthquakeEvent*)newDetailItem;
- (IBAction) travelToLatitude:(double)lat Longitude:(double)lon Magnitude:(double)mag;
//- (IBAction) changeMapType;
- (IBAction)moreDetailURL;
- (IBAction)newsURL;
- (IBAction)sendTweet:(id)sender;



@end
