//
//  UIBarButtonItem+Blocks.h
//  Shibui
//
//  Created by Kevin Vance on 8/28/14.
//

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

@interface UIBarButtonItem (Blocks)

- (id)initWithStyle:(UIBarButtonItemStyle)style item:(RIButtonItem *)item;

- (void)setButtonItem:(RIButtonItem *)item;

@end
