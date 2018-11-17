//
//  ViewController.h
//  Dolin
//
//  Created by gestalt on 2018/10/8.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "FixedSidebarSplitView.h"

@interface ViewController : NSViewController <NSSplitViewDelegate, NSTextFieldDelegate>

@property (weak) IBOutlet NSSplitView *splitView;
@property (weak) IBOutlet NSView *sidebarView;
@property (weak) IBOutlet NSView *bodyView;
@property (weak) IBOutlet NSTextField *barcodeTextField;

@end

