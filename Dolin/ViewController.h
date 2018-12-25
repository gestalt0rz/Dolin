//
//  ViewController.h
//  Dolin
//
//  Created by gestalt on 2018/10/8.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSSplitViewDelegate, NSSearchFieldDelegate>

@property (weak) IBOutlet NSSplitView *splitView;
@property (weak) IBOutlet NSVisualEffectView *sidebarView;
@property (weak) IBOutlet NSView *bodyView;
@property (weak) IBOutlet NSSearchField *barcodeSearching;


@end

