//
//  OSAlertViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertViewController.h"

@implementation OSAlertViewController


- (IBAction) onDismiss: (UITapGestureRecognizer*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

@end
