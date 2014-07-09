//
//  tabBarViewController.h
//  Pictrap
//
//  Created by milind on 01/05/14.
//  Copyright (c) 2014 PosNirvana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chatViewController.h"

@interface tabBarViewController : UITabBarController<UITabBarControllerDelegate>
{
    UIImageView * imgBack;
    UIImageView * imgLocation;
    UIImageView * imgChat;
    UIImageView * imgSettings;
}

@end
