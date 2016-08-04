//
//  FirstScreenViewController.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// ----------------------------------
// ¦ViewController of the HomeScreen¦
// ----------------------------------


#import "FirstScreenViewController.h"
#import "LoginViewController.h"
#import "TabVarController.h"




@interface FirstScreenViewController ()

@end

@implementation FirstScreenViewController

// ******17 jan Luisa
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userData = [[UserData alloc]init];
    _mag = self.myUser.minMagn;
    
    [self update:0];
}

//-(void) applicationDidEnterBackground:(UIApplication *)application{
//        self.motionManager = [[CMMotionManager alloc]init];
//    if (self.motionManager.deviceMotionAvailable) {
//        self.motionManager.deviceMotionUpdateInterval = 0.1;
//        [self.motionManager startDeviceMotionUpdates];
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateInfo) userInfo:nil repeats:YES];
//        
//    } else {
//        NSLog(@"No device motion available");
//        self.motionManager = nil;
//    }
//}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ///////???????????????????/////////
//    if (self.userData.idUser !=-1000) {
//        self.userData.logged = 0;
//    }
    if ([[segue identifier]isEqualToString:@"goLogin"]) {
        NSString *logTitle = self.Log.title;
        if ([logTitle isEqualToString:@"Log In"]) {
            LoginViewController *vc = [segue destinationViewController];
            vc.userData = self.userData;
            vc.delegate = self;
        }
        else{
            LoginViewController *vc = [segue destinationViewController];
            vc.userData = self.userData;
            vc.delegate = self;
            [self.userData updateLogged:0 username:self.userData.userName];
            [self update:1];
        }
    }
    if ([[segue identifier] isEqualToString:@"goTabBar"]) {
        //TabVarController *controller = (TabVarController *)segue.destinationViewController;
        //controller.earthquakes = self.earthquakes;
        TabVarController *tabar=segue.destinationViewController;
        LastEventsViewController *controller=[tabar.viewControllers objectAtIndex:0];
        controller.earthquakes = self.earthquakes;
    }

    /*if ([[segue identifier] isEqualToString:@"goLastEvents"]) {
        LastEventsViewController *controller = (LastEventsViewController *)segue.destinationViewController;
            controller.earthquakes = self.earthquakes;
    
    }*/
}

-(void)update:(int)upda {
    /*if (self.userData.authorized)
        self.helloLabel.text = [@"Authorized user: " stringByAppendingString:self.userData.username];
    else
        self.helloLabel.text = @"Nobody logged in";
     */
    User *u =[[User alloc] init];
    if (upda ==1){
        
        self.myUser=u;
    }
    
    
    if(self.myUser.idUser == -1000){
        self.helloLabel.text = @"Nobody logged in";
        self.Log.title = @"Log In";
    }else{
        self.helloLabel.text = [@"Hello: " stringByAppendingString:self.myUser.name];
        NSLog(@"User logged: %@", self.myUser.name);
        self.Log.title = @"Log Off";
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)lastEventsButtonPressed{
    Boolean again = true;
    User *userTemp = [[User alloc]init];
    
    int tries = 0;
    while (again && tries<3){
        self.earthquakes = nil;
        self.earthquakes = [[Earthquakes alloc] initWithMinMagnitud:userTemp.minMagn];
        if ([self.earthquakes countOfListOfEvents] ==0){
            [NSThread sleepForTimeInterval:2];
            tries++;
        }else{
            again = false;
        }
    }
    self.myUser.minMagn=userTemp.minMagn;
    //Add action for this Button
    
}

-(IBAction)logOff{
    //User *u =[[User alloc] init];
    //[self updateLogged:1 id:num database:database];
        self.helloLabel.text = @"Nobody logged in";
        NSLog(@"XXX");
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    //  Pass data from FirstScreenViewController to LastEventsViewController
//    if ([[segue identifier] isEqualToString:@"goLastEvents"]) {
//        LastEventsViewController *controller = (LastEventsViewController *)segue.destinationViewController;
//        controller.earthquakes = self.earthquakes;
//    }
//}



@end
