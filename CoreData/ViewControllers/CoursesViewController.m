//
//  АacultyViewController.m
//  CoreData
//
//  Created by mbp on 30/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//
#import "CoursesViewController.h"
#import "AddCoursesViewController.h"
#import "EditCoursesViewController.h"

@interface CoursesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic) UITableView* tableView;

@end

@implementation CoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.title = @"Курс";
    
    UIBarButtonItem* add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addCourses)];
    
    UIBarButtonItem* delete  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                             target:self
                                                                             action:@selector(deleteAll)];
    self.navigationItem.rightBarButtonItems = @[add, delete];
    
    [self reloadData];
    [self createTableView];
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self reloadData];
}

-(void) createTableView {
    
    CGRect frame = self.view.frame;
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    [tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"Cell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}

-(void) reloadData{
    
    NSArray* allCourses = [DataManager.sharedManager getAllCourses];
    self.coursesArray = [[NSMutableArray alloc] initWithArray:allCourses];
    
    [self.tableView reloadData];
}

-(void) addCourses {
    AddCoursesViewController* controller = [[AddCoursesViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [self reloadData];
}

-(void) deleteAll {
    [DataManager.sharedManager deleteAllCourses];
    [self reloadData];
}

#pragma mark - UITableViewDataSourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.coursesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Course*  curses = [self.coursesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ ", curses.name ];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EditCoursesViewController* controller = [[EditCoursesViewController alloc] init];
    UINavigationController* vc = [[UINavigationController alloc] initWithRootViewController:controller];

       Course*  courses = [self.coursesArray objectAtIndex:indexPath.row];
        controller.courses = courses;
        [self presentViewController:vc animated:YES completion:nil];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
       Course*  curses = [self.coursesArray objectAtIndex:indexPath.row];

        [[DataManager sharedManager] deleteCourses:curses];
        
        [self reloadData];
    }
}

-(void) closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
