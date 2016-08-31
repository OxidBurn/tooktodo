//
//  InformationViewModel.m
//  TookTODO
//
//  Created by Lera on 31.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "InformationViewModel.h"
#import "AppDelegate.h"
#import "DataManager+ProjectInfo.h"


@interface InformationViewModel()

@property (nonatomic, strong) ProjectInfo* projectInfo;
@property (nonatomic, strong) NSArray* textLabelsArray;

@end

@implementation InformationViewModel

#pragma mark - Properties -


- (NSArray*) textLabelsArray
{
    if (_textLabelsArray == nil)
    {
        _textLabelsArray = [NSArray arrayWithObjects: @"", @"Класс недвижимости", @"Тип объекта", @"Страна", @"Регион", @"Город / населенный пункт", @"Улица", @"Дом", @"Корпус / строение", @"Этаж", @"Квартира", @"Комментарий", nil];
    }
    return _textLabelsArray;
}

#pragma mark - Table view datasource methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 2;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    NSString* cellID = @"InformationCellID";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellID
                                                            forIndexPath: indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue2
                                      reuseIdentifier: cellID];
    }
    
    NSMutableArray* projectInfoArray = [NSMutableArray array];
    
    ProjectInfo* projectInfo = [ProjectInfo MR_findFirst];
    
    [projectInfoArray addObject: projectInfo.commercialObjectType];
    [projectInfoArray addObject: projectInfo.commercialObjectTypeDescription];
    [projectInfoArray addObject: projectInfo.country];
    [projectInfoArray addObject: projectInfo.region];
    [projectInfoArray addObject: projectInfo.city];
    [projectInfoArray addObject: projectInfo.street];
    [projectInfoArray addObject: projectInfo.building];
    [projectInfoArray addObject: projectInfo.floor];
    [projectInfoArray addObject: projectInfo.apartment];
    
    NSString* fillInfo  = projectInfoArray[indexPath.row];
    NSString* textLabel = self.textLabelsArray[indexPath.row];
    
//    if (indexPath.row == 0)
//    {
//        cell.textLabel.text = self.projectInfo.title;
//    }
    
    cell.textLabel.text = textLabel;
    cell.detailTextLabel.text = fillInfo;
    
    return cell;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger) section
{
    return 5;
}



//- (void) fillContent: (ProjectInfo*) info
//{
//    self.projectTitle.text  = info.title;
//    self.projectDetail.text = [NSString stringWithFormat: @"%@ %@ %@", (info.street) ? info.street : @"", (info.building) ? info.building : @"", (info.apartment) ? info.apartment : @""];
//
//    self.projectID = info.projectID;
//}
@end
