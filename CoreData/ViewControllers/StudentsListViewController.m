//
//  ViewController.m
//  CoreData
//
//  Created by mbp on 18/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "StudentsListViewController.h"
#import "DataManager.h"
#import "AddStudentController.h"
#import "EditStudentInfoViewController.h"
#import "CoursesViewController.h"

@interface StudentsListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic) UITableView* tableView;

@end

@implementation StudentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSArray* data = [DataManager.sharedManager getAllStudents];
    self.studentArray = [[NSMutableArray alloc] initWithArray:data];

    [self createTableView];
    
    self.navigationItem.title = @"Студенты";
    UIBarButtonItem* add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addStudent)];
    
    UIBarButtonItem* delete  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                             target:self
                                                                             action:@selector(deleteAll)];
    self.navigationItem.rightBarButtonItems = @[add, delete];

}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self reloadData];
}

-(void) createTableView {
    
    CGRect frame = self.view.frame;
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}

-(void) reloadData{
    NSArray* data = [DataManager.sharedManager getAllStudents];
    self.studentArray = [[NSMutableArray alloc] initWithArray:data];

    [self.tableView reloadData];
}

-(void) addStudent {
    AddStudentController* vc = [[AddStudentController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) deleteAll {
    [DataManager.sharedManager deleteAllStudents];
    [self reloadData];
}

#pragma mark - UITableViewDataSourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.studentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifier];
    }
    
    Student*  student = [self.studentArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ - %@",student.name, student.surname, student.number];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",student.courses.count];;
    
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EditStudentInfoViewController* controller = [[EditStudentInfoViewController alloc] init];
    UINavigationController* vc = [[UINavigationController alloc] initWithRootViewController:controller];
    
    Student*  student = [self.studentArray objectAtIndex:indexPath.row];
    controller.selectedCourses = [[NSMutableSet alloc] initWithSet: student.courses];
    controller.student = student;
    [self presentViewController:vc animated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Student*  student = [self.studentArray objectAtIndex:indexPath.row];

        [[DataManager sharedManager] deleteStudent:student];
        
        [self reloadData];
    }
}


@end
