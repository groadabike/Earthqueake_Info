//----------------------------------------------------------------------------
//
//  Earthquakes.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This Class save in a NSMutableArray a list of events.
//  Each event is a Object of EarthquakeEvent class.
//
//  The flow is; in Earthqueake's init or initWithMinMagnitud methods, the atribute
//  "listOfEvents" is filled by
//  an "Events" object.
//
//----------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "EarthquakeEvent.h"
#import "Events.h"


@interface Earthquakes : NSObject

@property (strong) NSMutableArray *listOfEvents;
@property (assign) int registers;

-(id)initWithMinMagnitud:(double)m;
-(id)initWithMinMagnitud:(double)m Lines:(int)lines;
-(id)initWithMinMagnitud:(double)m Country:(NSString*)c City:(NSString*)ci;
-(EarthquakeEvent*)getEventPosition:(int)pos;
-(NSMutableArray*) getListOfEvents;
-(int) countOfListOfEvents;
-(Boolean)existEvent:(NSString*)id;
-(id)initWithLines:(int)lines;

@end
