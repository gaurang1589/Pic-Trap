//
//  settingViewController.h
//  Pictrap
//
//  Created by milind on 01/05/14.
//  Copyright (c) 2014 PosNirvana. All rights reserved.
//

#import "ViewController.h"


@interface settingViewController : ViewController

@property (strong, nonatomic) IBOutlet UIView *settingsView;
- (IBAction)shakeSwitchToggled:(id)sender;
- (IBAction)locationSwitchToggled:(id)sender;
- (IBAction)chatSwitchToggled:(id)sender;
- (IBAction)myContactsButtonClicked:(id)sender;
- (IBAction)shareButtonClicked:(id)sender;
- (IBAction)backButtonClicked:(id)sender;

@end
