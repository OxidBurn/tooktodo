//
//  OnRevisionViewController.m
//  TookTODO
//
//  Created by Lera on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OnRevisionViewController.h"

@interface OnRevisionViewController ()

- (IBAction)onBack:(UIBarButtonItem *)sender;


- (IBAction)onReady:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIView *documentView;
@property (weak, nonatomic) IBOutlet UIButton *onDocumentAttach;
@property (weak, nonatomic) IBOutlet UILabel *documentNameLablel;

@end

@implementation OnRevisionViewController


- (IBAction)onBack:(UIBarButtonItem *)sender {
}

- (IBAction)onReady:(UIBarButtonItem *)sender {
}
@end
