//
//  chatViewController.h
//  Pictrap
//
//  Created by milind on 01/05/14.
//  Copyright (c) 2014 PosNirvana. All rights reserved.
//

#import "ViewController.h"

@protocol ChatViewdelegate <NSObject>

- (void)hideTabBarIcons;
- (void)showTAbBarIcons;
@end

@interface chatViewController : ViewController
{
}
@property(nonatomic,weak)id<ChatViewdelegate>chatDelegate;

@end
