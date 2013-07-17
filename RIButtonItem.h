//
//  RIButtonItem.h
//  Shibui
//
//  Created by Jiva DeVoe on 1/12/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RIButtonItemAction)(id view);

@interface RIButtonItem : NSObject
{
    NSString *label;
    RIButtonItemAction action;
}
@property (retain, nonatomic) NSString *label;
@property (copy, nonatomic) RIButtonItemAction action;
+(instancetype)item;
+(instancetype)itemWithLabel:(NSString *)inLabel;
+(instancetype)itemWithLabel:(NSString *)inLabel action:(RIButtonItemAction)action;
@end

