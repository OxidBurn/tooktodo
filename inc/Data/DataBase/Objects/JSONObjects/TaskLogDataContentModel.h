//
//  TaskLogDataContentModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskLogDataContentModel : JSONModel

@property (nonatomic, strong) NSNumber<Optional>* commentId;
@property (nonatomic, strong) NSDate<Optional>* oldStartDate;
@property (nonatomic, strong) NSDate<Optional>* oldEndDate;
@property (nonatomic, strong) NSDate<Optional>* startDateNew;
@property (nonatomic, strong) NSDate<Optional>* endDateNew;
@property (nonatomic, strong) NSNumber<Optional>* oldStatus;
@property (nonatomic, strong) NSNumber<Optional>* statusNew;
@property (nonatomic, strong) NSArray<Optional>* fileTitles;
@property (nonatomic, strong) NSArray<Optional>* fileTitlesWithExtensions;
@property (nonatomic, strong) NSArray<Optional>* storageFiles;
@property (nonatomic, strong) NSNumber<Optional>* oldValue;
@property (nonatomic, strong) NSNumber<Optional>* valueNew;
@property (nonatomic, strong) NSNumber<Optional>* userId;
@property (nonatomic, strong) NSNumber<Optional>* projectRoleAssignmentId;
@property (nonatomic, strong) NSNumber<Optional>* taskRoleType;
@property (nonatomic, strong) NSString<Optional>* oldDescription;
@property (nonatomic, strong) NSString<Optional>* descriptionNew;
@property (nonatomic, strong) NSNumber<Optional>* oldWorkArea;
@property (nonatomic, strong) NSNumber<Optional>* WorkAreaNew;
@property (strong, nonatomic) NSString<Optional>* oldTitle;
@property (strong, nonatomic) NSString<Optional>* titleNew;
@property (strong, nonatomic) NSNumber<Optional>* oldStageId;
@property (strong, nonatomic) NSNumber<Optional>* stageIdNew;
@property (strong, nonatomic) NSNumber<Optional>* oldRoomId;
@property (strong, nonatomic) NSNumber<Optional>* roomIdNew;
@property (strong, nonatomic) NSNumber<Optional>* isAllRoomsNew;
@property (strong, nonatomic) NSNumber<Optional>* oldIsAllRooms;


@end
