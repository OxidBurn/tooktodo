//
//  TaskViewController.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;

// properties


// methods
- (IBAction)onBackBtn:(UIBarButtonItem *)sender;

- (IBAction)onChangeBtn:(UIBarButtonItem *)sender;

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackBtn:(UIBarButtonItem *)sender {
}

- (IBAction)onChangeBtn:(UIBarButtonItem *)sender {
}
@end
