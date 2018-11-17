#import <Cocoa/Cocoa.h>

@protocol FixedSidebarSplitViewDelegate <NSSplitViewDelegate>

@optional
- (IBAction)collapseSidebar:(id)sender;
- (IBAction)expandSidebar:(id)sender;
@end

@interface FixedSidebarSplitView : NSSplitView
@property (weak) id<FixedSidebarSplitViewDelegate> delegate;
@end

