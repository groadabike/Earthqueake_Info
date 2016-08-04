//
//  RegisterViewController.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// ---------------------------------------
// ¦ViewController of the Register Screen¦
// ---------------------------------------

#import <UIKit/UIKit.h>
#import "User.h"

@interface RegisterViewController : UIViewController
@property (weak) IBOutlet UITextField *name;
@property (weak) IBOutlet UITextField *username;
@property (weak) IBOutlet UITextField *password;
@property (weak) IBOutlet UITextField *passwordCheck;
@property (weak) IBOutlet UITextField *country;
@property (weak) IBOutlet UITextField *city;
@property (weak) IBOutlet UILabel *registerInfo;


@property (strong) User *user;

- (IBAction)cancleRegister;
- (IBAction)confirm;

@end
