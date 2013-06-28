//
//  UIAlertView+Blocks.m
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

static const void *RI_BUTTON_ASS_KEY = &RI_BUTTON_ASS_KEY;

@implementation UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItemsArray:(NSArray *)inOtherButtonItemsArray
{
    self = [self initWithTitle:inTitle message:inMessage delegate:self cancelButtonTitle:inCancelButtonItem.label otherButtonTitles:nil];

    if (self) {
        NSMutableArray *buttonsArray = [NSMutableArray array];
        [buttonsArray addObjectsFromArray:inOtherButtonItemsArray];

        for (RIButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }

        if (inCancelButtonItem) {
            [buttonsArray insertObject:inCancelButtonItem atIndex:0];
	}

        objc_setAssociatedObject(self, RI_BUTTON_ASS_KEY, buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        [self setDelegate:self];
    }

    return self;
}

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... 
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

    return [self initWithTitle:inTitle message:inMessage cancelButtonItem:inCancelButtonItem otherButtonItemsArray:buttonsArray];
}

- (NSInteger)addButtonItem:(RIButtonItem *)item
{	
	NSMutableArray *buttonsArray = objc_getAssociatedObject(self, RI_BUTTON_ASS_KEY);	
	
	if (buttonsArray == nil) {
		buttonsArray = [NSMutableArray array];
		objc_setAssociatedObject(self, RI_BUTTON_ASS_KEY, buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	
	NSInteger buttonIndex = [self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];
	
	if ([self delegate] == nil) {
		[self setDelegate:self];
	}
	
	return buttonIndex;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// If the button index is -1 it means we were dismissed with no selection
	if (buttonIndex >= 0)
	{
		NSArray *buttonsArray = objc_getAssociatedObject(self, RI_BUTTON_ASS_KEY);
		RIButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];

		if (item.action) {
			item.action();
		}
	}
	
	objc_setAssociatedObject(self, RI_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
