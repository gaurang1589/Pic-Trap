//
//  settingViewController.m
//  Pictrap
//
//  Created by milind on 01/05/14.
//  Copyright (c) 2014 PosNirvana. All rights reserved.
//

#import "settingViewController.h"

@interface settingViewController ()
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation settingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [_settingsView removeFromSuperview];
    
    [self addSettingViewOnWindow:_settingsView];
}

- (void)addSettingViewOnWindow:(UIView *)settingsView
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         settingsView.frame = CGRectMake(- 40, 0, window.frame.size.width, window.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             [settingsView setFrame:CGRectMake(0, 0,window.frame.size.width-30, window.frame.size.height)];
                         }
                     }];
    
    settingsView.backgroundColor = [UIColor clearColor];
    
    [self.tabBarController.view addSubview:settingsView];
    [self.tabBarController.view bringSubviewToFront:settingsView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)shakeSwitchToggled:(id)sender
{
}

- (IBAction)locationSwitchToggled:(id)sender
{
}

- (IBAction)chatSwitchToggled:(id)sender
{
}

- (IBAction)myContactsButtonClicked:(id)sender
{
}

- (IBAction)shareButtonClicked:(id)sender {
}

- (IBAction)backButtonClicked:(id)sender
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [_settingsView setFrame:CGRectMake(0, 0,window.frame.size.width-30, window.frame.size.height)];
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             [_settingsView setFrame:CGRectMake(0-window.frame.size.width, 0,window.frame.size.width-30, window.frame.size.height)];
                         }
                     }];
    
    _settingsView.backgroundColor = [UIColor clearColor];
    
    [_settingsView removeFromSuperview];
    
    [self.tabBarController setSelectedIndex:0];
}
@end
