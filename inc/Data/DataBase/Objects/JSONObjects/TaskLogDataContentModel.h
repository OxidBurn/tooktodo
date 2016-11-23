//
//  TaskLogDataContentModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskLogDataContentModel : JSONModel

@property (nonatomic, assign) NSUInteger commentId;
@property (nonatomic, strong) NSDate<Optional>* oldStartDate;
@property (nonatomic, strong) NSDate<Optional>* oldEndDate;
@property (nonatomic, strong) NSDate<Optional>* startDateNew;
@property (nonatomic, strong) NSDate<Optional>* endDateNew;
@property (nonatomic, strong) NSNumber<Optional>* oldStatus;
@property (nonatomic, strong) NSNumber<Optional>* statusNew;
@property (nonatomic, strong) NSArray<Optional>* fileTitles;
@property (nonatomic, strong) NSArray<Optional>* fileTitlesWithExtensions;
@property (nonatomic, strong) NSArray<Optional>* storageFiles;
@property (nonatomic, assign) BOOL oldValue;
@property (nonatomic, assign) BOOL newValue;
@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) NSNumber<Optional>* projectRoleAssignmentId;
@property (nonatomic, strong) NSNumber<Optional>* taskRoleType;
@property (nonatomic, strong) NSString<Optional>* oldDescription;
@property (nonatomic, strong) NSString<Optional>* descriptionNew;
@property (nonatomic, strong) NSNumber<Optional>* oldWorkArea;
@property (nonatomic, assign) NSUInteger          newWorkArea;

@end
