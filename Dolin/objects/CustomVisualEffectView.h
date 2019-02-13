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

@interface CustomImageView : NSImageView

@end

@interface popoverViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *accountTableView;
@property (weak) id container;
@end

NS_ASSUME_NONNULL_END
