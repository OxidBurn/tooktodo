//
//  FilterByStatusViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"

@protocol FilterByStatusControllerDelegate;

@interface FilterByStatusViewController : BaseMainViewController

// properties
@property (weak, nonatomic) id <FilterByStatusControllerDelegate> delegate;

// methods
- (void) fillDelegate: (id) deletate;

@end

@protocol FilterByStatusControllerDelegate <NSObject>

- (void) returnSelectedStatusesArray: (NSArray*) selectedStatuses;

@end
