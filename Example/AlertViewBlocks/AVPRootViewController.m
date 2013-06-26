//
//  AVPRootViewController.m
//
#import "AVPRootViewController.h"
#import "AVPRootView.h"
#import "UIAlertView+Blocks.h"

@implementation AVPRootViewController
- (void)loadView
{
    [super loadView];

    // Create the View
    AVPRootView *rootView = [[AVPRootView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = rootView;

    // Register for button action
    [rootView.alertButton addTarget:self action:@selector(didTapViewAlertButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTapViewAlertButton:(UIEvent*)event
{
    WeakSelf weakSelf = self;
    RIButtonItem* start = [RIButtonItem itemWithLabel:@"OK, lets start!" action:^{
        [weakSelf try:5];
    }];

    // Show the first dialog of the game
    [[[UIAlertView alloc] initWithTitle:@"Guessing game" message:@"Think of a number between 1 and 10" cancelButtonItem:nil otherButtonItems:start, nil] show];
}

- (void)try:(NSUInteger)trying
{
    // ensure it's between 1 and 10
    trying = MIN(MAX(1,trying),10);

    WeakSelf weakSelf = self;
    RIButtonItem* lower = [RIButtonItem itemWithLabel:@"Lower" action:^{
        [weakSelf try:trying-1];
    }];
    RIButtonItem* higher = [RIButtonItem itemWithLabel:@"Higher" action:^{
        [weakSelf try:trying+roundf(trying/2.0f)];
    }];
    RIButtonItem* finish = [RIButtonItem itemWithLabel:@"Yes!" action:^{
        [weakSelf finish];
    }];

    // Show the first dialog of the game
    [[[UIAlertView alloc] initWithTitle:@"Is it?" message:[NSString stringWithFormat:@"%d",trying] cancelButtonItem:nil otherButtonItems:lower, higher, finish, nil] show];
}

- (void)finish
{
    RIButtonItem* no = [RIButtonItem itemWithLabel:@"Not so much"];
    RIButtonItem* yes = [RIButtonItem itemWithLabel:@"Yes indeed!"];

    [[[UIAlertView alloc] initWithTitle:@"Thank you" message:@"I had fun. How about you?" cancelButtonItem:no otherButtonItems:yes, nil] show];
}

@end
