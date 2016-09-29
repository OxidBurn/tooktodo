//
//  OSAlertDeleteTaskViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertDeleteTaskViewModel.h"

@import UIKit;

@interface OSAlertDeleteTaskViewModel()

@property (nonatomic, strong) NSArray* titlesArray;

@end

@implementation OSAlertDeleteTaskViewModel


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
    
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
//                                      reuseIdentifier: identifier];
//    }
    
//    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Regular"
//                                                    size: 17.0f];
//    
    cell.textLabel.text = self.titlesArray[indexPath.row];
   // cell.textLabel.font = customFont;
    
    if (indexPath.row == 0)
    {
        cell.textLabel.textColor = [UIColor blackColor];
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
    
    if (indexPath.row == 0)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //    if (indexPath.row == 1)
    //    {
    //        //делегатом обработать нажатие на ячейку
    //        if ([self.delegate performSelector:@selector(showControllerWithIdentifier:)])
    //        {
    //            //[self.delegate showControllerWithIdentifier: @"ShowImgAlert"];
    //        }
    //    }
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
