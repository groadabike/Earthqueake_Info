//
//  AppDelegate.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// --------------------
// ¦App Delegate file ¦
// --------------------


#import "AppDelegate.h"
#import "DateManage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDate *today = [NSDate date];
    NSDate *twoWeeks  = [today dateByAddingTimeInterval: -604800.0];
    NSString *maxDate = [[[Events alloc] init] searchLastDate];
    self.myUser = [[User alloc]init];
    NSString *stringTwoWeeks = [[[DateManage alloc] initWithDate:twoWeeks] getDateFormated];
    NSArray *myArray = [[NSArray alloc] initWithObjects:maxDate,stringTwoWeeks, nil];
    NSString *finalMaxDate =[myArray valueForKeyPath:@"@max.self"];
        
    NSString *url = [NSString stringWithFormat:@"http://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=%@&minmagnitude=%0.1f",finalMaxDate,0.0/*self.myUser.minMagn*/];
    NSLog(@"Preparing for Download data from %@", url);
    
    //  Instance of FirstScreenViewController
    UINavigationController *navController = (UINavigationController*)self.window.rootViewController;
    FirstScreenViewController *firstScreen = [navController.viewControllers objectAtIndex:0];
   
    
    self.sourceUSGS = [[SourceData_USGS alloc] initWithWebURL:url];
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    [self.sourceUSGS searchData];
    //});
    
    //  Read from Database all the data of las events and passed to FirstScreenViewController
//    Boolean again = true;
//    
//    int tries = 0;
//    while (again && tries<3){
//        self.earthquakes = nil;
//        self.earthquakes = [[Earthquakes alloc] initWithMinMagnitud:self.myUser.minMagn];
//        if ([self.earthquakes countOfListOfEvents] ==0){
//            [NSThread sleepForTimeInterval:2];
//            tries++;
//        }else{
//            again = false;
//        }
//    }
//    firstScreen.earthquakes = [[Earthquakes alloc] init];
//    firstScreen.earthquakes=self.earthquakes;
    firstScreen.myUser = self.myUser;
    
    
    return YES;
}


-(NSString*)getDateFormated:(NSDate*)date{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.

}

@end
