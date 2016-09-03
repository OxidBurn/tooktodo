//
//  ProjectInfo+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/4/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *apartment;
@property (nullable, nonatomic, retain) NSString *building;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSNumber *commercialObjectType;
@property (nullable, nonatomic, retain) NSString *commercialObjectTypeDescription;
@property (nullable, nonatomic, retain) NSDate *createdDate;
@property (nullable, nonatomic, retain) NSDate *endDate;
@property (nullable, nonatomic, retain) NSNumber *floor;
@property (nullable, nonatomic, retain) NSNumber *isRolesInvitationAppealClosed;
@property (nullable, nonatomic, retain) NSNumber *isSelected;
@property (nullable, nonatomic, retain) NSNumber *isTaskAddAppealClosed;
@property (nullable, nonatomic, retain) NSDate *lastVisit;
@property (nullable, nonatomic, retain) NSNumber *ownerUserId;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSNumber *projectID;
@property (nullable, nonatomic, retain) NSNumber *realtyClass;
@property (nullable, nonatomic, retain) NSString *realtyClassDescription;
@property (nullable, nonatomic, retain) NSString *regionName;
@property (nullable, nonatomic, retain) NSNumber *residentialObjectType;
@property (nullable, nonatomic, retain) NSString *residentialObjectTypeDescription;
@property (nullable, nonatomic, retain) NSString *street;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) ProjectCountry *country;
@property (nullable, nonatomic, retain) NSSet<OfflineSettings *> *offlineSettings;
@property (nullable, nonatomic, retain) ProjectRegion *region;
@property (nullable, nonatomic, retain) NSSet<TeamMember *> *team;
@property (nullable, nonatomic, retain) NSSet<ProjectRoles *> *roles;

@end

@interface ProjectInfo (CoreDataGeneratedAccessors)

- (void)addOfflineSettingsObject:(OfflineSettings *)value;
- (void)removeOfflineSettingsObject:(OfflineSettings *)value;
- (void)addOfflineSettings:(NSSet<OfflineSettings *> *)values;
- (void)removeOfflineSettings:(NSSet<OfflineSettings *> *)values;

- (void)addTeamObject:(TeamMember *)value;
- (void)removeTeamObject:(TeamMember *)value;
- (void)addTeam:(NSSet<TeamMember *> *)values;
- (void)removeTeam:(NSSet<TeamMember *> *)values;

- (void)addRolesObject:(ProjectRoles *)value;
- (void)removeRolesObject:(ProjectRoles *)value;
- (void)addRoles:(NSSet<ProjectRoles *> *)values;
- (void)removeRoles:(NSSet<ProjectRoles *> *)values;

@end

NS_ASSUME_NONNULL_END
