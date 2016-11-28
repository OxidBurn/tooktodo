//
//  ParentCollectionCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ParentCollectionCellDelegate;

@interface ParentCollectionCell : UICollectionViewCell

// properties
@property (nonatomic, weak) id <ParentCollectionCellDelegate> delegate;

@end

@protocol ParentCollectionCellDelegate <NSObject>

- (void) performSegueToUsersListWithSegueID: (NSString*) segueID;

@end


