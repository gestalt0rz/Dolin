//
//  WindowController.m
//  Dolin
//
//  Created by gestalt on 2018/11/6.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import "WindowController.h"

@interface WindowController ()

@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)windowWillClose:(NSNotification *)notification {
    
}

- (void)flagsChanged:(NSEvent *)event {
    if([event modifierFlags] & NSEventModifierFlagOption) {
        NSLog(@"key down option");
    } else {
        NSLog(@"key up option");
    }
}

@end
