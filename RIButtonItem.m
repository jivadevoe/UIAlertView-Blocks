//
//  RIButtonItem.m
//  Shibui
//
//  Created by Jiva DeVoe on 1/12/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import "RIButtonItem.h"

@implementation RIButtonItem

@synthesize label;
@synthesize action;

+(id)item
{
    return [self new];
}

+(id)itemWithLabel:(NSString *)inLabel
{
    RIButtonItem *newItem = [self item];
    [newItem setLabel:inLabel];
    return newItem;
}

+(id)itemWithLabel:(NSString *)label andAction:(void(^)())action
{
    RIButtonItem *newItem = (RIButtonItem *)[self item];
    newItem.label = label;
    newItem.action = action;
    return newItem;
}

- (id)initWithLabel:(NSString *)label {
    return [self initWithLabel:nil andAction:nil];
}

- (id)initWithLabel:(NSString *)_label andAction:(void(^)())_action
{
    self = [super init];
    if (self) {
        self.label  = label;
        self.action = action;
    }
    return self;
}


@end

