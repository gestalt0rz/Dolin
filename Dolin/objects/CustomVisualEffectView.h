//
//  CustomVisualEffectView.h
//  Dolin
//
//  Created by gestalt on 2018/12/28.
//  Copyright © 2018 gestalt. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomVisualEffectView : NSVisualEffectView

@end

@interface CustomTableRowView : NSTableRowView
- (void)drawSelectionInRect:(NSRect)dirtyRect;
@end

//@interface NSSearchFieldCell (height)
//- (void) drawWithFrame:(NSRect)cellFrame inView:(NSView*)controlView;
//@end

NS_ASSUME_NONNULL_END
