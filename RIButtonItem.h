//
//  RIButtonItem.h
//  Shibui
//
//  Created by Jiva DeVoe on 1/12/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RISimpleAction)();

@interface RIButtonItem : NSObject
{
    NSString *label;
    RISimpleAction action;
}
@property (retain, nonatomic) NSString *label;
@property (copy, nonatomic) RISimpleAction action;
+(id)item;
+(id)itemWithLabel:(NSString *)inLabel;
@end

