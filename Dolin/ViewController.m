//
//  ViewController.m
//  Dolin
//
//  Created by gestalt on 2018/10/8.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import "ViewController.h"
#import "Account.h"
#import "DBManager.h"
#import "objects/CustomVisualEffectView.h"

@interface ViewController () {
    NSString *barcodeString;
    CGFloat sidebarWidth;
    NSArray *staticItems;
    NSInteger itemsCount;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    // search bar
    [_barcodeSearching setFrameSize:NSZeroSize];
    [_barcodeSearching setDelegate:self];
    
    // sidebar and body
    [_splitView setDelegate:self];
    sidebarWidth = [_sidebarView frame].size.width;
    [self drawBackgroudColor:[[NSColor colorWithRed:32.0f/255 green:33.0f/255 blue:36.0f/255 alpha:1.0f] CGColor] view:_bodyView];
    
    // table view
    staticItems = @[
                    @[NSImageNameNetwork, @"訂單"],
                    @[NSImageNameApplicationIcon, @"婚紗"],
                    @[NSImageNameUserGuest, @"客戶"],
                    @[NSImageNameAdvanced, @"廠商"],
                    @[NSImageNameMultipleDocuments, @"報表"]
                    ];
    itemsCount = [staticItems count];
    
    [_outletTableView setUsesStaticContents:YES];
    [_outletTableView setDelegate:self];
    [_outletTableView setDataSource:self];
    
    [_bottomTableView setUsesStaticContents:YES];
    [_bottomTableView setDelegate:self];
    [_bottomTableView setDataSource:self];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark - Delegate Callback Functions

- (void)splitView:(NSSplitView *)sender resizeSubviewsWithOldSize:(NSSize)oldSize {
    //NSLog(@"%@ %@", [self className], NSStringFromSelector(_cmd));
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

- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview {
    return NO;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex {
    if (proposedMinimumPosition < sidebarWidth) {
        proposedMinimumPosition = sidebarWidth;
    }
    return proposedMinimumPosition;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex {
    if (proposedMaximumPosition > sidebarWidth) {
        proposedMaximumPosition = sidebarWidth;
    }
    return proposedMaximumPosition;
}

-(void)controlTextDidEndEditing:(NSNotification *)notification {
    // See if it was due to a return
    if ( [[[notification userInfo] objectForKey:@"NSTextMovement"] intValue] == NSReturnTextMovement ) {
        barcodeString = [_barcodeSearching stringValue];
        [_barcodeSearching setStringValue:@""];
        NSLog(@"Return was pressed! %@", barcodeString);
    }
}

#pragma mark - TableView Method

// DataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if(tableView == _bottomTableView) return 1;
    else return itemsCount;
}

// Delegate
- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    //NSString *columnID = tableColumn.identifier;
    //NSLog(@"columnID : %@ ,row : %ld",columnID,(long)row);
    NSString *strIdt = nil;
    NSTableCellView *cell = nil;
    
    if(tableView == _bottomTableView) {
        strIdt = @"loginView";
        cell = [tableView makeViewWithIdentifier:strIdt owner:self];
        
        cell.imageView.image = [NSImage imageNamed:[[Account sharedAccount] getCurrentAccountImage]];
        [cell.imageView setWantsLayer:YES];
        
        //cell.imageView.layer.borderWidth = 0;
        //cell.imageView.layer.borderColor = [NSColor whiteColor].CGColor;
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width / 2;
        cell.imageView.layer.masksToBounds = YES;
        
        cell.textField.stringValue = [[Account sharedAccount] getCurrentAccountName];
    } else {
        strIdt = @"cellView";
        cell = [tableView makeViewWithIdentifier:strIdt owner:self];
        
        /*if (!cell) {
            cell = [[NSTableCellView alloc]init];
            cell.identifier = strIdt;
        }*/
        //CustomTableRowView *cRowView = (CustomTableRowView *)[tableView rowViewAtRow:row makeIfNecessary:NO];
        //[cRowView setEmphasized:NO];
        cell.imageView.image = [NSImage imageNamed:staticItems[row][0]];
        cell.textField.stringValue = staticItems[row][1];
    }
    
    return cell;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView* tableView = notification.object;
    NSInteger row = [tableView selectedRow];
    
    //TODO change body view
    
    if(row != -1) {
        if (tableView == _bottomTableView) {
            [_outletTableView deselectAll:nil];
        }else{
            [_bottomTableView deselectAll:nil];
        }
    }
}

#pragma mark - Private

- (void)drawBackgroudColor:(CGColorRef)color view:(NSView *)view {
    [view setWantsLayer:YES];
    [view.layer setBackgroundColor:color];
}

@end
