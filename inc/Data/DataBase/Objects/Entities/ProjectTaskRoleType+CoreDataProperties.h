//
//  ProjectTaskRoleType+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTaskRoleType.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoleType (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *roleTypeID;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) ProjectTaskResponsible *responsible;
@property (nullable, nonatomic, retain) ProjectTaskRoleAssignment *roleAssignment;

@end

NS_ASSUME_NONNULL_END
