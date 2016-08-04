//----------------------------------------------------------------------------
//
//  DateManager.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This class format a date in the proper format for the USGS webService
//
//----------------------------------------------------------------------------

#import "DateManage.h"

@implementation DateManage

-(id)initWithDate:(NSDate*)d{
    self = [super init];
    if (self){
        _date = d;
    }
    return self;
}


-(NSString*)getDateFormated{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:self.date];
    return dateString;
}

@end
