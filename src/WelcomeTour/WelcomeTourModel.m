//
//  WelcomeTourModel.m
//  TookTODO
//
//  Created by Глеб on 10.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "WelcomeTourModel.h"

@interface WelcomeTourModel()

// properties
@property (strong, nonatomic) NSArray* pagesContent;

// methods


@end

@implementation WelcomeTourModel

#pragma mark - Properties -

- (NSArray *)pagesContent
{
    if ( _pagesContent == nil )
    {
        _pagesContent = @[@"WelcomeScreen1",
                          @"WelcomeScreen2",
                          @"WelcomeScreen3",
                          @"WelcomeScreen4",
                          @"WelcomeScreen5",
                          @"WelcomeScreen6"];
    }
    return _pagesContent;
}

#pragma mark - Public -

- (NSArray*) returnPagesContent;
{
    return self.pagesContent;
}

- (ConfigurationBlock)configurateContent
{
    return ^UIView* (PowerfulBannerView* banner, id item, UIView* reusableView) {
        
        UIImageView* view = (UIImageView*)reusableView;
        if ( view == nil )
        {
            view = [[UIImageView alloc] initWithFrame: CGRectZero];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.clipsToBounds = YES;
            view.backgroundColor = [UIColor colorWithRed: 0.22f green: 0.7f blue: 0.72 alpha: 1];
        }
        
        view.image = [UIImage imageNamed: item];
        
        return view;
    };
}
@end
