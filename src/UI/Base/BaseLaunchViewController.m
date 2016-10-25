//
//  BaseLaunchViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseLaunchViewController.h"

@interface BaseLaunchViewController ()

@end

@implementation BaseLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Orientations -

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    if ( IS_PHONE )
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    else
    {
        return (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight);
    }
}


@end
