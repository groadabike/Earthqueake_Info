//----------------------------------------------------------------------------
//
//  SourceData_Abstract.m
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

#import "SourceData_Abstract.h"

@implementation SourceData_Abstract


-(id)initWithWebURL:(NSString *)url{
    self = [super init];
    if(self){
        _receivedData = [[NSMutableData alloc]init];
        _webURL = url;
    }
    return self;
    
}


-(void) searchData{
    NSLog(@"Must overwrite this method");
}

-(void) saveData{
    NSLog(@"Must overwrite this method");
}

//  Gerardo Roa Dabike - 11/01/2016
//  The next method are not necessary to overwrite in the scope of this
//  program, therefore, are declare into the abstract class.

// deal with any received data by appending it to receivedData
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
    NSLog(@"Received response!");
}
//show loading activity.
- (void)startSpinner:(NSString *)message {
    //  Purchasing Spinner.
    if (!self.connectingAlert) {
        self.connectingAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(message,@"")
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:nil
                                                otherButtonTitles:nil];
        self.connectingAlert.tag = (NSUInteger)300;
        [self.connectingAlert show];
        
        UIActivityIndicatorView *connectingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        connectingIndicator.frame = CGRectMake(139.0f-18.0f,50.0f,37.0f,37.0f);
        [self.connectingAlert addSubview:connectingIndicator];
        [connectingIndicator startAnimating];
        
        
    }
}

//hide loading activity.
- (void)stopSpinner {
    if (self.connectingAlert) {
        [self.connectingAlert dismissWithClickedButtonIndex:0 animated:YES];
        self.connectingAlert = nil;
    }
    // [self performSelector:@selector(showBadNews:) withObject:error afterDelay:0.1];
}

// handle the text field, causes the keyboard to be dismissed
- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    //[self search:textField.text];
    return YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // you could display an error here if you wanted to
    NSLog(@"%@",[error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self startSpinner:@"Loading Data..."];
    [self saveData];
    [self stopSpinner];
    connection = nil;
    self.receivedData= nil;
}

@end