//
//  PreferenceTableViewController.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// -----------------------------------------
// ¦ViewController of the Preference Screen¦
// -----------------------------------------


#import "PreferenceTableViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FirstScreenViewController.h"

#define RAD_TO_DEG(x) ((x)*180.0/M_PI)

@interface PreferenceTableViewController ()

@end

@implementation PreferenceTableViewController{
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _preUser = [[User alloc]init];
    NSArray *preferenceMenu1 = [NSArray arrayWithObjects:@"Magnitude",[NSString stringWithFormat:@"%0.1f",self.preUser.minMagn],nil];
    NSArray *preferenceMenu2 = [NSArray arrayWithObjects:@"Name",@"Country",@"City",nil];
    NSArray *preferenceMenu3 = [NSArray arrayWithObjects:@"Alarm",nil];
    NSArray *magnitudeMenu = [NSArray arrayWithObjects:@"",@"",nil];
    NSArray *userMenu = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",self.preUser.name],[NSString stringWithFormat:@"%@",self.preUser.country],[NSString stringWithFormat:@"%@",self.preUser.city],nil];
    NSArray *alarmMenu = [NSArray arrayWithObjects:@"Monitor earthquake",nil];
    self.moduleList =[NSArray arrayWithObjects:preferenceMenu1,preferenceMenu2,preferenceMenu3,nil];
    self.sectionsTitles = [NSArray arrayWithObjects:@"Min Magnitude Preference",@"User Information",@"Alarm" ,nil];
    
    self.sectionsLables = [NSArray arrayWithObjects:@"Choose the Magnitude, the lastEvents will only show the earthquke with magnitude larger than that after back to start page.",@"",@"Keep phone in the table, than open it, it will monitor the earthquake. Please keep the screen unlocked." ,nil];
    
    self.subTitleList = [NSArray arrayWithObjects:magnitudeMenu,userMenu,alarmMenu,nil];
    // create the switch button
    self.alarmS = 0;
    UISwitch *sbtn = [[UISwitch alloc] initWithFrame:CGRectMake(250, 448, 80, 60)];
    [sbtn addTarget:self action:@selector(onSwitch:) forControlEvents:UIControlEventTouchUpInside];
    self.alarmSwitch = sbtn;
    [self.view addSubview:self.alarmSwitch];
    
    //create text and save button
    UITextField *mT = [[UITextField alloc] initWithFrame:CGRectMake(220, 63, 60, 30)];
    [mT setKeyboardType:UIKeyboardTypeDecimalPad];
    [mT setBorderStyle:UITextBorderStyleRoundedRect];
    //[mT setBorderStyle:]
    //UIButton *mB = [[UIButton alloc] initWithFrame:CGRectMake(250, 200, 300, 220)];
    self.magSelected = mT;
    [self.view addSubview:self.magSelected];
    UIButton *mB = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mB.frame = CGRectMake(220, 96, 60, 60);
    [mB setTitle:@"Save" forState:UIControlStateNormal];
    [mB setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [mB setBackgroundImage:[UIImage imageNamed:@"button2.png"] forState:UIControlStateNormal];
    [mB addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    self.magButton = mB;
    
    
    [self.view addSubview:self.magButton];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void) onClick{
    [self.preUser saveMagnitude:[self.magSelected.text doubleValue] UserName:self.preUser.userName];
    //[self.preUser test];
    [self dismissKeyboard];
}

-(void)dismissKeyboard {
    
    [self.magSelected resignFirstResponder];
    
}

//***** Luisa 17/01/16
// Realise the Alarm window
-(void) updateInfo {
    CMDeviceMotion *motion = self.motionManager.deviceMotion;
    CMAttitude *attitude = motion.attitude;
    if (RAD_TO_DEG(attitude.roll)>2.0 || RAD_TO_DEG(attitude.roll)< -2.0|| RAD_TO_DEG(attitude.pitch)>2.0 ||RAD_TO_DEG(attitude.pitch)< -2.0) {
        NSLog(@"SHAKE!!!!");
        //NSLog([NSString stringWithFormat:@"ROLL=%1.2f",RAD_TO_DEG(attitude.roll)]);
        //NSLog([NSString stringWithFormat:@"PITCH=%1.2f",RAD_TO_DEG(attitude.pitch)]);
        
        
        //NSDate *fdate = [[NSDate alloc] initWithTimeIntervalSinceNow:1];
        //UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        //if (localNotification == nil) {
        //    return;
        //}
        //localNotification.fireDate = fdate;
        
        // we are unlikely to change time zone in 15 sec, but just in case...
        
        //localNotification.timeZone = nil;
        //localNotification.alertBody = @"EARTHQUAKE";
        //localNotification.alertAction = @"detail";
        //localNotification.alertLaunchImage = @"UMF_87.png";
        // set the sound music of notification
        //localNotification.soundName = UILocalNotificationDefaultSoundName;
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"EARTHQUAKE" message:@"UnderMyFeet feels there is a eathquake!!!!" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"OK", nil];
        [alertview show];
        AudioServicesPlaySystemSound(1005);
        //[self presentViewController:alertDialog animated:YES completion:nil];
        // set the about information of notification
        //NSDictionary *infoDic = [NSDictionary dictionaryWithObjects: LOCAL_NOTIFY-SCHEDULE-ID, @"id"];
        //localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
        // get a information immediatly
        //[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        //[alertview release];
    }
}

- (void)onSwitch:(id *)sender
{
    
    // to initial the function to monitor the shake of phone
    if (self.alarmS == 0) {
        self.motionManager = [[CMMotionManager alloc]init];
        if (self.motionManager.deviceMotionAvailable) {
            self.motionManager.deviceMotionUpdateInterval = 0.1;
            [self.motionManager startDeviceMotionUpdates];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateInfo) userInfo:nil repeats:YES];
        
        } else {
            NSLog(@"No device motion available");
            self.motionManager = nil;
        }
        self.alarmS = 1;
    }
    else{
        
        self.motionManager = nil;
        //doeset start it
        self.alarmS = 0;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.moduleList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.moduleList objectAtIndex:section]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *myIdentifier = @"myIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
    }
    
    cell.textLabel.text = [[self.moduleList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    cell.detailTextLabel.text = [[self.subTitleList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
   
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionsTitles objectAtIndex:section];
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [self.sectionsLables objectAtIndex:section];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
