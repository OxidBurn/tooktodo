//
//  ProjectTaskResponsible+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTaskResponsible.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskResponsible (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *responsibleID;
@property (nullable, nonatomic, retain) NSNumber *invite;
@property (nullable, nonatomic, retain) NSNumber *isBlocked;
@property (nullable, nonatomic, retain) NSNumber *projectPermission;
@property (nullable, nonatomic, retain) NSManagedObject *assignee;
@property (nullable, nonatomic, retain) NSManagedObject *projectRoleType;
@property (nullable, nonatomic, retain) NSManagedObject *task;

@end

NS_ASSUME_NONNULL_END
