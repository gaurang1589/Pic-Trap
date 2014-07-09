//
//  homeViewController.m
//  Pictrap
//
//  Created by milind on 01/05/14.
//  Copyright (c) 2014 PosNirvana. All rights reserved.
//

#import "homeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface homeViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *examples;
@property (nonatomic) CGFloat percentage;

-(IBAction)recordAndPlay:(id)sender;
-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate;
-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo;

@end

@implementation homeViewController

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
    
    _lbl_RecordMessage.font = [UIFont fontWithName:@"Lato-Light" size:30];
     _lbl_Description.font = [UIFont fontWithName:@"Lato-Regular" size:10];
    
   
    
    self.examples = [[NSMutableArray alloc] init];
    self.percentage = 0;
    CGFloat width = _progressView.frame.size.width+300;
    CGFloat height = _progressView.frame.size.height+300;
    CGFloat radius = floor(width / 4 * 0.8);
    
    THCircularProgressView *example4 = [[THCircularProgressView alloc] initWithCenter:CGPointMake(width * .23, height * .20 )
        radius:radius
        lineWidth:radius
        progressMode:THProgressModeFill
        progressColor:[UIColor colorWithRed:(242/225.f) green:(216/225.f) blue:(106/225.f) alpha:1]
        progressBackgroundMode:THProgressBackgroundModeNone
        progressBackgroundColor:nil
        percentage:self.percentage];
    [_progressView addSubview:example4];
    [self.examples addObject:example4];
    
    [_startMike bringSubviewToFront:_progressView];
    
    [self startRecording:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRecording:(id)sender {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                  target:self selector:@selector(timerFired:)
                  userInfo:nil repeats:YES];
    
    
    
    [self startCameraControllerFromViewController:self usingDelegate:self];
}


-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller usingDelegate:(id )delegate {
    // 1 - Validattions
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
    // 3 - Display image picker    
    [controller presentViewController:cameraUI animated:YES completion:nil];
    
    [controller performSelector:@selector(dismissImagePicker:) withObject:cameraUI afterDelay:18.0];
    
    return YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:picker completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] absoluteString];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath))
        {
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, self,
                                                @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)sendVideoThroughEmail:(NSData *)videoData
{
    MFMailComposeViewController *mailsend = [[MFMailComposeViewController alloc] init];
    mailsend.mailComposeDelegate = self;
    [mailsend setSubject:@"Video from pic trap"];
    
    // Fill out the email body text
    NSString *victimInfoString = @"Hello PFA the video captured in Pic Trap";
    
    NSString *emailBody = [NSString stringWithFormat:@"%@\n", victimInfoString];
    
    emailBody = [emailBody stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
    [mailsend setMessageBody:emailBody isHTML:NO];
    
    [mailsend setToRecipients:[NSArray arrayWithObject:@"mobile@latriallawyers.com"]];
    
    NSData *data = videoData;
    
    [mailsend addAttachmentData:data mimeType:@"video/mp4" fileName:@"Video"];
    
    
    [self presentViewController:mailsend animated:YES completion:nil];
}

- (void)dismissImagePicker:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)timerFired:(NSTimer *)timer
{
    self.percentage += 0.005;
    if (self.percentage >= 1)
    {
       // self.percentage = 0;
        [self.timer invalidate];

    }
    for (THCircularProgressView* progressView in self.examples) {
        progressView.percentage = self.percentage;
    }
    
 
    
}

#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	NSLog(@"Mail delegate...");
	[controller dismissViewControllerAnimated:YES completion:nil];
	
	if(result==MFMailComposeResultSent)
	{
		UIAlertView *mailAlertV=[[UIAlertView alloc]initWithTitle:@"E-Mail" message:@"Your mail sent successfully!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[mailAlertV show];
	}
}

@end
