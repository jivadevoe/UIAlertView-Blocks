//
//  UIActionSheet+Blocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 1/5/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

@interface UIActionSheet (Blocks) <UIActionSheetDelegate>

/** This block is called when the action sheet is dismssed for any reason other than a button
 press. If the user taps outside the view, for example. 
 */
@property (copy, nonatomic) RISimpleAction dismissalAction;

-(id)initWithTitle:(NSString *)inTitle cancelButtonItem:(RIButtonItem *)inCancelButtonItem destructiveButtonItem:(RIButtonItem *)inDestructiveItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;
-(id)initWithTitle:(NSString *)inTitle cancelButtonItem:(RIButtonItem *)inCancelButtonItem destructiveButtonItem:(RIButtonItem *)inDestructiveItem otherButtonItemsArray:(NSArray *)inOtherButtonItems;

- (NSInteger)addButtonItem:(RIButtonItem *)item;

@end
