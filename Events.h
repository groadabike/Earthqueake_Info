//----------------------------------------------------------------------------
//
//  Events.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This is the Events class which inherite from Database_Abstract
//  in order to work with Events table from Database
//
//----------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "Database_Abstract.h"
#import "EarthquakeEvent.h"

@class EarthquakeEvent;

@interface Events : Database_Abstract

@property (strong) NSMutableArray *listOfEvents;

-(id) initWithEvents:(int)lines;
-(id) initWithMinMagnitud:(double)m Country:(NSString*)c City:(NSString*)ci Lines:(int)lines;
-(void)readEventFromDatabaseWhereMagnitud:(double)m Country:(NSString*)country City:(NSString*)city Lines:(int)lines;
//-(void) createSqlStatementWithMagnitude:(double)m Lines:(int)lines;
-(Boolean) insertNewEvent:(EarthquakeEvent*)event;
-(Boolean) eventExistInDatabaseID:(NSString*)idEvent;
-(NSString*)searchLastDate;
-(NSString*)searchFirstDate:(double)minMag;

@end