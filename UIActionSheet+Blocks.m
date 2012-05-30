//
//  UIActionSheet+Blocks.m
//  Shibui
//
//  Created by Jiva DeVoe on 1/5/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import "UIActionSheet+Blocks.h"
#import <objc/runtime.h>

static NSString *RI_BUTTON_ASS_KEY = @"com.random-ideas.BUTTONS";
static NSString *RI_DISMISSAL_ACTION_KEY = @"com.random-ideas.DISMISSAL_ACTION";

@implementation UIActionSheet (Blocks)

-(id)initWithTitle:(NSString *)inTitle cancelButtonItem:(RIButtonItem *)inCancelButtonItem destructiveButtonItem:(RIButtonItem *)inDestructiveItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ...
{
    if((self = [self initWithTitle:inTitle delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]))
    {
        NSMutableArray *buttonsArray = [NSMutableArray array];
        
        RIButtonItem *eachItem;
        va_list argumentList;
        if (inOtherButtonItems)
        {
            [buttonsArray addObject: inOtherButtonItems];
            va_start(argumentList, inOtherButtonItems);
            while((eachItem = va_arg(argumentList, RIButtonItem *)))
            {
                [buttonsArray addObject: eachItem];
            }
            va_end(argumentList);
        }
        
        for(RIButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }
        
        if(inDestructiveItem)
        {
            [buttonsArray addObject:inDestructiveItem];
            NSInteger destIndex = [self addButtonWithTitle:inDestructiveItem.label];
            [self setDestructiveButtonIndex:destIndex];
        }
        if(inCancelButtonItem)
        {
            [buttonsArray addObject:inCancelButtonItem];
            NSInteger cancelIndex = [self addButtonWithTitle:inCancelButtonItem.label];
            [self setCancelButtonIndex:cancelIndex];
        }
        
        objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return self;
}

- (NSInteger)addButtonItem:(RIButtonItem *)item
{	
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);	
	
	NSInteger buttonIndex = [self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];
	
	return buttonIndex;
}

- (void)setDismissalAction:(void(^)())dismissalAction
{
    objc_setAssociatedObject(self, (__bridge const void *)RI_DISMISSAL_ACTION_KEY, nil, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, (__bridge const void *)RI_DISMISSAL_ACTION_KEY, dismissalAction, OBJC_ASSOCIATION_COPY);
}

- (void(^)())dismissalAction
{
    return objc_getAssociatedObject(self, (__bridge const void *)RI_DISMISSAL_ACTION_KEY);
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Action sheets pass back -1 when they're cleared for some reason other than a button being 
    // pressed.
    if (buttonIndex >= 0)
    {
        NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);
        RIButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
        if(item.action)
            item.action();
    }
    
    if (self.dismissalAction) self.dismissalAction();
    
    objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)RI_DISMISSAL_ACTION_KEY, nil, OBJC_ASSOCIATION_COPY);
}

@end

