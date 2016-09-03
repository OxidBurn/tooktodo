//
//  WelcomeTourModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SAInfiniteScrollView/PowerfulBannerView.h>


typedef UIView*(^ConfigurationBlock)(PowerfulBannerView* banner, NSString* imageName, UIView* reusableView);

@interface WelcomeTourModel : NSObject

//methods
- (NSArray*) returnPagesContent;

- (ConfigurationBlock) configurateContent;

@end
