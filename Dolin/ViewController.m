//
//  ViewController.m
//  Dolin
//
//  Created by gestalt on 2018/10/8.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"

@implementation ViewController

@dynamic splitView;

- (void)viewDidLoad {
    /*NSSplitViewItem* sidebarItem = [[NSSplitViewItem alloc] init] ;
    sidebarItem.viewController = self.sidebarViewController;
    [self insertSplitViewItem:sidebarItem atIndex:0] ;
    
    NSSplitViewItem* bodyItem = [[NSSplitViewItem alloc] init] ;
    bodyItem.viewController = self.bodyViewController;
    [self insertSplitViewItem:bodyItem atIndex:1] ;*/
    
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)setFixedWidth:(CGFloat)width {
    //[self.sidebarView removeWidthConstraints];
    
    [[self.splitViewItems firstObject] setMinimumThickness:width];
    [[self.splitViewItems firstObject] setMaximumThickness:width];
}

- (CGFloat)fixedWidth {
    return [self.splitViewItems firstObject].minimumThickness;
}

+ (NSSet*)keyPathsForValuesAffectingFixedWidth {
    return [NSSet setWithObjects:
            @"splitViewItems",
            nil] ;
}

- (IBAction)expandSidebar:(id)sender {
    [[[[self splitViewItems] firstObject] animator] setCollapsed:NO];
}

- (IBAction)collapseSidebar:(id)sender {
    [[[[self splitViewItems] firstObject] animator] setCollapsed:YES];
}


@end
