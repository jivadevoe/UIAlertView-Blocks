//
//  UIAlertView+Blocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AlertViewAction)();

@interface UIAlertViewButtonItem : NSObject
{
    NSString *name;
    AlertViewAction action;
}
@property (retain, nonatomic)  NSString *name;
@property (copy, nonatomic) AlertViewAction action;
+(id)item;
@end


@interface UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(UIAlertViewButtonItem *)inCancelButtonItem otherButtonItems:(UIAlertViewButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

@end
