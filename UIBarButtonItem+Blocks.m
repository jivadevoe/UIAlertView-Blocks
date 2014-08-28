//
//  UIBarButtonItem+Blocks.m
//  Shibui
//
//  Created by Kevin Vance on 8/28/14.
//

#import "UIBarButtonItem+Blocks.h"
#import <objc/runtime.h>

static NSString *RI_BUTTON_ASS_KEY = @"com.random-ideas.BUTTON";

@implementation UIBarButtonItem (Blocks)

- (id)initWithStyle:(UIBarButtonItemStyle)style item:(RIButtonItem *)item
{
    if((self = [self initWithTitle:item.label style:style target:self action:@selector(buttonItemPressed:)]))
    {
        [self setButtonItem:item];
    }
    return self;
}

- (void)buttonItemPressed:(id)sender {
    RIButtonItem *item = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);
    if(item && item.action) {
        item.action();
    }
}

- (void)setButtonItem:(RIButtonItem *)item {
    objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
