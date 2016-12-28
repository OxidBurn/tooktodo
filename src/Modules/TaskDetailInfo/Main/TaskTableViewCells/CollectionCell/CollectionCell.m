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


#pragma mark - Initialization -

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    self.colletionView.dataSource = self.viewModel;
    self.colletionView.delegate   = self.viewModel;
    
    [DefaultNotifyCenter addObserver: self
                            selector: @selector(realoadContent)
                                name: @"UpdateCellContent"
                              object: nil];
}

#pragma mark - Memory managment -

- (void) dealloc
{
    [DefaultNotifyCenter removeObserver: self
                                   name: @"UpdateCellContent"
                                 object: nil];
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

- (void) fillParentCollectionCellDelegate: (id<ParentCollectionCellDelegate>) delegate;
{
    [self.viewModel fillParentCollectionCellDelegate: delegate];
}


#pragma mark - Internal methods -

- (void) realoadContent
{
    [self.colletionView reloadData];
}

@end
