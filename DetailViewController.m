//
//  DetailViewController.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// --------------------------------------
// ¦ViewController of the Details Screen¦
// --------------------------------------

#import "DetailViewController.h"




@interface DetailViewController ()
- (void)configureView;


@end

@implementation DetailViewController

-(IBAction)sendTweet:(id)sender{
    
    NSString *defaultTweet = [NSString stringWithFormat:@"An earthquake magnitude %0.1f just occur in %@,%@. - More info in %@",self.detailItem.magnitude,self.detailItem.city,self.detailItem.country,self.detailItem.url];
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        twitter = [[SLComposeViewController alloc] init];
        twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitter setInitialText:defaultTweet];
        [self presentViewController:twitter animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"No twitter account is set up in this device" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    
}

-(IBAction)sendFacebook:(id)sender{
    
    NSString *defaultTweet = [NSString stringWithFormat:@"An earthquake magnitude %0.1f just occur in %@,%@. - More info in %@",self.detailItem.magnitude,self.detailItem.city,self.detailItem.country,self.detailItem.url];
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        facebook = [[SLComposeViewController alloc] init];
        facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebook setInitialText:defaultTweet];
        [self presentViewController:facebook animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"No facebook account is set up in this device" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    
}
- (void)setDetailItem:(EarthquakeEvent*)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

//******************* modified by Luisa 16/01/16
// to show the detail information one by one
- (void)configureView
{
    // Update the user interface for the detail item.
    NSLog(@"%@",self.detailItem.idEvent);
    
    if (self.detailItem) {
        //self.idEvent.text = self.detailItem.idEvent;
        //self.place.text = self.detailItem.place;
        self.country.text = self.detailItem.country;
        self.city.text = self.detailItem.city;
        self.date.text = self.detailItem.date;
        self.time.text = self.detailItem.hour;
        self.latitude.text = [NSString stringWithFormat:@"%0.1f",self.detailItem.latitude];
        self.longitude.text = [NSString stringWithFormat:@"%0.1f",self.detailItem.longitude];
        self.depht.text = [NSString stringWithFormat:@"%0.2f",self.detailItem.depht];
        self.magnitude.text = [NSString stringWithFormat:@"%0.1f",self.detailItem.magnitude];
//        self.time.text = self.detailItem.time;
        [self travelToLatitude:self.detailItem.latitude Longitude:self.detailItem.longitude Magnitude:self.detailItem.magnitude];

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Detail Info";
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) travelToLatitude:(double)lat Longitude:(double)lon Magnitude:(double)mag{
    // this is the latitude and longditude of DCS
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lon);
    // specify that we want the center to be coord and show the surrounding 500Km metres
    // in latitude and longditude
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500000, 500000);
    // move there, with animation from current location
    [self.map setRegion:region animated:YES];
    
    MKPointAnnotation* point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(lat, lon);
    [point setTitle:[NSString stringWithFormat:@"Magnitude: %0.1f",self.detailItem.magnitude]];
    [point setSubtitle:[NSString stringWithFormat:@"Depht: %0.2f",self.detailItem.depht]];
     self.map.mapType=MKMapTypeHybrid;
    [self.map addAnnotation:point];
    
}

- (IBAction)moreDetailURL {
    //NSString *textURL = @"http://www.usgs.gov";
    NSString *textURL = self.detailItem.url;

    NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", textURL]];
    [[UIApplication sharedApplication] openURL:cleanURL];
}

- (IBAction)newsURL {
    NSString *textURL = [NSString stringWithFormat: @"%s%0.1f%s%@%s%@%s%@", "http://www.google.co.uk/search?q=earthquake+",self.detailItem.magnitude,"+",[self.detailItem.city stringByReplacingOccurrencesOfString:@" " withString:@"%20"],"+",[self.detailItem.country stringByReplacingOccurrencesOfString:@" " withString:@"%20"],"+",self.detailItem.date];
    
    NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", textURL]];
    [[UIApplication sharedApplication] openURL:cleanURL];
    NSLog(@"%@",textURL);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    NSString *annotationIdentifier = @"CustomViewAnnotation";
    MKAnnotationView* annotationView = [self.map dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if(!annotationView)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:annotationIdentifier];
    }
    annotationView.image = [UIImage imageNamed:@"UMF_pin50.png"];
    annotationView.canShowCallout= YES;
    
    return annotationView;
}


/*-(IBAction) changeMapType {
    // change between different map views
    switch (self.mapType.selectedSegmentIndex) {
        case 0: // map
            self.map.mapType=MKMapTypeStandard;
            break;
        case 1: // satellite
            self.map.mapType=MKMapTypeSatellite;
            break;
        case 2: // hybrid
            self.map.mapType=MKMapTypeHybrid;
            break;
    }
}*/



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
