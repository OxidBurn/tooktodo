//
//  SystemsInfoViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SystemsInfoViewModel.h"

// Classes
#import "SystemsInfoModel.h"
#import "ProjectSystem+CoreDataClass.h"

@interface SystemsInfoViewModel()

// properties

@property (strong, nonatomic) SystemsInfoModel* model;

// methods


@end

@implementation SystemsInfoViewModel


#pragma mark - Propeties -

- (SystemsInfoModel*) model
{
    if ( _model == nil )
    {
        _model = [[SystemsInfoModel alloc] init];
    }
    
    return _model;
}


#pragma mark - Public methods -

- (RACSignal*) updateInfo
{
    return [self.model updateInfo];
}


#pragma mark - Table view data source methods -

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model countOfSystemItems];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"SystemsCellID"];
    
    cell.textLabel.attributedText = [self.model getTitleForCellAtIndex: indexPath.row];
    
    return cell;
}



@end
