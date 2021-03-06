//
//  OSAlertPlanNotLoadedModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OSAlertPlanNotLoadedViewModelDelegate;

@interface OSAlertPlanNotLoadedViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <OSAlertPlanNotLoadedViewModelDelegate> delegate;

@end

@protocol OSAlertPlanNotLoadedViewModelDelegate <NSObject>

- (void) performActionForIndexPath: (NSIndexPath*) indexPath;

@end



