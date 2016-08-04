//
//  SearchEventsViewController.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// ------------------------------------
// ¦ViewController of the SearchScreen¦
// ------------------------------------


#import "SearchEventsViewController.h"

@interface SearchEventsViewController (){
    NSArray *pickerData;
}

@end

@implementation SearchEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.magnitudeMin setPlaceholder:@"Select Magnitude"];
    // Initialize Data
    pickerData =@[@"0.0",@"0.5",@"1.0",@"1.5",@"2.0",@"2.5",@"3.0",@"3.5",@"4.0",@"4.5",@"5.0",@"5.5",@"6.0",@"6.5",@"7.0",@"7.5",@"8.0",@"8.5"];
    
    // Connect Data
    self.picker.dataSource = self;
    self.picker.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    
    [self.country resignFirstResponder];
    [self.city resignFirstResponder];
    [self.magnitudeMin resignFirstResponder];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    double mag = [pickerData[row] floatValue];
    NSString *resultString = [[NSString alloc] initWithFormat:@"%.1f", mag];
    self.magnitudeMin.text = resultString;
}
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Te number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return pickerData[row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) searchEarthquakes{
    
    // In this moment only search for magnitude
    // This is one part that we must improve
    //self.earthquakes = [[Earthquakes alloc] initWithMinMagnitud:[self.magnitudeMin.text doubleValue]];
    self.earthquakes = [[Earthquakes alloc] initWithMinMagnitud:[self.magnitudeMin.text doubleValue] Country:self.country.text City:self.city.text];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Send search result to LastEventsViewController
    if ([[segue identifier] isEqualToString:@"goLastEventsFromSearch"]) {
        LastEventsViewController *controller = (LastEventsViewController *)segue.destinationViewController;
        [self searchEarthquakes];
        controller.earthquakes = self.earthquakes;
        controller.origen = 1;
    }
}


@end