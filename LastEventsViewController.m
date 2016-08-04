//
//  LastEventsViewController.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// ----------------------------------
// ¦ViewController of the LastEvents¦
// ----------------------------------

#import "LastEventsViewController.h"


// Ignored warning for deprecated "UISearchDisplayController"
// and "searchDisplayController"
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

@interface LastEventsViewController ()

@end

@implementation LastEventsViewController

NSArray *searchResults;
NSMutableDictionary *searchResultDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dictionaryEarthquakes = [[NSMutableDictionary alloc]init];
    [self makeDictionary:self.earthquakes];
    
    
    // Do any additional setup after loading the view.
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

-(void)makeDictionary:(Earthquakes*)earthquakes{
    [self.dictionaryEarthquakes removeAllObjects];
    for (int i=0 ; i < [earthquakes countOfListOfEvents] ; i++){
        EarthquakeEvent *tempEvent = [earthquakes getEventPosition:i];
        if ([[self.dictionaryEarthquakes allKeys] containsObject:tempEvent.date]) {
            NSMutableArray *quakeArray = [self.dictionaryEarthquakes objectForKey:tempEvent.date];
            [quakeArray addObject:tempEvent];
            self.dictionaryEarthquakes[tempEvent.date] = quakeArray;
        }else{
            self.dictionaryEarthquakes[tempEvent.date] = [[NSMutableArray alloc] initWithObjects:tempEvent, nil];
        }
    }
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"" ascending:NO];
    self.tableTitles = [[self.dictionaryEarthquakes allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    //NSLog(@"%@",self.dictionaryEarthquakes);
}

-(void)refreshData{
    NSDate *today = [NSDate date];
    NSString *url = [NSString stringWithFormat:@"http://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=%@&minmagnitude=%0.1f",[[[DateManage alloc] initWithDate:today] getDateFormated],0.0];
    NSLog(@"Preparing for Download data from %@", url);
    self.sourceUSGS = [[SourceData_USGS alloc] initWithWebURL:url];
    [self.sourceUSGS searchData];
    self.nextEarthquakes = [[Earthquakes alloc] init];
    self.earthquakes = self.nextEarthquakes;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Table have only one section
    //  We can try to create more sections, separated by magnitude
    // one from lower then 4 another 4-5 another to 5-6 and so on
    return [self.tableTitles count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.tableTitles objectAtIndex:section];
}
// For right index table, but notsuitable here, text too long
/*- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
 return self.tableTitles;
 }*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //  Rows in a table
    //return [self.earthquakes countOfListOfEvents];
    
    // Gerardo Roa - 16-01-2016
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        //return [searchResults count];
        NSString *sectionTitle = [self.tableTitles objectAtIndex:section];
        NSArray *sectionDate = [searchResultDictionary objectForKey:sectionTitle];
        return [sectionDate count];
        
    } else {
        NSString *sectionTitle = [self.tableTitles objectAtIndex:section];
        NSArray *sectionDate = [self.dictionaryEarthquakes objectForKey:sectionTitle];
        return [sectionDate count];
        
        //return [self.earthquakes countOfListOfEvents];
    }
    //End change
}

//******Modified Luisa 18/01/16
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    //cell.textLabel.textAlignment = UITextAlignmentRight;
    cell.textLabel.font = [UIFont fontWithName:@"STHeitiK-Medium" size:14.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
    if(cell==nil){
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //gerardo Roa 16-01-2016
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelected:true animated:true];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
//        cell.textLabel.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldItalicMT" size:12.0];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:9.0];
        
        //end change
    }
    
    // Change Gerardo Roa  16-01-206
    EarthquakeEvent *event = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        //event = [searchResults objectAtIndex:indexPath.row];
        NSString *sectionTitle = [self.tableTitles objectAtIndex:indexPath.section];
        NSArray *sectionDate = [searchResultDictionary objectForKey:sectionTitle];
        event = [sectionDate objectAtIndex:indexPath.row];
    } else {
        NSString *sectionTitle = [self.tableTitles objectAtIndex:indexPath.section];
        NSArray *sectionDate = [self.dictionaryEarthquakes objectForKey:sectionTitle];
        event = [sectionDate objectAtIndex:indexPath.row];
        //event = [[self.earthquakes getListOfEvents] objectAtIndex:indexPath.row];
    }
    // end change
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",event.city,event.country];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",event.date,event.hour];
    ImageCreator *myImage = [[ImageCreator alloc] initWithText:(double)event.magnitude];
    cell.imageView.image = myImage.image;
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //  Send selected object from the table to a DetailViewController
    if ([[segue identifier] isEqualToString:@"goEventDetails"]) {
        NSIndexPath *indexPath;
        if (self.searchDisplayController.active){
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        }else{
            indexPath = [self.tableView indexPathForSelectedRow];
        }
        
        DetailViewController *controller = (DetailViewController *)segue.destinationViewController;
        
        //Gerardo Roa 16-012016
        EarthquakeEvent *object = nil;
        if (self.searchDisplayController.active){
            //event = [searchResults objectAtIndex:indexPath.row];
            NSString *sectionTitle = [self.tableTitles objectAtIndex:indexPath.section];
            NSArray *sectionDate = [searchResultDictionary objectForKey:sectionTitle];
            object = [sectionDate objectAtIndex:indexPath.row];
        } else {
            NSString *sectionTitle = [self.tableTitles objectAtIndex:indexPath.section];
            NSArray *sectionDate = [self.dictionaryEarthquakes objectForKey:sectionTitle];
            object = [sectionDate objectAtIndex:indexPath.row];
            //event = [[self.earthquakes getListOfEvents] objectAtIndex:indexPath.row];
        }
        /*if (self.searchDisplayController.active) {
         indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
         object = [searchResults objectAtIndex:indexPath.row];
         } else {
         indexPath = [self.tableView indexPathForSelectedRow];
         object = [self.earthquakes getEventPosition:(int)indexPath.row];
         }*/
        //end change
        [controller setDetailItem:object];
    }
}

// Gerardo Roa 16-01-2016
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//  return 50;
//}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
    double mag = [searchText doubleValue];
    NSPredicate *resultPredicate;
    if (mag == 0.0){
        resultPredicate = [NSPredicate predicateWithFormat:@"country contains[c] %@ or city contains[c] %@", searchText, searchText];
    }else{
        resultPredicate = [NSPredicate predicateWithFormat:@"magnitude>=%f", mag];
    }
    searchResults = [self.earthquakes.listOfEvents filteredArrayUsingPredicate:resultPredicate];
    
    searchResultDictionary = [[NSMutableDictionary alloc] init];
    
    [searchResultDictionary removeAllObjects];
    for (int i=0 ; i < [searchResults count] ; i++){
        EarthquakeEvent *tempEvent = [searchResults objectAtIndex:i];
        if ([[searchResultDictionary allKeys] containsObject:tempEvent.date]) {
            NSMutableArray *quakeArray = [searchResultDictionary objectForKey:tempEvent.date];
            [quakeArray addObject:tempEvent];
            searchResultDictionary[tempEvent.date] = quakeArray;
        }else{
            searchResultDictionary[tempEvent.date] = [[NSMutableArray alloc] initWithObjects:tempEvent, nil];
        }
    }
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Find the selected cell in the usual way
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (self.searchDisplayController.active){
        cell =  [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
    }else{
        cell =  [self.tableView cellForRowAtIndexPath:indexPath];
    }
    // Check if this is the cell I want to segue from by using the reuseIdenifier
    // which I set in the "Identifier" field in Interface Builder
    if ([cell.reuseIdentifier isEqualToString:@"Cell"]) {
        if (self.searchDisplayController.active) {
            [self performSegueWithIdentifier:@"goEventDetails" sender:cell];
        }
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.origen ==0) {
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
           NSLog(@"Scroll End Called");
           [self fetchMoreEntries];
        }
    }
    
}
-(void) fetchMoreEntries{
    [self loadHistory];
    User *uTemp = [[User alloc]init];
    self.nextEarthquakes = [[Earthquakes alloc] init];
    self.earthquakes = self.nextEarthquakes;
    if ( self.lines == 0) self.lines=50;
    self.lines+=50;    
    NSLog(@"Loading with %d the table view",self.lines);
    self.nextEarthquakes = [[Earthquakes alloc] initWithMinMagnitud:uTemp.minMagn Lines:self.lines];
    self.earthquakes = self.nextEarthquakes;
    
    [self makeDictionary:self.nextEarthquakes];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"" ascending:NO];
    self.tableTitles = [[self.dictionaryEarthquakes allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    [self.tableView reloadData];
    
}

-(void)loadHistory{
    NSString *minDateDatabase = [[[Events alloc] init] searchFirstDate:0.0];
    
    // DateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyy-MM-dd"];
    // Date minDateTable minus one day
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:minDateDatabase];
    
    NSString *minDateInTable = [self.tableTitles valueForKeyPath:@"@min.self"];
    NSDate *minDateinTableDate = [[NSDate alloc] init];
    minDateinTableDate = [dateFormatter dateFromString:minDateInTable];
    
    NSTimeInterval secondsBetween = [minDateinTableDate timeIntervalSinceDate:dateFromString];
    int numberOfDays = secondsBetween / 86400;
    NSLog(@"Min Date in Table %@",minDateInTable);
    NSLog(@"Min Date in Database %@",minDateDatabase);
    
    if(numberOfDays > 7){
        NSLog(@"No need to download more history");
        return;
    }
    NSLog(@"Go to USGS to download one more day");
    
    NSDate *dateFromString2 = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:minDateDatabase];
    dateFromString2 = [dateFromString dateByAddingTimeInterval: -86400.0];
    NSString *minDateSearch = [dateFormatter stringFromDate:dateFromString2];
    NSString *maxDateSearch = [dateFormatter stringFromDate:dateFromString];
    NSString *url = [NSString stringWithFormat:@"http://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=%@&endtime=%@&minmagnitude=%0.1f",minDateSearch,maxDateSearch,0.0];
    NSLog(@"Preparing for Download data from %@", url);
    self.sourceUSGS = [[SourceData_USGS alloc] initWithWebURL:url];
    [self.sourceUSGS searchData];
    self.nextEarthquakes = [[Earthquakes alloc] init];
    self.earthquakes = self.nextEarthquakes;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}
@end