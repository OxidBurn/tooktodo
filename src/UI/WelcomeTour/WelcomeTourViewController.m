//
//  WelcomeTourViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "WelcomeTourViewController.h"
#import <SAInfiniteScrollView/PowerfulBannerView.h>
#import "WelcomeTourModel.h"

@interface WelcomeTourViewController ()

//properties
@property (weak, nonatomic) IBOutlet UIPageControl* pageIndicatorView;

@property (weak, nonatomic) IBOutlet PowerfulBannerView* imageContentView;

@property (strong, nonatomic) WelcomeTourModel* model;

//actions
- (IBAction) onStartWork: (UIButton*) sender;

@end

@implementation WelcomeTourViewController

#pragma mark - Lyfe cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageContentView.bannerItemConfigurationBlock = [self.model configurateContent];
    
    
    self.imageContentView.items = [self.model returnPagesContent];
    
    self.imageContentView.pageControl = self.pageIndicatorView;
    
    self.imageContentView.infiniteLooping = YES;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties -

- (WelcomeTourModel *)model
{
    if ( _model == nil )
    {
        _model = [WelcomeTourModel new];
    }
    
    return _model;
}

#pragma mark - Actions -

- (IBAction) onStartWork: (UIButton*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

@end
