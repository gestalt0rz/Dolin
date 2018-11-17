//
//  ViewController.m
//  Dolin
//
//  Created by gestalt on 2018/10/8.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"

@interface ViewController () {
    NSString *barcodeString;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [_splitView setDelegate:self];
    [_barcodeTextField setDelegate:self];
    
    [self drawBackgroudColor:[[NSColor blackColor] CGColor] view:[self view]];
    [self drawBackgroudColor:[[NSColor darkGrayColor] CGColor] view:_sidebarView];
    [self drawBackgroudColor:[[NSColor lightGrayColor] CGColor] view:_bodyView];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
    [self drawBackgroudColor:[[NSColor cyanColor] CGColor] view:[self view]];
}

#pragma mark - Delegate Callback Functions

-(void)splitView:(NSSplitView *)sender resizeSubviewsWithOldSize:(NSSize)oldSize {
    NSLog(@"%@ %@", [self className], NSStringFromSelector(_cmd));
    CGFloat dividerThickness = [sender dividerThickness];
    NSRect leftRect = [[[sender subviews] objectAtIndex:0] frame];
    NSRect rightRect = [[[sender subviews] objectAtIndex:1] frame];
    NSRect newFrame = [sender frame];
    
    leftRect.size.height = newFrame.size.height;
    leftRect.origin = NSMakePoint(0, 0);
    rightRect.size.width = newFrame.size.width - leftRect.size.width
    - dividerThickness;
    rightRect.size.height = newFrame.size.height;
    rightRect.origin.x = leftRect.size.width + dividerThickness;
    
    [[[sender subviews] objectAtIndex:0] setFrame:leftRect];
    [[[sender subviews] objectAtIndex:1] setFrame:rightRect];
}

-(void)controlTextDidEndEditing:(NSNotification *)notification {
    // See if it was due to a return
    if ( [[[notification userInfo] objectForKey:@"NSTextMovement"] intValue] == NSReturnTextMovement ) {
        barcodeString = [_barcodeTextField stringValue];
        [_barcodeTextField setStringValue:@""];
        NSLog(@"Return was pressed! %@", barcodeString);
    }
}

#pragma mark - Private

- (void)drawBackgroudColor:(CGColorRef)color view:(NSView *)view {
    [view setWantsLayer:YES];
    [view.layer setBackgroundColor:color];
}

@end
