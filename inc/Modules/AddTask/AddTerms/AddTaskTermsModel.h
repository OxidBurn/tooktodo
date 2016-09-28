//
//  AddTaskTermsModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddTaskTermsModelDelegate;

@interface AddTaskTermsModel : NSObject

// properties
@property (weak, nonatomic) id <AddTaskTermsModelDelegate> delegate;

// methods
- (NSUInteger) getNumberOfRows;

- (UITableViewCell*) returnCellForTableView: (UITableView*) tableView
                              withIndexPath: (NSIndexPath*) indexPath;
@end

@protocol AddTaskTermsModelDelegate <NSObject>

- (void) reloadTermsTableView;

@end
