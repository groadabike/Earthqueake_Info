//----------------------------------------------------------------------------
//
//  Events.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This is the Events class which inherite from Database_Abstract
//  in order to work with Events table from Database
//
//----------------------------------------------------------------------------

#import "Events.h"

@implementation Events

-(id) initWithEvents:(int)lines{
    self = [super init];
    if(self){
        [self readEventFromDatabaseWhereMagnitud:0.0 Country:nil City:nil Lines:lines];
    }
    return self;
}

-(id) initWithMinMagnitud:(double)m Lines:(int)lines{
    self = [super init];
    if(self){
        [self readEventFromDatabaseWhereMagnitud:m Country:nil City:nil Lines:lines];
    }
    return self;
}

-(id) initWithMinMagnitud:(double)m Country:(NSString *)c City:(NSString *)ci Lines:(int)lines{
    self = [super init];
    if (self) {
        [self readEventFromDatabaseWhereMagnitud:m Country:c City:ci Lines:lines];
    }
    return self;
}

-(Boolean) insertNewEvent:(EarthquakeEvent*)event{
    sqlite3 *database;
    // open the database
    if (sqlite3_open([self.databasePath UTF8String],&database)==SQLITE_OK){
        // make a compiled SQL statement for faster access
        self.sqlStatement =[NSString stringWithFormat:@"INSERT INTO Events VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"];
        sqlite3_stmt *compiledStatement;
        if (sqlite3_prepare_v2(database, [self.sqlStatement UTF8String], -1,&compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_bind_double(compiledStatement, 1, event.time);
            sqlite3_bind_double(compiledStatement, 2, event.latitude);
            sqlite3_bind_double(compiledStatement, 3, event.longitude);
            sqlite3_bind_double(compiledStatement, 4, event.depht);
            sqlite3_bind_double(compiledStatement, 5, event.magnitude);
            sqlite3_bind_text(compiledStatement, 6, [event.idEvent UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(compiledStatement, 7, [event.place UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(compiledStatement, 8, ""/*[event.date UTF8String]*/, -1, SQLITE_STATIC);
            sqlite3_bind_text(compiledStatement, 9, ""/*[event.hour UTF8String]*/, -1, SQLITE_STATIC);
            sqlite3_bind_text(compiledStatement, 10, [event.country UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(compiledStatement, 11, [event.city UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(compiledStatement, 12, [event.url UTF8String], -1, SQLITE_STATIC);
            if(sqlite3_step(compiledStatement)==SQLITE_DONE){
                //NSLog(@"done");
                [self updateDateTime:event.idEvent];
                sqlite3_finalize(compiledStatement);
                sqlite3_close(database);
                return true;
            }else{
                //NSLog(@"ERROR %@",event.idEvent);
                sqlite3_finalize(compiledStatement);
                sqlite3_close(database);
                return false;
            }
        }
    }
    sqlite3_close(database);
    return true;
}

-(void) updateDateTime:(NSString*)idEvent{
    sqlite3 *database;
    // open the database
    if (sqlite3_open([self.databasePath UTF8String],&database)==SQLITE_OK){
        // make a compiled SQL statement for faster access
        self.sqlStatement =[NSString stringWithFormat:@"UPDATE Events SET DateEvent = date(Time/1000 ,'unixepoch'), TimeEvent=time(Time/1000,'unixepoch') WHERE id = '%@'",idEvent ];
        sqlite3_stmt *compiledStatement;
        if (sqlite3_prepare_v2(database, [self.sqlStatement UTF8String], -1,&compiledStatement, NULL) == SQLITE_OK) {
            if(sqlite3_step(compiledStatement)==SQLITE_DONE){
                //NSLog(@"Updated Date/Time");
            }else{
                NSLog(@"Test Error");
            }
            sqlite3_finalize(compiledStatement);
        }
    }
    sqlite3_close(database);
    
}

-(void)readEventFromDatabaseWhereMagnitud:(double)m Country:(NSString *)country City:(NSString *)city Lines:(int)lines {
    sqlite3 *database;
    self.listOfEvents = [[NSMutableArray alloc]init];
    // open the database
    if (sqlite3_open([self.databasePath UTF8String],&database)==SQLITE_OK){
        // make a compiled SQL statement for faster access
        [self createSqlStatementWithMagnitude:m Country:country City:city Lines:lines];
        sqlite3_stmt *compiledStatement;
        if (sqlite3_prepare_v2(database, [self.sqlStatement UTF8String], -1,&compiledStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // read the data from the result row
                NSString *idEvent = [NSString stringWithUTF8String: (char*)sqlite3_column_text(compiledStatement, 0)];
                NSString *p = [NSString stringWithUTF8String: (char*)sqlite3_column_text(compiledStatement, 1)];
                double lat = sqlite3_column_double(compiledStatement, 2);
                double lon = sqlite3_column_double(compiledStatement, 3);
                double d = sqlite3_column_double(compiledStatement, 4);
                double m = sqlite3_column_double(compiledStatement, 5);
                double t = sqlite3_column_double(compiledStatement, 6);
                NSString *de = [NSString stringWithUTF8String: (char*)sqlite3_column_text(compiledStatement, 7)];
                NSString *h = [NSString stringWithUTF8String: (char*)sqlite3_column_text(compiledStatement, 8)];
                NSString *co = [NSString stringWithUTF8String: (char*)sqlite3_column_text(compiledStatement, 9)];
                NSString *ci = [NSString stringWithUTF8String: (char*)sqlite3_column_text(compiledStatement, 10)];
                NSString *u = [NSString stringWithUTF8String: (char*)sqlite3_column_text(compiledStatement, 11)];
                EarthquakeEvent *event = [[EarthquakeEvent alloc] initWithIdEvent:idEvent Place:p Latitude:lat Longitude:lon Depth:d Magnitude:m Time:t Date:de Hour:h Country:co City:ci URL:u];
                // add this object into the array
                [self.listOfEvents addObject:event];
            }
        }
        // release the compiled SQL statement from memory
        sqlite3_finalize(compiledStatement);
    }
    // close the database
    sqlite3_close(database);
}

-(NSString*)searchLastDate{
    sqlite3 *database;
    self.listOfEvents = [[NSMutableArray alloc]init];
    NSString *maxDate;
    // open the database
    if (sqlite3_open([self.databasePath UTF8String],&database)==SQLITE_OK){
        // make a compiled SQL statement for faster access
        self.sqlStatement = @"Select DateEvent from Events order by DateEvent desc limit 1";
        sqlite3_stmt *compiledStatement;
        if (sqlite3_prepare_v2(database, [self.sqlStatement UTF8String], -1,&compiledStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // read the data from the result row
                maxDate = [NSString stringWithUTF8String: (char*)sqlite3_column_text(compiledStatement, 0)];
            }
        }
        // release the compiled SQL statement from memory
        sqlite3_finalize(compiledStatement);
    }
    // close the database
    sqlite3_close(database);
    if(maxDate == nil){
        maxDate =@"1900-01-01";
    }
    return maxDate;
}

-(NSString*)searchFirstDate:(double)minMag{
    sqlite3 *database;
    self.listOfEvents = [[NSMutableArray alloc]init];
    NSString *maxDate;
    // open the database
    if (sqlite3_open([self.databasePath UTF8String],&database)==SQLITE_OK){
        // make a compiled SQL statement for faster access
        self.sqlStatement = [NSString stringWithFormat:@"Select DateEvent from Events  where Magnitude between %f and %f order by DateEvent asc limit 1", minMag, minMag+0.9];
        sqlite3_stmt *compiledStatement;
        if (sqlite3_prepare_v2(database, [self.sqlStatement UTF8String], -1,&compiledStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // read the data from the result row
                maxDate = [NSString stringWithUTF8String: (char*)sqlite3_column_text(compiledStatement, 0)];
            }
        }
        // release the compiled SQL statement from memory
        sqlite3_finalize(compiledStatement);
    }
    // close the database
    sqlite3_close(database);
    return maxDate;
}


-(void) createSqlStatementWithMagnitude:(double)m Country:(NSString*)country City:(NSString*)city Lines:(int)lines{
    
    NSString *searchCountry;
    NSString *searchCity;
    NSString *percentageSymbol = @"%";
    if ([country length] == 0) {
        searchCountry = percentageSymbol;
    }else{
        searchCountry = [NSString stringWithFormat:@"%@%@%@",percentageSymbol,country,percentageSymbol];
    }
    
    if ([city length] == 0) {
        searchCity = percentageSymbol;
    }else{
        searchCity = [NSString stringWithFormat:@"%@%@%@",percentageSymbol,city,percentageSymbol];
    }
    
    self.sqlStatement = [NSString stringWithFormat:@"select  id as idEvent, place, latitude, longitude, depth , magnitude , time, DateEvent, TimeEvent, Country, City, Url from Events where magnitude >=%f and country like '%@' and city like '%@' order by DateEvent desc, TimeEvent desc limit %d",m,searchCountry, searchCity, lines];
    
    /*if(m==0.0){
     self.sqlStatement =[NSString stringWithFormat:@"select id as idEvent, place, latitude, longitude, depth , magnitude , time, DateEvent, TimeEvent, Country, City, Url from Events order by DateEvent desc, TimeEvent desc limit %d",lines];
     
     }else{
     self.sqlStatement = [NSString stringWithFormat:@"select  id as idEvent, place, latitude, longitude, depth , magnitude , time, DateEvent, TimeEvent, Country, City, Url from Events where magnitude >=%f order by DateEvent desc, TimeEvent desc limit %d",m,lines];
     }*/
}

-(Boolean) eventExistInDatabaseID:(NSString*)idEvent{
    sqlite3 *database;
    int countEvents;
    // open the database
    if (sqlite3_open([self.databasePath UTF8String],&database)==SQLITE_OK){
        // make a compiled SQL statement for faster access
        self.sqlStatement = [NSString stringWithFormat:@"select count(id) as countEvents from Events where id = '%@'",idEvent];
        sqlite3_stmt *compiledStatement;
        if (sqlite3_prepare_v2(database, [self.sqlStatement UTF8String], -1,&compiledStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // read the data from the result row
                countEvents = sqlite3_column_int(compiledStatement, 0);
            }
        }
        // release the compiled SQL statement from memory
        sqlite3_finalize(compiledStatement);
    }
    // close the database
    sqlite3_close(database);
    if (countEvents == 0){
        return false;
    }else{
        return true;
    }
}

@end