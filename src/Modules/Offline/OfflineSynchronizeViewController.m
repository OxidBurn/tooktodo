//
//  OfflineSinchronizeViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/20/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OfflineSynchronizeViewController.h"

// Categories
#import "DataManager+ProjectInfo.h"

#import "OfflineTableViewCell.h"

@interface OfflineSynchronizeViewController () <UITableViewDataSource, UITabBarDelegate>

// properties

@property (weak, nonatomic) IBOutlet UITableView *synchronizeOptionsTable;

@property (weak, nonatomic) IBOutlet UIView *deviceUsedSpaceIndicatorView;

@property (weak, nonatomic) IBOutlet UIView *potentialUsedSpaceAfterSyncView;
@property (weak, nonatomic) IBOutlet UIButton *startSyncBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deviceUsedSpaceTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *potentialUsedTrailingConstraint;

// methods

@end

@implementation OfflineSynchronizeViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self twoLineTitleView];
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    self.synchronizeOptionsTable.rowHeight = UITableViewAutomaticDimension;
    self.synchronizeOptionsTable.estimatedRowHeight = 69;
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions -

- (IBAction) onDoneClick: (id) sender
{
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction) onCancelClick: (id) sender
{
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - Internal method -

- (UIView*) twoLineTitleView
{
    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 14.0f];
    UIFont* customFontForSubTitle = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 13.0f];
    
    UILabel* titleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor       = [UIColor whiteColor];
    titleLabel.font            = customFont;
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.text            = @"РАБОТА В ОФФЛАЙНЕ";
    [titleLabel sizeToFit];
    
    UILabel* subTitleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 17, 0, 0)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor       = [UIColor whiteColor];
    subTitleLabel.font            = customFontForSubTitle;
    subTitleLabel.textAlignment   = NSTextAlignmentCenter;
    subTitleLabel.text            = [DataManagerShared getSelectedProjectName];
    [subTitleLabel sizeToFit];
    
    UIView* twoLineTitleView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, MAX(subTitleLabel.frame.size.width, titleLabel.frame.size.width), 32)];
    
    [twoLineTitleView addSubview: titleLabel];
    [twoLineTitleView addSubview: subTitleLabel];
    
    float widthDiff = subTitleLabel.frame.size.width - titleLabel.frame.size.width;
    
    if (widthDiff > 0)
    {
        CGRect frame     = titleLabel.frame;
        frame.origin.x   = widthDiff / 2;
        titleLabel.frame = CGRectIntegral(frame);
    }
    else
    {
        CGRect frame        = subTitleLabel.frame;
        frame.origin.x      = fabsf(widthDiff) / 2;
        subTitleLabel.frame = CGRectIntegral(frame);
    }
    
    self.navigationItem.titleView = twoLineTitleView;
    
    return twoLineTitleView;
}

#pragma mark - UITableViewDataSource, UITabBarDelegate -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfflineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OfflineSyncCellID" forIndexPath:indexPath];
    return cell;
}

@end
