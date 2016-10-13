//
//  OnRevisionViewController.m
//  TookTODO
//
//  Created by Lera on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OnRevisionViewController.h"

@interface OnRevisionViewController ()

//Outlets
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIView *documentView;
@property (weak, nonatomic) IBOutlet UIButton *onDocumentAttach;
@property (weak, nonatomic) IBOutlet UILabel *documentNameLablel;

//Actions
- (IBAction)onBack:(UIBarButtonItem *)sender;

- (IBAction)onReady:(UIBarButtonItem *)sender;

@end

@implementation OnRevisionViewController


- (IBAction) onBack: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onReady: (UIBarButtonItem*) sender
{
    
}
@end
