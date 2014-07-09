//
//  ViewController.m
//  Pictrap
//
//  Created by milind on 01/05/14.
//  Copyright (c) 2014 PosNirvana. All rights reserved.
//

#import "ViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "tabBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize scrollView;

// [UIFont fontWithName:@"Neutraface2Display-Titling" size:20];

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.scrollView contentSizeToFit];
    
    UIImage* logoImage = [UIImage imageNamed:@"pintrap_navigationbar_logo.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    _lbl_signUp.font = [UIFont fontWithName:@"Lato-Light" size:45];
    _lbl_name.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    _txt_name.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    _lbl_mobile.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    _txt_mobileNo.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    _lbl_emailID.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    _txt_emailID.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    _lbl_contactToAlert.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    _txt_contactEmailID.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    _txt_coontactPhoneNo.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    _btn_submit.layer.cornerRadius=5.0;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self setScrollView:nil];
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Submit Button Click

- (IBAction)submitButtonClicked:(id)sender
{
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:[self userDictionaryForPost] options:0 error:nil];
    
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [self submitRequest:myString];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *obj=[storyboard instantiateViewControllerWithIdentifier:@"tabBarView"];
    [self.navigationController pushViewController:obj animated:YES];
    
    jsonData = nil;
    myString = nil;
}

- (void)submitRequest:(NSString *)request;
{
    NSString *urlString = @"";
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    [req setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPMethod:@"POST"];
    
    NSError *errorReturned = nil;
    
    NSHTTPURLResponse *theResponse =[[NSHTTPURLResponse alloc]init];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&theResponse error:&errorReturned];
    
    if([data length]!=0)
    {
        id response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if([response isKindOfClass:[NSDictionary class]])
        {
            if([[response valueForKey:@"id"] intValue]!=0)
            {
                [self performSegueWithIdentifier:@"submitSuccess" sender:self];
            }
        }

    }
    else
    {
        // show alert if failed.
    }
    
    data = nil;
    theResponse = nil;
    req = nil;
    
}

- (NSDictionary *)userDictionaryForPost
{
    NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc]init];
   
    [userDictionary setValue:_txt_name.text forKey:@"firstName"];
    [userDictionary setValue:@"" forKey:@"lastName"];
    [userDictionary setValue:_txt_mobileNo.text forKey:@"mobileNo"];
    [userDictionary setValue:_txt_emailID.text forKey:@"email"];
    [userDictionary setValue:_txt_coontactPhoneNo.text forKey:@"alertPhone"];
    [userDictionary setValue:_txt_contactEmailID.text forKey:@"alertEmail"];
    [userDictionary setValue:@"" forKey:@"latitude"];
    [userDictionary setValue:@"" forKey:@"longitude"];
    [userDictionary setValue:@"A" forKey:@"status"];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:userDictionary, @"user",nil];
}



@end
