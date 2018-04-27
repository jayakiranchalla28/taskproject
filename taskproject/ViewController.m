//
//  ViewController.m
//  taskproject
//
//  Created by wifin_imac on 4/2/18.
//  Copyright © 2018 wifin_imac. All rights reserved.
//

#import "ViewController.h"
#import "loginViewController.h"
@interface ViewController ()<UITextFieldDelegate>
{
    
    __weak IBOutlet UITextField *phonenumber;
    
    __weak IBOutlet UITextField *emailName;
    __weak IBOutlet UITextField *name;
    
    __weak IBOutlet UITextField *retypepassword;
    __weak IBOutlet UITextField *password;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clkmeAction:(id)sender {
    
    
    if (!name.text.length) {
        [name becomeFirstResponder];
        [self showMessagetitle:@"Task" andMessageBody:name.placeholder];
        return;
    }
    
    
    
    if (!emailName.text.length) {
        [emailName becomeFirstResponder];
        [self showMessagetitle:@"Task" andMessageBody:emailName.placeholder];
        return;
    }
    if (![self isValidEmail:emailName.text]) {
        [emailName becomeFirstResponder];
        [self showMessagetitle:@"Task" andMessageBody:emailName.placeholder];
        
        return;
    }
    
    
    
    
    if (!phonenumber.text.length) {
       
        [phonenumber becomeFirstResponder];
        
        [self showMessagetitle:@"Task" andMessageBody:phonenumber.placeholder];
        
        return;
    }
    if ([phonenumber.text length]<10 || ![self isNumeric:phonenumber.text]) {
        [self showMessagetitle:nil andMessageBody:@"Please Enter Valid Mobile Number"];
        return;
    }
    
    if (!password.text.length) {
        
        [password becomeFirstResponder];
        
        [self showMessagetitle:@"Task" andMessageBody:password.placeholder];
        
        return;
    }
    
    
    if (!retypepassword.text.length) {
        
        [retypepassword becomeFirstResponder];
        
        [self showMessagetitle:@"Task" andMessageBody:retypepassword.placeholder];
        
        return;
    }
    
    
    if (![retypepassword.text isEqualToString:password.text]) {
        
        [password becomeFirstResponder];
        
        [self showMessagetitle:@"Task" andMessageBody:@"Please Enter check password"];
        
        return;
    }
    
     NSMutableArray * Fullassects = [[[NSUserDefaults standardUserDefaults] valueForKey:@"signinDetails"] mutableCopy];
    NSMutableArray * common =[NSMutableArray new];
    
     if(Fullassects.count == 0){
         
         NSDictionary * Signdeatils = @{ @"email":emailName.text,
                                         @"password":password.text
                                                    };
         
         
         
         
         [common addObject:Signdeatils];
         [[NSUserDefaults standardUserDefaults] setObject:common forKey:@"signinDetails"];
         
         
         
     }else{
         
         NSDictionary * Signdeatils = @{ @"email":emailName.text,
                                         @"password":password.text
                                         };
         
         
         
         
         [Fullassects addObject:Signdeatils];
         [[NSUserDefaults standardUserDefaults] setObject:Fullassects forKey:@"signinDetails"];
         
         
         
     }
    
    loginViewController * login =[self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([loginViewController class])];
    
    
    
    [self.navigationController pushViewController:login animated:YES];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phonenumber) {
        if (textField.text.length >= 10 && range.length == 0)
        {
            return NO;
        }else
        {return YES;}
    }
    return YES;
    
    
}


- (void)showMessagetitle:(NSString *)title andMessageBody :(NSString*)messageBody {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:messageBody preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleCancel handler:nil]];
}
-(BOOL)isValidEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



- (BOOL)isNumeric:(NSString*)number
{
    NSString *emailRegex = @"[0-9]+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:number];
}



@end
