//
//  CollectionCell.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CollectionCell.h"

@interface CollectionCell()

// outlets
@property (weak, nonatomic) IBOutlet UICollectionView *colletionView;

// properties


// methods


@end

@implementation CollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
