//
//  AppDelegate.m
//  CoreData
//
//  Created by mbp on 18/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "AppDelegate.h"
#import "StudentsListViewController.h"
#import "DataManager.h"
#import "CoursesViewController.h"
#import "TeacherViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor blackColor];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    StudentsListViewController* studentVC = [[StudentsListViewController alloc] init];
    UINavigationController* studentsNC =[[UINavigationController alloc] initWithRootViewController:studentVC];
    UIImage* student = [[UIImage imageNamed:@"students"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    studentsNC.tabBarItem =  [[UITabBarItem alloc]initWithTitle:@"Студенты"
                                                          image:student
                                                  selectedImage:student];

    CoursesViewController* facultyVC = [[CoursesViewController alloc] init];
    
    UINavigationController* coursesNC =[[UINavigationController alloc] initWithRootViewController:facultyVC];
    UIImage* courses =[[UIImage imageNamed:@"courses"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    coursesNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Курсы"
                                                        image:courses
                                                selectedImage:courses];;
    
    TeacherViewController* teacherVC = [[TeacherViewController alloc] init];
    UINavigationController* teachersNC =[[UINavigationController alloc] initWithRootViewController:teacherVC];
    UIImage* teacher = [[UIImage imageNamed:@"teacher"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    teachersNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Преподаватели"
                                                                                   image:teacher
                                                                           selectedImage:teacher];
    
    NSArray* controllers = [NSArray arrayWithObjects:studentsNC, coursesNC, teachersNC, nil];
    tabBarController.viewControllers = controllers;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                             forState:UIControlStateSelected];
    
    [[UITextField appearance] setTintColor:[UIColor blackColor]];
    
    self.window.rootViewController = tabBarController;

    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [DataManager.sharedManager saveContext];
}

@end
