//
//  DataManager.m
//  CoreData
//
//  Created by mbp on 20/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "DataManager.h"

@interface DataManager ()

@end

@implementation DataManager

+ (id) sharedManager {
    static dispatch_once_t pred = 0;
    static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(NSArray*) getAllCourses {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Course"
                                                   inManagedObjectContext:context];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* allCourses = [context executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    for (Course* course in allCourses) {
        NSLog(@"%@ %ld student %ld",  course.name, [allCourses count], [course.students count]);
    }
    return allCourses;
}

-(NSArray*) getAllStudents {
    
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Student"
                                                   inManagedObjectContext:context];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* studentsArray = [context executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    NSLog(@"%@", studentsArray);
    for (Student*  student in studentsArray) {
        NSLog(@"%@ %@ - %@",  student.name, student.surname, student.number );
    }
    return studentsArray;
}

-(NSArray*) getCourses{
    
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Course"
                                                   inManagedObjectContext:context];
    
    [request setEntity:description];
    
    
    NSError* requestError = nil;
    NSArray* cursesArray = [context executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    NSLog(@"%@", cursesArray);
    for (Course* course in cursesArray) {
        NSLog(@"%@ - %ld", course.name, [course.students count] );
    }
    return cursesArray;
}

-(NSArray*) getStudents{
    
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Student"
                                                   inManagedObjectContext:context];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* studentArray = [context executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    NSLog(@"%@", studentArray);
    for (Student*  student in studentArray) {
        NSLog(@"%@ %@ - %@ ",  student.name, student.surname, student.number);
    }
    return studentArray;
}

-(void) addCourses:(NSString*) name and:(NSString*) lesson and:(NSString*) teacher andStudents:(NSSet*)students {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    Course* newCourse = [[Course alloc] initWithContext:context];
    newCourse.name = name;
    newCourse.lesson = lesson;
    newCourse.teacher = teacher;
    newCourse.students = students;

    NSError *error = nil;
    
    BOOL isSuccess =  [context save:&error];
    
    if (!isSuccess) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

-(void) addNewStudent:(NSString*) name and: (NSString*) surname and:(NSString*) number andCourses:(NSSet* )courses {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    Student* student = [[Student alloc] initWithContext:context];
    student.name = name;
    student.surname = surname;
    student.number = number;
    student.courses = courses;
    
    NSError *error = nil;

    BOOL isSuccess =  [context save:&error];
    
    if (!isSuccess) {
        
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

-(void) editStudent:(Student*) student {
    [student.managedObjectContext save:nil];
    [self saveContext];
}

-(void) editCourses:(Course*) courses {
    [courses.managedObjectContext save:nil];
    [self saveContext];
}

-(void) deleteAllStudents {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    [context executeRequest:delete error:&deleteError];
    
}

-(void) deleteAllCourses {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Course"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    [context executeRequest:delete error:&deleteError];
    
}

-(void) deleteStudent:(Student*) student{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;

    [context deleteObject:student];
    [context save:nil];
}


-(void) deleteCourses:(Course*) curses{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    [context deleteObject:curses];
    [context save:nil];
}

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreData"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
    }
}
@end
