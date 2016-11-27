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

- (NSArray*) getSelectedTypesArray;

- (void) fillSelectedTypesInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

@end
