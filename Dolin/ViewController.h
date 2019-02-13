//
//  ViewController.h
//  Dolin
//
//  Created by gestalt on 2018/10/8.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CustomVisualEffectView;

@interface ViewController : NSViewController <NSSplitViewDelegate, NSSearchFieldDelegate, NSTableViewDataSource, NSTableViewDelegate, NSPopoverDelegate>

@property (weak) IBOutlet NSSplitView *splitView;
@property (weak) IBOutlet CustomVisualEffectView *sidebarView;
@property (weak) IBOutlet NSView *bodyView;
@property (weak) IBOutlet NSSearchField *barcodeSearching;

@property (weak) IBOutlet NSTableView *outletTableView;
@property (weak) IBOutlet NSTableView *bottomTableView;

- (void)closePopover;

@end

