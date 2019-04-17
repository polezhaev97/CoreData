//
//  AddCoursesViewController.m
//  CoreData
//
//  Created by mbp on 31/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "DataManager.h"
#import "CoursesViewController.h"
#import "StudentsListViewController.h"
#import "AddCoursesViewController.h"

@interface AddCoursesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic) UIButton* saveButton;
@property(strong, nonatomic) UITableView* tableView;
@property(strong, nonatomic) NSMutableArray* studentArray;
@property(strong, nonatomic) NSMutableSet* selectedStudents;

@end

@implementation AddCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DynamicBackgroundView * view = [[DynamicBackgroundView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];

    NSArray* data= [DataManager.sharedManager getAllStudents];
    self.studentArray = [[NSMutableArray alloc] initWithArray:data];
    self.selectedStudents = [[NSMutableSet alloc] init];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 250, 100, 30)];
    [self.saveButton addTarget:self
                        action:@selector(saveInfo)
              forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.backgroundColor = [UIColor redColor];
    self.saveButton.layer.cornerRadius = 7;
    [self.saveButton setTitle:@"Сохранить" forState:UIControlStateNormal];

    [self.view addSubview:self.saveButton];
    
    self.navigationItem.title = @"Создание";
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                               target:self
                                                                               action:@selector(closeAction)];

    self.navigationItem.rightBarButtonItem = barButton;
    
    [self createTableView];
    [self createCustomView];
}

-(void) createTableView {
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 310, width, height - 310)
                                                          style:UITableViewStyleGrouped];
    [tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"Cell"];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}


-(void) createCustomView{
    
    self.coursesInfo = [[CoursesInfoView alloc] init];
    self.coursesInfo.backgroundColor = [UIColor clearColor];
    self.coursesInfo.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.coursesInfo];
    
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self.coursesInfo
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0f
                                                                        constant:350];
    
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self.coursesInfo
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0f
                                                                         constant:130];
    
    [self.coursesInfo addConstraint:constraintWidth];
    [self.coursesInfo addConstraint:constraintHeight];
    
    NSLayoutConstraint *constraintX = [NSLayoutConstraint constraintWithItem:self.coursesInfo
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0f
                                                                    constant:0];
    
    NSLayoutConstraint *constraintY = [NSLayoutConstraint constraintWithItem:self.coursesInfo
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:0.5f
                                                                    constant:0];
    
    [self.view addConstraint:constraintX];
    [self.view addConstraint:constraintY];
}


#pragma mark - UITableViewDataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.studentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Student*  student = [self.studentArray objectAtIndex:indexPath.row];
    if ([self.selectedStudents containsObject:student]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text =[NSString stringWithFormat:@"%@ %@", student.name, student.surname];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Student*  student = [self.studentArray objectAtIndex:indexPath.row];
    
    if ([self.selectedStudents containsObject:student]) {
        [self.selectedStudents removeObject:student];
    }else {
        [self.selectedStudents addObject:student];
    }
    
    [self.tableView reloadData];
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"Добавить студентов";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor whiteColor];
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    
}

-(void)saveInfo{
    BOOL isNameFieldEmpty = [self.coursesInfo.nameField.text length] == 0;
    BOOL isTeacherFieldEmpty = [self.coursesInfo.teacherField.text length] == 0;
    
    if (!isNameFieldEmpty & !isTeacherFieldEmpty ) {
        [DataManager.sharedManager addCourses:self.coursesInfo.nameField.text
                                          and:self.coursesInfo.lessonField.text
                                          and:self.coursesInfo.teacherField.text
                                  andStudents:self.selectedStudents];
        [self closeAction];
    }
}

-(void) closeAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
