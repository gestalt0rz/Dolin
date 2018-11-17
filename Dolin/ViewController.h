//
//  ViewController.h
//  Dolin
//
//  Created by gestalt on 2018/10/8.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSSplitViewController <NSSplitViewDelegate>

@property IBOutlet NSViewController* sidebarViewController;
@property IBOutlet NSViewController* bodyViewController;
@property IBOutlet NSView* sidebarView;
@property IBOutlet NSView* bodyView;

@property CGFloat fixedWidth;

@property IBOutlet NSSplitView* splitView ;

- (IBAction)collapseSidebar:(id)sender ;
- (IBAction)expandSidebar:(id)sender ;

@end

