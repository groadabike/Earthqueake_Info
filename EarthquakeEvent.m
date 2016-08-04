//----------------------------------------------------------------------------
//
//  EarthquakeEvent.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//  This class contain the detail of each earthqueake event.
//
//----------------------------------------------------------------------------

#import "EarthquakeEvent.h"

@implementation EarthquakeEvent

-(id)initWithIdEvent: (NSString*)i Place: (NSString*)p Latitude:(double)lat Longitude:(double)lon Depth:(double)d Magnitude:(double)m Time:(double)da Date:(NSString*)de Hour:(NSString*)h Country:(NSString*)co City:(NSString*)ci URL:(NSString*)u{
    self = [super init];
    if (self) {
        self.idEvent = i;
        self.place = p;
        self.latitude = lat;
        self.longitude = lon;
        self.depht = d;
        self.magnitude = m;
        self.time = da;
        self.date = de;
        self.hour = h;
        self.country = co;
        self.city = ci;
        self.url = u;
    }
    return self;
}

-(void) saveEventDatabase{
    Events *e = [[Events alloc] init];
    if(![e eventExistInDatabaseID:self.idEvent]){
        if([e insertNewEvent:self]){
            NSLog(@"Saved new event");
        }else{
            NSLog(@"Error saving event");
        }
        
    }else{
        NSLog(@"Event Already Exist");
    }
}

@end