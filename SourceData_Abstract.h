//----------------------------------------------------------------------------
//
//  SourceData_Abstract.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This is an abstract class which declare the atributes and methods for
//  request earthquakes events.
//
//  The methods "searchData" and "saveData" must be implemented.
//
//----------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SourceData_Abstract : NSObject <NSURLConnectionDelegate>

@property (strong) NSString *webURL;
@property (strong) NSMutableData *receivedData;
@property UIAlertView *connectingAlert;

-(id)initWithWebURL:(NSString*)url;
-(void) searchData;
-(void) saveData;
- (void)stopSpinner;
- (void)startSpinner:(NSString *)message ;

@end