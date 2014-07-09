//
//  ViewController.h
//  Pictrap
//
//  Created by milind on 01/05/14.
//  Copyright (c) 2014 PosNirvana. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;
@interface ViewController : UIViewController <NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbl_signUp;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_mobile;
@property (weak, nonatomic) IBOutlet UITextField *txt_mobileNo;
@property (weak, nonatomic) IBOutlet UILabel *lbl_emailID;
@property (weak, nonatomic) IBOutlet UITextField *txt_emailID;
@property (weak, nonatomic) IBOutlet UILabel *lbl_contactToAlert;
@property (weak, nonatomic) IBOutlet UITextField *txt_contactEmailID;
@property (weak, nonatomic) IBOutlet UITextField *txt_coontactPhoneNo;
@property (weak, nonatomic) IBOutlet UIButton *btn_submit;
- (IBAction)submitButtonClicked:(id)sender;

@end
