//
//  AboutProjectModel.m
//  TookTODO
//
//  Created by Глеб on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AboutProjectModel.h"

// Classes
#import "DataManager+ProjectInfo.h"
#import "Macroses.h"

@interface AboutProjectModel()

// properties
@property (nonatomic, strong) ProjectInfo * projectInfo;

@property (nonatomic, strong) NSArray     * sectionTitlesArray;

@property (nonatomic, strong) NSArray     * sectionDetailArray;

// methods


@end

@implementation AboutProjectModel

#pragma mark - Properties -

- (ProjectInfo*) projectInfo
{
    if ( _projectInfo == nil )
    {
        _projectInfo = [DataManagerShared getSelectedProjectInfo];
    }
    
    return _projectInfo;
}

- (void) updateProjectInfo
{
    ProjectInfo* projectInfo =  [DataManagerShared getSelectedProjectInfo];
    
    self.projectInfo = projectInfo;
    
    self.sectionDetailArray = [self createSectionDetailContent];
}

- (NSArray*) sectionDetailArray
{
    if (_sectionDetailArray == nil)
    {
        _sectionDetailArray = [self createSectionDetailContent];
    }
    
    return _sectionDetailArray;
}


- (NSArray*) sectionTitlesArray
{
    if (_sectionTitlesArray == nil)
    {
        NSArray* titlesArray = [NSArray new];
        
        if ( IS_PHONE )
        {
            titlesArray = @[@[self.projectInfo.title ? self.projectInfo.title : @"NO TITLE",
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
        else
        {
            titlesArray = @[@[self.projectInfo.title ? self.projectInfo.title : @"NO TITLE",
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
                              @"Комментарий"],
                            @[@"Проект на карте"]];
        }
        _sectionTitlesArray = titlesArray;
    }
    
    return _sectionTitlesArray;
}

#pragma mark - Public -

- (NSUInteger) getNumberOfSections
{
    return self.sectionTitlesArray.count;
}

- (NSUInteger) getNumberOfRowsForSection: (NSUInteger) section
{
    return [self.sectionTitlesArray[section] count];
}

- (NSString*) getCellTitleForIndexPath: (NSIndexPath*) indexPath
{
    return self.sectionTitlesArray[indexPath.section][indexPath.row];
}

- (NSString*) getCellDetailForIndexPath: (NSIndexPath*) indexPath
{
    return self.sectionDetailArray[indexPath.section][indexPath.row];
}

#pragma mark - Helpers -

- (NSArray*) createSectionDetailContent
{
    NSArray* content = [NSArray new];
    
    if ( IS_PHONE )
        content = [self createSectionDetailContentForiPhone];
    else
        content = [self createSectionDetailContentForiPad];
    
    return content;
}

- (NSArray*) createSectionDetailContentForiPhone
{
    ProjectInfo* projectInfo = self.projectInfo;
    
    NSArray* content = @[
                         @[@"",
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
    return content;
}

- (NSArray*) createSectionDetailContentForiPad
{
    ProjectInfo* projectInfo = self.projectInfo;
    
    NSArray* content = @[
                         @[@"",
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
                           @"нет"],
                         @[@"координаты"]];
    return content;
}

@end
