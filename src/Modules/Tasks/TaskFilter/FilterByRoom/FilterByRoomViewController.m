//
//  FilterByRoomViewController.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByRoomViewController.h"

@interface FilterByRoomViewController ()
// Properties
@property (weak, nonatomic) IBOutlet UITableView *filterByRoomTableView;


// Methods
- (IBAction)onSaveBtn:(UIButton *)sender;
- (IBAction)onSelectAllBtn:(UIButton *)sender;

- (IBAction)onResetBtn:(UIButton *)sender;
- (IBAction)onCanceledBtn:(UIBarButtonItem *)sender;
- (IBAction)onDoneBtn:(UIBarButtonItem *)sender;
@end

@implementation FilterByRoomViewController

- (void) loadView
{
    [super loadView];
    
}

- (IBAction)onSaveBtn:(UIButton *)sender {
}

- (IBAction)onSelectAllBtn:(UIButton *)sender {
}
- (IBAction)onResetBtn:(UIButton *)sender {
}

- (IBAction)onCanceledBtn:(UIBarButtonItem *)sender {
}

- (IBAction)onDoneBtn:(UIBarButtonItem *)sender {
}
@end
