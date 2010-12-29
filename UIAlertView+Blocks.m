//
//  UIAlertView+Blocks.m
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

@implementation UIAlertViewButtonItem
@synthesize label;
@synthesize action;

+(id)item
{
    return [[self new] autorelease];
}

@end

@implementation UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(UIAlertViewButtonItem *)inCancelButtonItem otherButtonItems:(UIAlertViewButtonItem *)inOtherButtonItems, ... 
{
    NSMutableArray *buttonsArray = [NSMutableArray array];
    
    UIAlertViewButtonItem *eachItem;
    va_list argumentList;
    if (inOtherButtonItems)                     
    {                                  
        [buttonsArray addObject: inOtherButtonItems];
        va_start(argumentList, inOtherButtonItems);       
        while((eachItem = va_arg(argumentList, UIAlertViewButtonItem *))) 
        {
            [buttonsArray addObject: eachItem];            
        }
        va_end(argumentList);
    }    
    
    if((self = [self initWithTitle:inTitle message:inMessage delegate:self cancelButtonTitle:inCancelButtonItem.label otherButtonTitles:nil]))
    {
        for(UIAlertViewButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }
        
        if(inCancelButtonItem)
            [buttonsArray insertObject:inCancelButtonItem atIndex:0];
        
        objc_setAssociatedObject(self, @"com.random-ideas.BUTTONS", buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setDelegate:self];
        [self retain]; // keep yourself around!
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSArray *buttonsArray = objc_getAssociatedObject(self, @"com.random-ideas.BUTTONS");
    UIAlertViewButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
    if(item.action)
        item.action();
    objc_setAssociatedObject(self, @"com.random-ideas.BUTTONS", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self release]; // and release yourself!
}

@end
