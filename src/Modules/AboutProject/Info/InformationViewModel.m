//
//  InformationViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 02.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "InformationViewModel.h"
#import "DataManager+ProjectInfo.h"


@interface InformationViewModel()

@property (nonatomic, strong) ProjectInfo * projectInfo;
@property (nonatomic, strong) NSArray     * sectionContentArray;
@property (nonatomic, strong) NSArray     * itemInfo;

@end

@implementation InformationViewModel

#pragma mark - Properties -

- (void) updateProjectInfo
{
    ProjectInfo* projectInfo =  [DataManagerShared getSelectedProjectInfo];
    
    self.itemInfo = @[
                  @[projectInfo.title        ? projectInfo.title : @"NO TITLE",
                    projectInfo.commercialObjectTypeDescription ? projectInfo.commercialObjectTypeDescription : @"нет",
                    @"нет"],
                  @[@"нет",
                    projectInfo.regionName   ? projectInfo.regionName : @"нет",
                    projectInfo.city         ? projectInfo.city : @"нет",
                    projectInfo.street       ? projectInfo.street : @"нет",
                    projectInfo.building     ? projectInfo.building : @"нет",
                    projectInfo.residentialObjectTypeDescription ? projectInfo.residentialObjectTypeDescription : @"нет",
                    projectInfo.floor        ? projectInfo.floor.stringValue : @"нет",
                    projectInfo.apartment    ? projectInfo.apartment : @"нет",
                    @"нет"]];
}

- (NSArray*) itemInfo
{
    if (_itemInfo == nil)
    {
        ProjectInfo* projectInfo =  [DataManagerShared getSelectedProjectInfo];
        
        _itemInfo = @[
                      @[projectInfo.title        ? projectInfo.title : @"NO TITLE",
                        projectInfo.commercialObjectTypeDescription ? projectInfo.commercialObjectTypeDescription : @"нет",
                        @"нет"],
                      @[@"нет",
                        projectInfo.regionName   ? projectInfo.regionName : @"нет",
                        projectInfo.city         ? projectInfo.city : @"нет",
                        projectInfo.street       ? projectInfo.street : @"нет",
                        projectInfo.building     ? projectInfo.building : @"нет",
                        projectInfo.residentialObjectTypeDescription ? projectInfo.residentialObjectTypeDescription : @"нет",
                        projectInfo.floor        ? projectInfo.floor.stringValue : @"нет",
                        projectInfo.apartment    ? projectInfo.apartment : @"нет",
                        @"нет"]];
        
    }
    
    return _itemInfo;
}


- (NSArray*) sectionContentArray
{
    if (_sectionContentArray == nil)
    {
        _sectionContentArray = @[@[@"",
                                   @"Класс недвижимости",
                                   @"Тип объекта"],
                                 @[@"Страна",
                                   @"Регион",
                                   @"Город / населенный пункт",
                                   @"Улица",
                                   @"Дом",
                                   @"Корпус / строение",
                                   @"Этаж",
                                   @"Квартира",
                                   @"Комментарий"]];
    }
    
    return _sectionContentArray;
}


#pragma mark - Table view datasource methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 2;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.itemInfo[section] count];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    NSString* cellID      = @"InformationCellID";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellID
                                                            forIndexPath: indexPath];
    
    UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: 15.0f];
    UIFont* detailFont = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: 13.0f];
    
    
    cell.detailTextLabel.font = detailFont;
    cell.textLabel.font       = customFont;
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        
        cell.textLabel.text       = self.itemInfo[0][0];
        cell.detailTextLabel.text = @"";
    }
    else
    {
        NSString* fillInfo  = self.itemInfo[indexPath.section][indexPath.row];
        NSString* textLabel = self.sectionContentArray[indexPath.section][indexPath.row];
        
        cell.textLabel.text            = textLabel;
        cell.detailTextLabel.text      = fillInfo;
        cell.detailTextLabel.textColor = [UIColor blackColor];
        
        if ([fillInfo isEqualToString: @"нет"])
        {
            cell.detailTextLabel.textColor = [UIColor grayColor];
        }
        
    }
    
    return cell;
}


#pragma mark - TableView Delegate methods -

- (CGFloat)             tableView: (UITableView*) tableView
estimatedHeightForHeaderInSection: (NSInteger)    section
{
    if (section == 0)
    {
        return 0;
    }
    else
    {
        return 1.f;
    }
}


@end
