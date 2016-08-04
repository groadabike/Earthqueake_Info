//----------------------------------------------------------------------------
//
//  DateManager.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This class format a date in the proper format for the USGS webService
//
//----------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface DateManage : NSObject

@property (strong) NSDate *date;

-(id)initWithDate:(NSDate*)d;
-(NSString*)getDateFormated;

@end
