//
//  ObjectiveCViewController.m
//  RadioButtonPopup
//
//  Created by paigu on 2020/03/01.
//  Copyright © 2020 USER. All rights reserved.
//

#import "ObjectiveCViewController.h"
#import "RadioButtonPopupViewController.h"

@interface ObjectiveCViewController ()
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;

@end

@implementation ObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)popupButtonClicked:(id)sender {
    NSArray *msgList = [NSArray arrayWithObjects:@"河野都",
                        @"斎藤ニコル",
                        @"佐藤麗華",
                        @"滝川みう",
                        @"立川絢香",
                        @"戸田ジュン",
                        @"藤間桜",
                        @"丸山あかね",
                        @"神木みかみ",
                        @"東条悠希",
                        @"柊つぼみ",nil];
    
    [RadioButtonPopupViewController showRadioButtonPopupWithButtonType:^(PopupViewControllerButtonType buttonType,NSString *msg) {
        // Any completion handler related code here...
        switch (buttonType) {
            case ButtonTypeOK:
                self.selectLabel.text = msg;
                break;
            case ButtonTypeCancel:
                break;
            default:
                NSLog(@"unknown");
                break;
        }
    }
                                                              messages:msgList
                                                               uicolor:[UIColor redColor]
                                                       selectedMessage:self.selectLabel.text];
}

@end
