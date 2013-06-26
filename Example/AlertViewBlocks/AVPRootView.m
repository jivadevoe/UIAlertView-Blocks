//
//  AVPRootView.m
//  AlertViewBlocks
//
//  Created by Pierre-Luc Simard on 6/26/2013.
//  Copyright (c) 2013 UIAlertView-Blocks. All rights reserved.
//

#import "AVPRootView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AVPRootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Add the button
        _alertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_alertButton setTitle:@"Tap me" forState:UIControlStateNormal];
        [_alertButton.titleLabel setFont:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];
        [_alertButton.titleLabel setTextColor:[UIColor blackColor]];

        [self addSubview:_alertButton];
    }
    return self;
}

- (void)centerInView:(UIView*)target
{
    CGSize viewSize = self.bounds.size;
    CGSize targetSize = target.bounds.size;
    CGFloat targetY = floorf(viewSize.height/2.0f - targetSize.height/2.0f);
    CGFloat targetX = floorf(viewSize.width/2.0f - targetSize.width/2.0f);
    CGRect targetFrame = CGRectMake(targetX, targetY, targetSize.width, targetSize.height);

    target.frame = targetFrame;
}

- (void)sizeButton:(UIButton*)target accordingToTextWithInsets:(UIEdgeInsets)insets
{
    NSString* text = target.titleLabel.text;
    CGSize textSize = [text sizeWithFont:target.titleLabel.font];
    CGFloat targetWidth = insets.left + textSize.width + insets.right;
    CGFloat targetHeight = insets.top + textSize.height + insets.bottom;
    CGRect targetBounds = CGRectMake(0.0f, 0.0f, targetWidth, targetHeight);

    target.bounds = targetBounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self sizeButton:_alertButton accordingToTextWithInsets:UIEdgeInsetsMake(10.0f, 22.0f, 10.0f, 22.0f)];
    [self centerInView:_alertButton];
}


@end
