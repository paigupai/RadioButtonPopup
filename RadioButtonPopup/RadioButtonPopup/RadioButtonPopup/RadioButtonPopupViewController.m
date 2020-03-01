//
//  RadioButtonPopupViewController.m
//  RadioButtonPopup
//
//  Created by USER on 2020/01/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "RadioButtonPopupViewController.h"
#import "DLRadioButton.h"

@interface RadioButtonPopupViewController ()
@property (strong, nonatomic) RadioButtonPopupHandler hander;
@property (nonatomic) NSArray<NSString *> *messages;
@property (nonatomic) NSString *selectedMessage;
@property (nonatomic) BOOL addDLRadiobuttonDone;
@property (nonatomic) UIColor* uiColor;
@property (strong, nonatomic) IBOutlet UIView *RadioButtonView;
- (IBAction)OKButton:(id)sender;
- (IBAction)CacncleButton:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *radioButtonViewHeight;

@end

@implementation RadioButtonPopupViewController

//static const int RADIOBUTTON_TITLELABEL_FONT_SIZE = 15;
//static const CGFloat RADIOBUTTON_V_MARGIN = 13.0;

+(RadioButtonPopupViewController *)
showRadioButtonPopupWithButtonType:(RadioButtonPopupHandler)handler
messages:(nonnull NSArray<NSString *> *)messages
uicolor: (UIColor *)uiColor
selectedMessage:(nonnull NSString *)selectedMessage
{
    RadioButtonPopupViewController *vc = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil].instantiateInitialViewController;
    vc.hander = handler;
    vc.messages = messages;
    vc.selectedMessage = selectedMessage;
    vc.addDLRadiobuttonDone = NO;
    if (uiColor) {
        vc.uiColor = uiColor;
    }else{
        vc.uiColor = [UIColor blackColor];
    }
    [vc show];
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getRadioButtonViewHeight];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addDLRadioButton];
}

-(void)getRadioButtonViewHeight{
    if (self.messages.count > 1) {
            self.radioButtonViewHeight.constant = 20*(self.messages.count - 1);
  }
}

-(void)addDLRadioButton{
    if (self.addDLRadiobuttonDone) {
        return;
    }
    NSInteger i = 0;
    NSInteger selectedNumber = 0;
    NSMutableArray *otherButtons = [NSMutableArray new];

    DLRadioButton *firstRadioButton = [self createRadioButtonWithTitle:self.messages[0]];
    [self.RadioButtonView addSubview:firstRadioButton];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:firstRadioButton
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.RadioButtonView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0.0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:firstRadioButton
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.RadioButtonView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0.0];
    firstRadioButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.RadioButtonView addConstraints:@[topConstraint, leftConstraint]];

    DLRadioButton *aboveRadioButton = firstRadioButton;

    for (NSString *msg in self.messages) {
        DLRadioButton *radioButton = nil;
        CGFloat textWidth = 0;
        if (i==0) {
            radioButton = firstRadioButton;
            [firstRadioButton setTitle:msg forState:UIControlStateNormal];
        }else{
            //1つ以上
            radioButton = [self createRadioButtonWithTitle:msg];
            [self.RadioButtonView addSubview:radioButton];
            radioButton.translatesAutoresizingMaskIntoConstraints = NO;
            topConstraint = [NSLayoutConstraint constraintWithItem:radioButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:aboveRadioButton
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:0.0];
            leftConstraint = [NSLayoutConstraint constraintWithItem:radioButton
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.RadioButtonView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0];
            [self.RadioButtonView addConstraints:@[topConstraint, leftConstraint]];
            [otherButtons addObject:radioButton];
            aboveRadioButton = radioButton;
        }

        textWidth = [radioButton sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        CGFloat radioButtonWidth = textWidth + radioButton.iconSize + radioButton.marginWidth;
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:radioButton
                                                                           attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth
                                                                          multiplier:1.0
                                                                            constant:radioButtonWidth];
        [radioButton addConstraint:widthConstraint];
        if ([msg compare:self.selectedMessage] == NSOrderedSame) {
            selectedNumber = i;
        }
        i++;
    }
    firstRadioButton.otherButtons = otherButtons;

//    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:aboveRadioButton
//                                                                        attribute:NSLayoutAttributeBottom
//                                                                        relatedBy:NSLayoutRelationEqual
//                                                                           toItem:self.RadioButtonView
//                                                                        attribute:NSLayoutAttributeBottom
//                                                                       multiplier:1.0
//                                                                         constant:0.0];
//    [self.RadioButtonView addConstraint:bottomConstraint];

    //選択済みの初期項目
    if (selectedNumber == 0) {
        firstRadioButton.selected = YES;
        self.selectedMessage = firstRadioButton.titleLabel.text;
    }else{
        firstRadioButton.otherButtons[selectedNumber - 1].selected = YES;
    }
    self.addDLRadiobuttonDone = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Helper

- (DLRadioButton *)createRadioButtonWithTitle:(NSString *)title
{
    DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(0,0,0,0)];
    radioButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [radioButton setTitle:title forState:UIControlStateNormal];
    [radioButton setTitleColor:self.uiColor forState:UIControlStateNormal];
    radioButton.iconColor = self.uiColor;
    radioButton.indicatorColor = self.uiColor;
    radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [radioButton addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:radioButton];
    
    return radioButton;
}

-(void)show
{
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UIViewController *rootVC =[UIApplication sharedApplication].keyWindow.rootViewController;
   [rootVC presentViewController:self animated:NO completion:nil];
}

- (IBAction)selectedButton:(DLRadioButton *)radioButton {
    NSLog(@"%@ is selected.\n", radioButton.selectedButton.titleLabel.text);
    self.selectedMessage = radioButton.selectedButton.titleLabel.text;
}

- (IBAction)OKButton:(id)sender {
    [self dismissViewControllerAnimated:NO completion:NULL];
    if (self.hander) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.hander(ButtonTypeOK,self.selectedMessage);
        });
    }
}
- (IBAction)CacncleButton:(id)sender {
    [self dismissViewControllerAnimated:NO completion:NULL];
    if (self.hander) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.hander(ButtonTypeCancel,@"");
        });
    }
}
@end
