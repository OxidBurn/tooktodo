//
//  FilterByTypesVievModel.h
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TaskFilterConfiguration.h"

@interface FilterByTypesViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) void(^reloadTableView)();

- (NSArray*) getSelectedTypesArray;

- (void) fillSelectedTypesInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

- (void) selectAll;

- (void) deselectAll;

@end
