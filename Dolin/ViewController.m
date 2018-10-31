//
//  ViewController.m
//  Dolin
//
//  Created by gestalt on 2018/10/8.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [DBManager sharedManager];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
