//
//  loginViewController.m
//  taskproject
//
//  Created by wifin_imac on 4/2/18.
//  Copyright © 2018 wifin_imac. All rights reserved.
//

#import "loginViewController.h"
#import "ImageViewController.h"
@interface loginViewController ()
{
    NSMutableArray * Fullassects;
    
    __weak IBOutlet UITextField *email;
    
    __weak IBOutlet UITextField *password;
}
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    Fullassects = [[[NSUserDefaults standardUserDefaults] valueForKey:@"signinDetails"] mutableCopy];
    
    
    
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
- (IBAction)loginAction:(id)sender {
    
    if (!email.text.length) {
        [email becomeFirstResponder];
        [self showMessagetitle:@"Task" andMessageBody:email.placeholder];
        return;
    }
    if (![self isValidEmail:email.text]) {
        [email becomeFirstResponder];
        
        [self showMessagetitle:@"Task" andMessageBody:email.placeholder];
        
        return;
    }
    
    
    
    
    if (!password.text.length) {
        
        [password becomeFirstResponder];
        
        [self showMessagetitle:@"Task" andMessageBody:password.placeholder];
        
        return;
    }
    
    for (NSDictionary * elements in Fullassects) {
        
        if ([[elements valueForKey:@"email"] isEqualToString:email.text] && [[elements valueForKey:@"password"] isEqualToString:password.text]) {
           
            
            ImageViewController * imageVC =[self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ImageViewController class])];
            
            
            
            [self.navigationController pushViewController:imageVC animated:YES];
            
            
            
            
            
            break;
        }
        
        
        
    }
    
    
    
}
- (IBAction)backAction:(id)sender {
    
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers firstObject] animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
