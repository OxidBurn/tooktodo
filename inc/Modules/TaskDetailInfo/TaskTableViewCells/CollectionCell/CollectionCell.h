//
//  CollectionCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ParentCollectionCell.h"

@interface CollectionCell : UITableViewCell

@property (nonatomic, strong) id<ParentCollectionCellDelegate> varToStoreTaskDetailViewModel;

- (void) fillParentCollectionCellDelegate: (id<ParentCollectionCellDelegate>) delegate;

@end

