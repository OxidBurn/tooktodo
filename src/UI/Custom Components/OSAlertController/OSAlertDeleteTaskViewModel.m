//
//  OSAlertDeleteTaskViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertDeleteTaskWithSubtasksViewModel.h"
#import "DataManager+Tasks.h"

typedef NS_ENUM(NSUInteger, DeleteTaskTableCellsType)
{
    DeleteTaskTitleCellType,
    DeleteTaskDeleteSubtasksCellType,
    DeleteTaskSaveSubTasksCellType,
    DeleteTaskCancelCellType,
};

@import UIKit;

@interface OSAlertDeleteTaskWithSubtasksViewModel()

@property (nonatomic, strong) NSArray* titlesArray;

@end

@implementation OSAlertDeleteTaskWithSubtasksViewModel


#pragma mark - Properties -

- (NSArray*) titlesArray
{
    if (_titlesArray == nil)
    {
        _titlesArray = @[@"Задача содержит подзадачи",
                         @"Удалить с подзадачами",
                         @"Сохранить подзадачи",
                         @"Отмена"];
    }
    
    return _titlesArray;
}

#pragma mark - TableView DataSource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    
    NSString* identifier = @"CellID";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: identifier
                                                            forIndexPath: indexPath];

    cell.textLabel.text          = self.titlesArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (indexPath.row == 0)
    {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.text = [NSString stringWithFormat: @"Задача \"%@ \" содержит подзадачи", [[DataManagerShared getSelectedTask] title]];
        cell.textLabel.numberOfLines = 2;
    }
    
    else if (indexPath.row == 1)
    {
        cell.textLabel.textColor = [UIColor colorWithRed: 1
                                                   green: 0.274f
                                                    blue: 0.274f
                                                   alpha: 1.f];
    }
    
    else
    {
        cell.textLabel.textColor = [UIColor colorWithRed: 0.223f
                                                   green: 0.741f
                                                    blue: 0.717f
                                                   alpha: 1.f];
    }
    return cell;
}

-(NSInteger) tableView: (UITableView*) tableView
 numberOfRowsInSection: (NSInteger)    section
{
    return self.titlesArray.count;
}


#pragma mark - TableView delegate methods -

- (CGFloat)      tableView: (UITableView*) tableView
   heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    if (indexPath.row == 0)
    {
        return 64.f;
    }
    else
        return 43.f;
}

- (void)        tableView: (UITableView*) tableView
  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath: indexPath];
    
    switch (indexPath.row)
    {
        case DeleteTaskTitleCellType:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            break;
        case DeleteTaskDeleteSubtasksCellType:
        {
            if ( self.deleteTaskWithSubtasks )
                self.deleteTaskWithSubtasks(YES);
        }
            break;
        case DeleteTaskSaveSubTasksCellType:
        {
            if ( self.deleteTaskWithSubtasks )
                self.deleteTaskWithSubtasks(NO);
        }
            break;
        case DeleteTaskCancelCellType:
        {
            
        }
            break;
        default:
            break;
    }
    
    if ( self.dismissAlert )
        self.dismissAlert();
}

- (void) tableView: (UITableView*) tableView
   willDisplayCell: (UITableViewCell*) cell
 forRowAtIndexPath: (NSIndexPath*) indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector: @selector(setSeparatorInset:)]) {
        [cell setSeparatorInset: UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector: @selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins: NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector: @selector(setLayoutMargins:)]) {
        [cell setLayoutMargins: UIEdgeInsetsZero];
    }
}

@end
