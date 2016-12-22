//
//  CollectionCellViewModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "ParentCollectionCell.h"

@interface CollectionCellViewModel : NSObject <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (void) fillParentCollectionCellDelegate: (id<ParentCollectionCellDelegate>) delegate;

@end




