//
//  CollectionCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CollectionCell.h"

// Classes
#import "CollectionCellViewModel.h"

@interface CollectionCell()

// outlets
@property (weak, nonatomic) IBOutlet UICollectionView* colletionView;

// properties
@property (strong, nonatomic) CollectionCellViewModel* viewModel;

// methods


@end

@implementation CollectionCell

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    self.colletionView.dataSource = self.viewModel;
    self.colletionView.delegate   = self.viewModel;
}

#pragma mark - Properties -

- (CollectionCellViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [CollectionCellViewModel new];
    }
    
    return _viewModel;
}

#pragma mark - Public -


@end
