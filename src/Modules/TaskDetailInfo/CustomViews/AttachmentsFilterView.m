//
//  AttachmentsFilterView.m
//  TookTODO
//
//  Created by Глеб on 10.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AttachmentsFilterView.h"

@interface AttachmentsFilterView()

// outlets
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;

@property (weak, nonatomic) IBOutlet UIButton*    addBtn;

// properties

// methods
- (IBAction)onAddBtn:(UIButton *)sender;

@end

@implementation AttachmentsFilterView

#pragma mark - Actions -

- (IBAction) onAddBtn: (UIButton*) sender
{
    
}

@end
