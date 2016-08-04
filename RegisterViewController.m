//
//  RegisterViewController.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
// ---------------------------------------
// ¦ViewController of the Register Screen¦
// ---------------------------------------

#import "RegisterViewController.h"
#import "UserData.h"


@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // This is the method that keyboard will disappear when tap the screen
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
// The method for Keboard Disappear
-(void)dismissKeyboard {
    [self.name resignFirstResponder];
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.passwordCheck resignFirstResponder];
    [self.country resignFirstResponder];
    [self.city resignFirstResponder];
}

//The page will go up, avoiding the keboard cover it
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height + 216 + 150);
    if (offset<=0) {
        [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = offset;
        self.view.frame = frame;
        }];
       }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
     CGRect frame = self.view.frame;
     frame.origin.y = 0;
     self.view.frame = frame;
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

//modified 16/01 Luisa
- (IBAction)confirm {
    //[调用userdata的插入方法   call the method from userdata which inset the date to database];
    self.user = [[User alloc]init];
//    BOOL exist = [self.user initWithName:self.name.text Country:self.country.text City:self.city.text UserName:self.username.text Password:self.password.text Logged:0];
//    if (exist) {
//        if (self.password.text == self.passwordCheck.text) {
//            //sucess to sign up
//            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//        }
//        else{
//            self.registerInfo.text = @"Please check password and password check! ";
//        }
//    }
    if ([self.password.text isEqualToString: self.passwordCheck.text]) {
        BOOL exist = [self.user initWithName:self.name.text Country:self.country.text City:self.city.text UserName:self.username.text Password:self.password.text Logged:0];
        if (exist) {
            //sucess to sign up
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            self.registerInfo.text = @"The user name has already been used! ";
        }
    }
    else{
        self.registerInfo.text = @"Please check password and password check! ";
        }
    //    [self.user sentUserToDatabase];
    
    
}
// if Cancle, only the page disappear and then go to the log in page
- (IBAction)cancleRegister {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
