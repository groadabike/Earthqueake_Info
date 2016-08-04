//
//  LoginViewController.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// ------------------------------------
// ¦ViewController of the Login Screen¦
// ------------------------------------

#import "LoginViewController.h"



@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {

    [self.userTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

//modified 15/01
// ckeck the login information and go back to start page
- (IBAction)loginGoLastEvent {
    // assume that login was OK (actually we would check against the model)
    //[self.userData checkAuthorizationUser:self.userTextField.text password:self.passTextField.text];
    // update the label in the presenting view controller
    BOOL authorized = [self.userData checkAuthorizationUser:self.userTextField.text password:self.passTextField.text];
    if (authorized) {
        [self.userData updateLogged:1 username:self.userData.userName];
        [self.delegate update:1];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    else{
        NSLog(@"Wrong login information");
        self.ErrorInfo.text = @"Please check your username and password!";
    }
    //if the password cannot match the username, there will be a notify
//    if (![self.userData checkAuthorizationUser:self.userTextField.text password:self.passTextField.text]) {
//        NSLog(@"Wrong login information");
//        self.ErrorInfo.text = @"Please check your username and password!";
//    }
//    else{
            // cause the view controller that presented this modal view controller
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    }

    
}

- (IBAction)cancle {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end




