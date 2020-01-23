//
//  RadioButtonPopupViewController.h
//  RadioButtonPopup
//
//  Created by USER on 2020/01/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RadioButtonPopupViewController : UIViewController

typedef NS_ENUM(NSInteger, PopupViewControllerButtonType) {
    ButtonTypeOK,
    ButtonTypeCancel,
};
typedef void (^RadioButtonPopupHandler)(PopupViewControllerButtonType type, NSString *selectedMsg);

+(RadioButtonPopupViewController *)showRadioButtonPopupWithButtonType:(RadioButtonPopupHandler)handler
                                                              messages:(NSArray<NSString *>*)messages
                                                                 uicolor: (UIColor *)uiColor
                                                       selectedMessage:(NSString *)selectedMessage;

@end

NS_ASSUME_NONNULL_END
