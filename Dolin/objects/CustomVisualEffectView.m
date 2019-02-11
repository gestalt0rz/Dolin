//
//  CustomVisualEffectView.m
//  Dolin
//
//  Created by gestalt on 2018/12/28.
//  Copyright © 2018 gestalt. All rights reserved.
//

#import "CustomVisualEffectView.h"

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

//@implementation NSSearchFieldCell (height)

//@end
