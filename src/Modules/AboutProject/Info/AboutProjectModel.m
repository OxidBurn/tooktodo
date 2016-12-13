//
//  AboutProjectModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AboutProjectModel.h"

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "DataManager+ProjectInfo.h"
#import "Macroses.h"
#import "ProjectsService.h"
#import "Utils.h"

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

- (void) updateProjectInfoWithCompletion: (CompletionWithSuccess) completion
{
    ProjectInfo* projectInfo =  [DataManagerShared getSelectedProjectInfo];
    
    self.projectInfo = projectInfo;
    
    self.sectionDetailArray = [self createSectionDetailContent];
    
    if ( completion )
        completion(YES);
    
    @weakify(self)
    
    [[[ProjectsService sharedInstance] updatedProjectInfo: projectInfo]
     subscribeNext: ^(id x) {
         
         @strongify(self)
         
         self.sectionDetailArray = [self createSectionDetailContent];
         
         if ( completion )
             completion(YES);
         
     }
     error:^(NSError *error) {
         
         NSLog(@"<ERROR> Problem with updating project info %@", error.debugDescription);
         
     }];
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

- (CGFloat) countHeightForCommentCellWithWidth: (CGFloat) width
{
    NSString* comment = self.sectionDetailArray[1][8];
    
    UIFont* font      = [UIFont fontWithName: @"SFUIText-Regular"
                                        size: 13.f];
    
    CGSize size = [Utils findHeightForText: comment
                               havingWidth: width
                                   andFont: font];
    
    CGFloat height = size.height + 22;
    
    if ( height < 43 )
        height = 43;
    
    return height;
}

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
                           projectInfo.info         ? projectInfo.info : @"нет"]];
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
                           projectInfo.info         ? projectInfo.info : @"нет"],
                         @[@"координаты"]];
    return content;
}

@end
