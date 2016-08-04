//----------------------------------------------------------------------------
//
//  Earthquakes.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This Class save in a NSMutableArray a list of events.
//  Each event is a Object of EarthquakeEvent class.
//
//  The flow is; in Earthqueake's init or initWithMinMagnitud methods, the atribute
//  "listOfEvents" is filled by an "Events" object.
//
//----------------------------------------------------------------------------

#import "Earthquakes.h"

@implementation Earthquakes

-(id)init{
    self = [super init];
    if(self){
        Events *event = [[Events alloc] initWithEvents:50];
        self.listOfEvents = event.listOfEvents;
    }
    return self;
}

-(id)initWithLines:(int)lines{
    self = [super init];
    if(self){
        Events *event = [[Events alloc] initWithEvents:lines];
        self.listOfEvents = event.listOfEvents;
    }
    return self;

}

-(id)initWithMinMagnitud:(double)m Lines:(int)lines{
    self = [super init];
    if(self){
        Events *event = [[Events alloc] initWithMinMagnitud:m Country:nil City:nil Lines:lines];
        self.listOfEvents = event.listOfEvents;
    }
    return self;
}

-(id)initWithMinMagnitud:(double)m;{
    self = [super init];
    if(self){
        Events *event = [[Events alloc] initWithMinMagnitud:m Country:nil City:nil Lines:50];
        self.listOfEvents = event.listOfEvents;
    }
    return self;
}

-(id)initWithMinMagnitud:(double)m Country:(NSString *)c City:(NSString *)ci{
    self = [super init];
    if(self){
        Events *event = [[Events alloc] initWithMinMagnitud:m Country:c City:ci Lines:50];
        self.listOfEvents = event.listOfEvents;
    }
    return self;
}

-(EarthquakeEvent*)getEventPosition:(int)pos{
    return self.listOfEvents[pos];
}

-(NSMutableArray*)getListOfEvents{
    return self.listOfEvents;
}

-(int)countOfListOfEvents{
    return (int)[self.listOfEvents count];
}

-(Boolean)existEvent:(NSString*)id{
    return true;
}

@end

