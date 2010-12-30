//
//  UIAlertView+Blocks.m
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

@implementation RIAlertViewButtonItem
@synthesize label;
@synthesize action;

+(id)item
{
    return [[self new] autorelease];
}

+(id)itemWithLabel:(NSString *)inLabel
{
    id newItem = [self item];
    [newItem setLabel:inLabel];
    return newItem;
}

@end

@implementation UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIAlertViewButtonItem *)inCancelButtonItem otherButtonItems:(RIAlertViewButtonItem *)inOtherButtonItems, ... 
{
    if((self = [self initWithTitle:inTitle message:inMessage delegate:self cancelButtonTitle:inCancelButtonItem.label otherButtonTitles:nil]))
    {
        NSMutableArray *buttonsArray = [NSMutableArray array];
        
        RIAlertViewButtonItem *eachItem;
        va_list argumentList;
        if (inOtherButtonItems)                     
        {                                  
            [buttonsArray addObject: inOtherButtonItems];
            va_start(argumentList, inOtherButtonItems);       
            while((eachItem = va_arg(argumentList, RIAlertViewButtonItem *))) 
            {
                [buttonsArray addObject: eachItem];            
            }
            va_end(argumentList);
        }    
        
        for(RIAlertViewButtonItem *item in buttonsArray)
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
    RIAlertViewButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
    if(item.action)
        item.action();
    objc_setAssociatedObject(self, @"com.random-ideas.BUTTONS", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self release]; // and release yourself!
}

@end
