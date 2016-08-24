//
//  PopoverViewController.m
//  TookTODO
//
//  Created by Глеб on 23.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "PopoverViewController.h"
#import "SortModel.h"

@interface PopoverViewController ()

@property (weak, nonatomic) IBOutlet UITableView *popoverTableView;

@property (strong, nonatomic) SortModel* sortModel;

@end

@implementation PopoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.popoverTableView.dataSource = self.sortModel;
    self.popoverTableView.delegate   = self.sortModel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
