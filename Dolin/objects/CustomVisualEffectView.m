//
//  CustomVisualEffectView.m
//  Dolin
//
//  Created by gestalt on 2018/12/28.
//  Copyright © 2018 gestalt. All rights reserved.
//

#import "CustomVisualEffectView.h"
#import "ViewController.h"
#import "Account.h"

#pragma mark - CustomVisualEffectView

@interface CustomVisualEffectView () {
    NSPoint initialLocation;
    BOOL isMovable;
}
@end

@implementation CustomVisualEffectView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)mouseUp:(NSEvent *)event{
    isMovable = NO;
}

- (void)mouseDown:(NSEvent *)event {
    //NSLog(@"mouseDown");
    NSRect windowFrame = [[self window] frame];
    
    initialLocation = [NSEvent mouseLocation];
    
    initialLocation.x -= windowFrame.origin.x;
    initialLocation.y -= windowFrame.origin.y;
 
    if([self mouse:initialLocation inRect:[self frame]])
        isMovable = YES;
    else
        isMovable = NO;
}

- (void)mouseDragged:(NSEvent *)event {
    //NSLog(@"mouseDragged");
    if (!isMovable) return;
    
    NSPoint currentLocation;
    NSPoint newOrigin;
    
    NSRect  screenFrame = [[NSScreen mainScreen] frame];
    NSRect  windowFrame = [self frame];
    
    currentLocation = [NSEvent mouseLocation];
    newOrigin.x = currentLocation.x - initialLocation.x;
    newOrigin.y = currentLocation.y - initialLocation.y;
    
    // Don't let window get dragged up under the menu bar
    if( (newOrigin.y+windowFrame.size.height) > (screenFrame.origin.y+screenFrame.size.height) ){
        newOrigin.y=screenFrame.origin.y + (screenFrame.size.height-windowFrame.size.height);
    }
    
    //go ahead and move the window to the new location
    [[self window] setFrameOrigin:newOrigin];
}

@end

#pragma mark - CustomTableRowView

@implementation CustomTableRowView

- (void)drawSelectionInRect:(NSRect)dirtyRect {
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        /*NSRect selectionRect = NSInsetRect(self.bounds, 0, 0);
        [[NSColor lightGrayColor] setFill];
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:0 yRadius:0];
        [selectionPath fill];*/
        
        NSRect selectionRect = NSInsetRect(self.bounds, 2.5, 2.5);
        [[NSColor colorWithCalibratedWhite:.65 alpha:1.0] setStroke];
        [[NSColor colorWithCalibratedWhite:.82 alpha:1.0] setFill];
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:6 yRadius:6];
        [selectionPath fill];
        [selectionPath stroke];
    }
}

@end

#pragma mark - CustomImageView

@interface CustomImageView () {
    NSTrackingArea *trackingArea;
    NSImageView *largeImageView;
}
@end

@implementation CustomImageView

- (void)mouseEntered:(NSEvent *)theEvent {
    //NSLog(@"Mouse entered");
    largeImageView = [NSImageView imageViewWithImage:self.image];
    [largeImageView setFrame:NSMakeRect(13, 5, 48, 48)];
    
    [largeImageView setWantsLayer:YES];
    
    largeImageView.layer.cornerRadius = largeImageView.frame.size.width / 2;
    largeImageView.layer.masksToBounds = YES;
    
    [[self superview] addSubview:largeImageView];
}

- (void)mouseExited:(NSEvent *)theEvent {
    //NSLog(@"Mouse exited");
    
    [largeImageView removeFromSuperview];
    largeImageView = nil;
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    if(trackingArea != nil) {
        [self removeTrackingArea:trackingArea];
        trackingArea = nil;
    }
    
    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:opts
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:trackingArea];
}

@end

#pragma mark - popoverViewController

@interface popoverViewController () {
    NSArray *staticItems;
    NSInteger itemsCount;
    Account *acc;
}
@end

@implementation popoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    acc = [Account sharedAccount];
    
    // table view
    staticItems = @[
                    @[[acc getAccountImage:ACCOUNT_NORMAL], [acc getAccountName:ACCOUNT_NORMAL]],
                    @[[acc getAccountImage:ACCOUNT_ADMIN], [acc getAccountName:ACCOUNT_ADMIN]],
                    @[[acc getAccountImage:ACCOUNT_PROGRAMMER], [acc getAccountName:ACCOUNT_PROGRAMMER]],
                    ];
    itemsCount = [staticItems count];
    
    [_accountTableView setUsesStaticContents:YES];
    [_accountTableView setDelegate:self];
    [_accountTableView setDataSource:self];
}

-(void)close{
    //NSLog(@"%@ %@", [self className], NSStringFromSelector(_cmd));
    if([(ViewController *)_container respondsToSelector:@selector(closePopover)])
        [(ViewController *)_container closePopover];
}

// DataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return itemsCount;
}

// Delegate
- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    NSString *strIdt = @"accountView";
    NSTableCellView *cell = [tableView makeViewWithIdentifier:strIdt owner:self];
    
    cell.imageView.image = [NSImage imageNamed:staticItems[row][0]];
    [cell.imageView setWantsLayer:YES];
    
    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width / 2;
    cell.imageView.layer.masksToBounds = YES;
    
    cell.textField.stringValue = staticItems[row][1];
    
    return cell;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView* tableView = notification.object;
    NSInteger row = [tableView selectedRow];
    
    if(row != -1) {
        switch (row) {
            case ACCOUNT_NORMAL:
                [acc logout];
                break;
            case ACCOUNT_ADMIN:
            case ACCOUNT_PROGRAMMER:
                [self showPasswordAlert:(AccountType)row];
                break;
            default:
                break;
        }
        
        [tableView deselectAll:nil];
        [self close];
    }
}

#pragma mark - nsalert on sheet

- (void)showPasswordAlert:(AccountType)type {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"登入"];
    [alert addButtonWithTitle:@"取消"];
    
    NSSecureTextField *passwordTextField = [[NSSecureTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    NSStackView *stack = [[NSStackView alloc] initWithFrame:NSMakeRect(0, 0, 200, 34)];
    [stack addSubview:passwordTextField];
    [alert setAccessoryView:stack];
    
    [alert setMessageText:[acc getAccountName:type]];
    [alert setInformativeText:@"請輸入登入密碼"];
    [alert setAlertStyle:NSAlertStyleInformational];
    [alert beginSheetModalForWindow:[[(ViewController *)_container view] window] completionHandler:^(NSModalResponse returnCode){
        if (returnCode == NSAlertFirstButtonReturn) {
            NSLog(@"(returnCode == NSModalResponseOK)");
            BOOL result = [self->acc login:type password:[passwordTextField stringValue]];
            NSLog(@"login result: %@", result?@"YES":@"NO");
            if (result) {
                [self close];
            }else {
                NSAlert *errorAlert = [[NSAlert alloc] init];
                [errorAlert addButtonWithTitle:@"OK"];
                [errorAlert setMessageText:@"密碼錯誤"];
                [errorAlert setAlertStyle:NSAlertStyleWarning];
                [errorAlert beginSheetModalForWindow:[[(ViewController *)self->_container view] window] completionHandler:^(NSModalResponse returnCode){
                    NSLog(@"error alert ok");
                }];
            }
        }else {
            NSLog(@"password alert cancel");
        }
    }];
}

@end
