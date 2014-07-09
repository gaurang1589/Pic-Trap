//
//  ContainerViewController.m
//  EmbeddedSwapping
//
//  Created by Michael Luton on 11/13/12.
//  Copyright (c) 2012 Sandmoose Software. All rights reserved.
//  Heavily inspired by http://orderoo.wordpress.com/2012/02/23/container-view-controllers-in-the-storyboard/
//

#import "ContainerViewController.h"
#import "homeViewController.h"
#import "locationViewController.h"
#import "chatViewController.h"
#import "settingViewController.h"

#define SegueIdentifierHome @"embedHome"
#define SegueIdentifierLocation @"embedLocation"
#define SegueIdentifierChat @"embedChat"
#define SegueIdentifierSetting @"embedSetting"

@interface ContainerViewController ()

@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (strong, nonatomic) homeViewController *HomeViewController;
@property (strong, nonatomic) locationViewController *LocationViewController;
@property (strong, nonatomic) chatViewController *ChatViewController;
@property (strong, nonatomic) settingViewController *SettingViewController;

@property (assign, nonatomic) BOOL transitionInProgress;

@end

@implementation ContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.transitionInProgress = NO;
    self.currentSegueIdentifier = SegueIdentifierHome;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
    
    NSLog(@"self.childViewControllers:::%@",self.childViewControllers);

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    if ([segue.identifier isEqualToString:SegueIdentifierHome]) {
        self.HomeViewController  = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierLocation]) {
        self.LocationViewController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierChat]) {
        self.ChatViewController = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierSetting]) {
        self.SettingViewController = segue.destinationViewController;
    }
    
    
    // If we're going to the first view controller.
    if ([segue.identifier isEqualToString:SegueIdentifierHome]) {
        // If this is not the first time we're loading this.
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.HomeViewController];
        }
        else {
            // If this is the very first time we're loading this we need to do
            // an initial load and not a swap.
            [self addChildViewController:segue.destinationViewController];
            UIView* destView = ((UIViewController *)segue.destinationViewController).view;
            destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:destView];
            [segue.destinationViewController didMoveToParentViewController:self];
        }
    }
    // By definition the second view controller will always be swapped with the
    // first one.
    else if ([segue.identifier isEqualToString:SegueIdentifierLocation]) {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.LocationViewController];
    }

}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];

    [self transitionFromViewController:fromViewController toViewController:toViewController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        self.transitionInProgress = NO;
    }];
}

- (void)swapViewControllers
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.transitionInProgress) {
        return;
    }
    
    self.transitionInProgress = YES;
    self.currentSegueIdentifier = ([self.currentSegueIdentifier isEqualToString:SegueIdentifierHome]) ? SegueIdentifierLocation : SegueIdentifierHome;
    
    if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierHome]) && self.HomeViewController)
    {
        [self swapFromViewController:self.LocationViewController toViewController:self.HomeViewController];
        return;
    }
    
    if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierLocation]) && self.LocationViewController)
    {
        [self swapFromViewController:self.HomeViewController toViewController:self.LocationViewController];
        return;
    }
    
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

@end
