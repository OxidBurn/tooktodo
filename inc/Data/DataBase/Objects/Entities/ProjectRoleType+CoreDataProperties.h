//
//  ProjectRoleType+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/19/16.
//
//

#import "ProjectRoleType+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectRoleType (CoreDataProperties)

+ (NSFetchRequest<ProjectRoleType *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *roleTypeID;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) ProjectRoleAssignments *roleAssignment;
@property (nullable, nonatomic, retain) ProjectInviteInfo *projectInvite;

@end

NS_ASSUME_NONNULL_END
