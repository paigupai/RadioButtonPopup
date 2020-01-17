//
//  RadioButtonPopupViewController.m
//  RadioButtonPopup
//
//  Created by USER on 2020/01/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "RadioButtonPopupViewController.h"

@interface RadioButtonPopupViewController ()

@end

@implementation RadioButtonPopupViewController

+(RadioButtonPopupViewController *)
showRadioButtonPopupWithButtonType:(RadioButtonPopupHandler)handler
messages:(nonnull NSArray<NSString *> *)messages
selectedMessage:(nonnull NSString *)selectedMessage
{
    RadioButtonPopupViewController *vc = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil].instantiateInitialViewController;
//    vc.hander = handler;
//    vc.messages = messages;
//    vc.selectedMessage = selectedMessage;
//    vc.addDLRadiobuttonDone = NO;
    [vc show];
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)show
{
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UIViewController *rootVC =[UIApplication sharedApplication].keyWindow.rootViewController;
   [rootVC presentViewController:self animated:NO completion:nil];
}

@end
