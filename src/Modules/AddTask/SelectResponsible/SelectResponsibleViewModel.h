//
//  SelectResponsibleViewModel.h
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface SelectResponsibleViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties
@property (nonatomic, copy) void(^reloadTableView)();

// methods
- (void) updateInfoWithCompletion: (CompletionWithSuccess) completion;

@end
