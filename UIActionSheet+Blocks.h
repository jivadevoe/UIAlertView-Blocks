//
//  UIActionSheet+Blocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 1/5/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

/// Specifies if the button should is a destructive button or a cancel button
typedef enum : NSInteger {
	UIActionSheetButtonTypeNormal, /*!< Normal button, no additional styling */
	UIActionSheetButtonTypeDestructive, /*!< Destructive button, styled in red
										 background pre-iOS 7, and in red
										 foreground color in iOS 7 */
	UIActionSheetButtonTypeCancel, /*!< Cancel button, styled with darker
									background pre-iOS 7, and physically
									separated from other buttons in iOS 7 */
} UIActionSheetButtonType;

@interface UIActionSheet (Blocks) <UIActionSheetDelegate>

-(id)initWithTitle:(NSString *)inTitle;
	
-(id)initWithTitle:(NSString *)inTitle cancelButtonItem:(RIButtonItem *)inCancelButtonItem destructiveButtonItem:(RIButtonItem *)inDestructiveItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonItem:(RIButtonItem *)item;

- (NSInteger)addButtonWithTitle:(NSString *)title
						   type:(UIActionSheetButtonType)buttonType
						 action:(void(^)(void))action;
	
/** This block is called when the action sheet is dismssed for any reason.
 */
@property (copy, nonatomic) void(^dismissalAction)();

@end
