//
//  OSAlertPlanNotLoadedModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertPlanNotLoadedViewModel.h"

@interface OSAlertPlanNotLoadedViewModel()

@property (nonatomic, strong) NSArray* titlesForPlanArray;

@end

@implementation OSAlertPlanNotLoadedViewModel


#pragma mark - Properties -

-(NSArray*) titlesForPlanArray
{
    if (_titlesForPlanArray == nil)
    {
        _titlesForPlanArray = @[@"План не загружен",
                                @"Перейти на вэб-версию",
                                @"Отмена"];
    }
    
    return _titlesForPlanArray;
}

#pragma mark - TableView DataSource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"
                                                            forIndexPath: indexPath];
    
    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 17.0f];
    
    cell.textLabel.text = self.titlesForPlanArray[indexPath.row];
    cell.textLabel.font = customFont;
    
    if (indexPath.row == 0)
    {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (NSInteger) tableView: (UITableView*) tableView
 numberOfRowsInSection: (NSInteger)    section
{
    return self.titlesForPlanArray.count;
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
    
    if (indexPath.row == 0)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    else
    {
        //делегатом обработать нажатие на ячейку
        if ([self.delegate performSelector:@selector(performActionForIndexPath:)])
        {
            [self.delegate performActionForIndexPath: indexPath];
        }
    }
}

- (void) tableView: (UITableView*) tableView
   willDisplayCell: (UITableViewCell*) cell
 forRowAtIndexPath: (NSIndexPath*) indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
