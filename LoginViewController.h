//
//  LoginViewController.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// ------------------------------------
// ¦ViewController of the Login Screen¦
// ------------------------------------
#import <UIKit/UIKit.h>
#import "UserData.h"
#import "ModalViewControllerDelegate.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (weak) id <ModalViewControllerDelegate> delegate;
@property (weak) UserData *userData;

@property (weak) IBOutlet UITextField *userTextField;
@property (weak) IBOutlet UITextField *passTextField;

@property (weak) IBOutlet UILabel *ErrorInfo;

- (IBAction)loginGoLastEvent;
- (IBAction)cancle;



@end
