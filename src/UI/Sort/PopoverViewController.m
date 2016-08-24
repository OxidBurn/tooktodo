//
//  PopoverViewController.m
//  TookTODO
//
//  Created by Глеб on 23.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "PopoverViewController.h"

@interface PopoverViewController () <PopoverModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView* popoverTableView;

@property (strong, nonatomic) PopoverModel* model;

@end

@implementation PopoverViewController

- (void)loadView
{
    [super loadView];
    
//    self.preferredContentSize = [self.model getContentSize]
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.popoverTableView.dataSource = self.model;
    self.popoverTableView.delegate   = self.model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (PopoverModel *)model
{
    if ( _model == nil )
    {
        _model = [PopoverModel new];
        
        _model.delegate = self;
    }
    return _model;
}


#pragma mark - Public methods -

- (void) setPopoverModel: (PopoverModel*) model
{
    self.model = model;
}


#pragma mark - SortModelDelegate methods -

- (void) dismissPopover
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

@end
