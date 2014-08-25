//
//  RIButtonItem.h
//  Shibui
//
//  Created by Jiva DeVoe on 1/12/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIButtonItem : NSObject
{
    NSString *label;
    void (^action)(id alertViewOrActionSheet);
}
@property (retain, nonatomic) NSString *label;
@property (copy, nonatomic) void (^action)(id alertViewOrActionSheet);
+(id)item;
+(id)itemWithLabel:(NSString *)inLabel;
+(id)itemWithLabel:(NSString *)inLabel action:(void(^)(id alertViewOrActionSheet))action;
@end

