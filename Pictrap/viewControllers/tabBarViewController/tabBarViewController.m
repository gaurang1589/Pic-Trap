//
//  tabBarViewController.m
//  Pictrap
//
//  Created by milind on 01/05/14.
//  Copyright (c) 2014 PosNirvana. All rights reserved.
//

#import "tabBarViewController.h"

@interface tabBarViewController ()

@end

@implementation tabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
       self.navigationItem.hidesBackButton = YES;
    UIImage* logoImage = [UIImage imageNamed:@"pintrap_navigationbar_logo.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    self.tabBarController.tabBar.backgroundColor = [UIColor colorWithRed:(62/225.f) green:(69/225.f) blue:(77/225.f) alpha:1];
    self.delegate = self;
    
    if (imgBack == nil)
    {
        imgBack = [[UIImageView alloc]initWithFrame:CGRectMake(0.0,self.view.bounds.size.height-82, 80.0, 86.0)];
        imgLocation = [[UIImageView alloc]initWithFrame:CGRectMake(80.0, self.view.bounds.size.height-82, 79.0, 86.0)];
        imgChat = [[UIImageView alloc]initWithFrame:CGRectMake(160.0, self.view.bounds.size.height-82, 79.0, 86.0)];
        imgSettings = [[UIImageView alloc]initWithFrame:CGRectMake(240.0, self.view.bounds.size.height-82, 80.0, 86.0)];
        
        imgBack.image = [UIImage imageNamed:@"blue_back_button.png"];
        imgLocation.image = [UIImage imageNamed:@"red_loaction_button.png"];
        imgChat.image = [UIImage imageNamed:@"red_chat_button.png"];
        imgSettings.image = [UIImage imageNamed:@"red_setting _button.png"];
    }
    [self.view addSubview:imgBack];
    [self.view addSubview:imgLocation];
    [self.view addSubview:imgChat];
    [self.view addSubview:imgSettings];
    self.tabBar.backgroundColor = [UIColor blackColor];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self resetTabImages];
    if (viewController == [tabBarController.viewControllers objectAtIndex:0])
    {
         imgBack.image = [UIImage imageNamed:@"blue_back_button.png"];
    }
    else if (viewController == [tabBarController.viewControllers objectAtIndex:1])
    {
        imgLocation.image = [UIImage imageNamed:@"blue_location_button.png"];
    }
    else if (viewController == [tabBarController.viewControllers objectAtIndex:2])
    {
        imgChat.image = [UIImage imageNamed:@"blue_chat_button.png"];
    }
    else if (viewController == [tabBarController.viewControllers objectAtIndex:3])
    {
        imgSettings.image = [UIImage imageNamed:@"blue_setting_buttons.png"];
    }
}

-(void)resetTabImages
{
    imgBack.image = [UIImage imageNamed:@"red_back_button.png"];
    imgLocation.image = [UIImage imageNamed:@"red_loaction_button.png"];
    imgChat.image = [UIImage imageNamed:@"red_chat_button.png"];
    imgSettings.image = [UIImage imageNamed:@"red_setting _button.png"];
}


- (void)hideTabBarIcons
{
   imgBack.hidden = YES;
   imgLocation.hidden = YES;
   imgChat.hidden = YES;
   imgSettings.hidden = YES;
}

- (void)showTAbBarIcons
{
    imgBack.hidden = NO;
    imgLocation.hidden = NO;
    imgChat.hidden = NO;
    imgSettings.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
