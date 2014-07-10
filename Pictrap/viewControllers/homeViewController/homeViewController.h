//
//  homeViewController.h
//  Pictrap
//
//  Created by milind on 01/05/14.
//  Copyright (c) 2014 PosNirvana. All rights reserved.
//

#import "ViewController.h"
#import "THCircularProgressView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "SKPSMTPMessage.h"

@interface homeViewController : ViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, MFMailComposeViewControllerDelegate, SKPSMTPMessageDelegate>
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *startMike;
- (IBAction)startRecording:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl_RecordMessage;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Description;

@end
