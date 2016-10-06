//
//  TermsInfoCollectionCell.h
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "TaskCollectionCellsContent.h"

@interface TermsInfoCollectionCell : UICollectionViewCell

// methods
- (void) fillCellWithContent: (TaskCollectionCellsContent*) content;

@end
