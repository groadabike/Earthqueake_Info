//----------------------------------------------------------------------------
//
//  SourceData_USGS.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This class is an implementation of the abstract class SourceData_Abstract.
//  The sourceData is the database of USGS - U.S. Geological Survey.
//  For more info about the webservice of this source go to
//  http://earthquake.usgs.gov/fdsnws/event/1/
//
//  The overwrited method "searchData" request data to USGS and save it into "receivedData" atribute.
//  The overwrited method "saveData" take the data into "reciebedData" and save it into the events table of
//  UnderMyFeet.sql Database.
//
//  Description of the data from dictionary [Features : propierties] from Json - USGS
//
//  field:      |Original type   |SQLite type in Database
//  -----       |-------------   |-----------------------
//  mag:        |Decimal         |DOUBLE
//  place:      |String          |VARCHAR
//  time:       |Long Integer    |VARCHAR
//  updated:    |Long Integer    |VARCHAR
//  tz:         |Integer         |----------
//  url:        |String          |VARCHAR
//  detail:     |String          |----------
//  felt:       |Integer         |----------
//  cdi:        |Decimal         |----------
//  mmi:        |Decimal         |----------
//  alert:      |String          |----------
//  status:     |String          |----------
//  tsunami:    |Integer         |----------
//  sig:        |Integer         |----------
//  net:        |String          |VARCHAR
//  code:       |String          |----------
//  ids:        |String          |----------
//  sources:    |String          |----------
//  types:      |String          |----------
//  nst:        |Integer         |INTEGER
//  dmin:       |Decimal         |DOUBLE
//  rms:        |Decimal         |DOUBLE
//  gap:        |Decimal         |DOUBLE
//  magType:    |String          |VARCHAR
//  type:       |String          |VARCHAR
//
//  Description of the data from array [Features : geometry : coordinates] from Json - USGS
//
//  field       |SQLite type in Database
//  -----       |-----------------------
//  longitude   |DOUBLE
//  latitude    |DOUBLE
//  depth       |DOUBLE
//
//  Description of the data from [Features : id] from Json - USGS
//
//  field       |SQLite type in Database
//  -----       |-----------------------
//  id          |VARCHAR
//
//----------------------------------------------------------------------------

#import "SourceData_USGS.h"

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

@implementation SourceData_USGS

//  Gerardo Roa Dabike - 11/01/2016
//  Implementation of "searchData" method

-(void) searchData{
    NSLog(@"Contacting USGS...");
    
    // create NSURL from the formatted string
    NSURL *url = [NSURL URLWithString:self.webURL];
    
    // setup and start asynchronous download
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    // the pragma sentences are used to ignore one warning of deprecated function
    NSURLConnection *cn = [NSURLConnection connectionWithRequest:request delegate:self];
    [cn start];
}


//  Gerardo Roa Dabike - 11/01/2016
//  Implementation of "saveData" method
-(void) saveData {
    // store the received data into a String
    NSError* error;
    // create a dictionary from the JSON string
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:&error];
    
    // the dictonary contain 4 enties and the detail is explained in
    // http://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php
    // build an array for easy access to each event from the "features" dictionary
    NSDictionary *features= [results objectForKey:@"features"];
    // each features is also a dictionary
    // now we iterate through features and save each event into the database

    
    for (NSDictionary *feature in features) {
        // Save Id
        NSString *id1 = [feature objectForKey:@"id"];
        
        // Call method here
        
        EarthquakeEvent *event   = [[EarthquakeEvent alloc] init];
        NSDictionary *properties = [feature objectForKey:@"properties"];
        event.idEvent            = id1;
        event.magnitude          = [[properties objectForKey:@"mag"] doubleValue];
        event.place              = [properties objectForKey:@"place"];
        event.time               = [[properties objectForKey:@"time"] doubleValue];
        event.url                = [properties objectForKey:@"url"];
        
        // Save Country and City from location
        // Exits more than 1 format for this field
        NSArray *array =[event.place componentsSeparatedByString:@","];
        if ([array count]==2){
            event.country   = [[array objectAtIndex:1] stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
            array =[[[array objectAtIndex:0] stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceCharacterSet]] componentsSeparatedByString:@"of"];
            if ([array count]==2){
                event.city = [[array objectAtIndex:1] stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceCharacterSet]];
            }else{
                event.city = [[array objectAtIndex:0] stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceCharacterSet]];
            }
        }else{
            event.country   = [[array objectAtIndex:0] stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
            event.city = @"--";
        }
        // Save location
        NSArray *coordinate = [[feature objectForKey:@"geometry"] objectForKey:@"coordinates"];
        event.longitude    = [[coordinate objectAtIndex:0] doubleValue];
        event.latitude     = [[coordinate objectAtIndex:1] doubleValue];
        event.depht        = [[coordinate objectAtIndex:2] doubleValue];
        [event saveEventDatabase];
    }
    

    
}

@end