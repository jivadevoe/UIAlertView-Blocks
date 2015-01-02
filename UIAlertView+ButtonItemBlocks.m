//
//  UIAlertView+ButtonItemBlocks.m
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import "UIAlertView+ButtonItemBlocks.h"
#import <objc/runtime.h>





static NSString *RI_BUTTON_ASS_KEY = @"com.random-ideas.BUTTONS";
static NSString *RI_AlertViewDelegate_ASS_KEY = @"com.random-ideas.AlertViewDelegate";





@class ButtonItemBlocks_AlertViewDelegate;
@protocol ButtonItemBlocks_AlertViewDelegate_Delegate <NSObject>

-(void)buttonItemBlocks_AlertViewDelegate:(ButtonItemBlocks_AlertViewDelegate*)buttonItemBlocks_AlertViewDelegate didHandleAlertViewClickAtButtonIndex:(NSInteger)buttonIndex;

@end





@interface ButtonItemBlocks_AlertViewDelegate : NSObject <UIAlertViewDelegate>

@property (nonatomic, assign) id<ButtonItemBlocks_AlertViewDelegate_Delegate> delegate;

@end

@implementation ButtonItemBlocks_AlertViewDelegate

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[self.delegate buttonItemBlocks_AlertViewDelegate:self didHandleAlertViewClickAtButtonIndex:buttonIndex];
}

@end





@implementation UIAlertView (ButtonItemBlocks)

- (id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ...
{
	if((self = [self initWithTitle:inTitle message:inMessage delegate:self cancelButtonTitle:inCancelButtonItem.label otherButtonTitles:nil]))
	{
		NSMutableArray *buttonsArray = [self buttonItems];
		
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
		
		if(inCancelButtonItem)
			[buttonsArray insertObject:inCancelButtonItem atIndex:0];
		
		[self setDelegateToButtonItemBlocks_AlertViewDelegate];
	}
	return self;
}

-(void)setDelegateToButtonItemBlocks_AlertViewDelegate
{
	ButtonItemBlocks_AlertViewDelegate* buttonItemBlocks_AlertViewDelegate = [ButtonItemBlocks_AlertViewDelegate new];
	[buttonItemBlocks_AlertViewDelegate setDelegate:(id<ButtonItemBlocks_AlertViewDelegate_Delegate>)self];
	[self setButtonItemBlocks_AlertViewDelegate:buttonItemBlocks_AlertViewDelegate];
	[self setDelegate:buttonItemBlocks_AlertViewDelegate];
}

- (NSInteger)addButtonItem:(RIButtonItem *)item
{
	NSInteger buttonIndex = [self addButtonWithTitle:item.label];
	[[self buttonItems] addObject:item];
	
	if (![self delegate])
	{
		[self setDelegateToButtonItemBlocks_AlertViewDelegate];
	}
	
	return buttonIndex;
}

- (NSMutableArray *)buttonItems
{
	NSMutableArray *buttonItems = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);
	if (!buttonItems)
	{
		buttonItems = [NSMutableArray array];
		objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, buttonItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	
	return buttonItems;
}

#pragma mark - ButtonItemBlocks_AlertViewDelegate_Delegate
-(void)buttonItemBlocks_AlertViewDelegate:(ButtonItemBlocks_AlertViewDelegate*)buttonItemBlocks_AlertViewDelegate didHandleAlertViewClickAtButtonIndex:(NSInteger)buttonIndex
{
	[self setButtonItemBlocks_AlertViewDelegate:nil];
	
	// If the button index is -1 it means we were dismissed with no selection
	if (buttonIndex >= 0)
	{
		NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);
		RIButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
		if(item.action)
			item.action();
	}
	
	objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - AlertViewDelegate
-(ButtonItemBlocks_AlertViewDelegate*)buttonItemBlocks_AlertViewDelegate
{
	return objc_getAssociatedObject(self, (__bridge const void *)RI_AlertViewDelegate_ASS_KEY);
}

-(void)setButtonItemBlocks_AlertViewDelegate:(ButtonItemBlocks_AlertViewDelegate*)buttonItemBlocks_AlertViewDelegate
{
	if ([self buttonItemBlocks_AlertViewDelegate] == buttonItemBlocks_AlertViewDelegate)
	{
		return;
	}
	
	objc_setAssociatedObject(self, (__bridge const void *)RI_AlertViewDelegate_ASS_KEY, buttonItemBlocks_AlertViewDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
