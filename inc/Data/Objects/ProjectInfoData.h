//
//  ProjectInfo.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <JSONModel/JSONModel.h>

// Classes
#import "ProjectCountryData.h"
#import "ProjectRegionData.h"

@interface ProjectInfoData : JSONModel

@property (nonatomic, strong) NSDate* lastVisit;

@property (nonatomic, assign) BOOL isTaskAddAppealClosed;

@property (nonatomic, strong) NSString* realtyClassDescription;

@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) ProjectCountryData* country;

@property (nonatomic, assign) NSUInteger ownerUserId;

@property (nonatomic, strong) ProjectRegionData<Optional>* region;

@property (nonatomic, strong) NSString<Optional>* street;

@property (nonatomic, assign) NSUInteger residentialObjectType;

@property (nonatomic, strong) NSString<Optional>* building;

@property (nonatomic, strong) NSString<Optional>* city;

@property (nonatomic, strong) NSString<Optional>* residentialObjectTypeDescription;

@property (nonatomic, strong) NSString<Optional>* regionName;

@property (nonatomic, strong) id<Ignore> projectRoleAssignments;

@property (nonatomic, strong) id<Optional> info;

@property (nonatomic, strong) NSString<Optional>* apartment;

@property (nonatomic, strong) NSDate<Optional>* endDate;

@property (nonatomic, assign) NSUInteger projectID;

@property (nonatomic, strong) NSDate* createdDate;

@property (nonatomic, assign) BOOL isRolesInvitationAppealClosed;

@property (assign, nonatomic) NSUInteger commercialObjectType;

@property (assign, nonatomic) NSUInteger realtyClass;

@property (strong, nonatomic) NSString<Optional>* phoneNumber;

@property (strong, nonatomic) NSString* commercialObjectTypeDescription;

@property (strong, nonatomic) NSNumber<Optional>* floor;

@end