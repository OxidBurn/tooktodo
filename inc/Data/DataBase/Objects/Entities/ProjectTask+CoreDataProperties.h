//
//  ProjectTask+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 10/5/16.
//
//

#import "ProjectTask+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTask (CoreDataProperties)

+ (NSFetchRequest<ProjectTask *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *access; // скрытая
@property (nullable, nonatomic, copy) NSNumber *attachments; // прикрепленные файлы
@property (nullable, nonatomic, copy) NSDate *closedDate; // фактическая дата последняя
@property (nullable, nonatomic, copy) NSString *descriptionValue; // описание ячейка 2
@property (nullable, nonatomic, copy) NSNumber *duration; //
@property (nullable, nonatomic, copy) NSDate *endDate; // заявленый конец задания
@property (nullable, nonatomic, copy) NSNumber *extraId; // 
@property (nullable, nonatomic, copy) NSNumber *isAllRooms; //
@property (nullable, nonatomic, copy) NSNumber *isExpired; // просроченая
@property (nullable, nonatomic, copy) NSNumber *isIncludedRestDays; // включая выходные
@property (nullable, nonatomic, copy) NSNumber *isTaskStatusChanged; //
@property (nullable, nonatomic, copy) NSNumber *isUrgent; // срочная
@property (nullable, nonatomic, copy) NSString *mapPreviewImage; // возможно план
@property (nullable, nonatomic, copy) NSNumber *ownerUserId; // ай ди создателя
@property (nullable, nonatomic, copy) NSNumber *parentTaskId; //
@property (nullable, nonatomic, copy) NSNumber *projectId;
@property (nullable, nonatomic, copy) NSNumber *projectRelatedId; // к какому проекту относится
@property (nullable, nonatomic, copy) NSDate *startDay; // заявленый старт задачи
@property (nullable, nonatomic, copy) NSNumber *status; // енам для цветов кнопки
@property (nullable, nonatomic, copy) NSString *statusDescription; // инфо в кнопке пример "в работе"
@property (nullable, nonatomic, copy) NSString *storageDirectoryId;
@property (nullable, nonatomic, copy) NSNumber *storageFilesCount;
@property (nullable, nonatomic, copy) NSNumber *taskAccess; // скрытыя/нет задача (сетится глазом)
@property (nullable, nonatomic, copy) NSString *taskDescription;
@property (nullable, nonatomic, copy) NSNumber *taskID;
@property (nullable, nonatomic, copy) NSNumber *taskType; // числовое значение для цвета кружка, примера "согласование" от нуля до 3
@property (nullable, nonatomic, copy) NSString *taskTypeDescription; // пример "согласование"
@property (nullable, nonatomic, copy) NSString *title; // название задачи
@property (nullable, nonatomic, copy) NSNumber *isSelected;
@property (nullable, nonatomic, retain) ProjectTaskMarker *marker;
@property (nullable, nonatomic, retain) ProjectTaskOwner *ownerUser;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) ProjectTaskResponsible *responsible; // ответственный
@property (nullable, nonatomic, retain) ProjectTaskRoom *room; 
@property (nullable, nonatomic, retain) ProjectTaskRoomLevel *roomLevel; 
@property (nullable, nonatomic, retain) NSSet<ProjectTaskRoom *> *rooms; // номер комнаты сетится в лейбу
@property (nullable, nonatomic, retain) ProjectTaskStage *stage; // этап
@property (nullable, nonatomic, retain) NSSet<ProjectTaskSubTasks *> *subTasks; // подзадачи
@property (nullable, nonatomic, retain) NSSet<ProjectTaskRoleAssignments *> *taskRoleAssignments; // все, кто учавствует в задачи
@property (nullable, nonatomic, retain) ProjectTaskWorkArea *workArea; // пример "отопление" "ОВКСМ"

@end

@interface ProjectTask (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(ProjectTaskRoom *)value;
- (void)removeRoomsObject:(ProjectTaskRoom *)value;
- (void)addRooms:(NSSet<ProjectTaskRoom *> *)values;
- (void)removeRooms:(NSSet<ProjectTaskRoom *> *)values;

- (void)addSubTasksObject:(ProjectTaskSubTasks *)value;
- (void)removeSubTasksObject:(ProjectTaskSubTasks *)value;
- (void)addSubTasks:(NSSet<ProjectTaskSubTasks *> *)values;
- (void)removeSubTasks:(NSSet<ProjectTaskSubTasks *> *)values;

- (void)addTaskRoleAssignmentsObject:(ProjectTaskRoleAssignments *)value;
- (void)removeTaskRoleAssignmentsObject:(ProjectTaskRoleAssignments *)value;
- (void)addTaskRoleAssignments:(NSSet<ProjectTaskRoleAssignments *> *)values;
- (void)removeTaskRoleAssignments:(NSSet<ProjectTaskRoleAssignments *> *)values;

@end

NS_ASSUME_NONNULL_END
