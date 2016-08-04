//----------------------------------------------------------------------------
//
//  EarthquakeEvent.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//  This class contain the detail of each earthqueake event.
//
//----------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "Events.h"

@interface EarthquakeEvent : NSObject

@property (strong) NSString *idEvent;
@property (strong) NSString *place;
@property (assign) double   latitude;
@property (assign) double   longitude;
@property (assign) double   depht;
@property (assign) double   magnitude;
@property (assign) double   time;
@property (strong) NSString *date;
@property (strong) NSString *hour;
@property (strong) NSString *country;
@property (strong) NSString *city;
@property (strong) NSString *url;

-(id)initWithIdEvent: (NSString*)i Place: (NSString*)p Latitude:(double)lat Longitude:(double)lon Depth:(double)d Magnitude:(double)m Time:(double)da Date:(NSString*)de Hour:(NSString*)h Country:(NSString*)co City:(NSString*)ci URL:(NSString*)u;

-(void) saveEventDatabase;

@end