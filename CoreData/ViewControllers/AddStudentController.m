//
//  StudentInfoController.m
//  CoreData
//
//  Created by mbp on 21/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "AddStudentController.h"
#import "DataManager.h"
#import "CoursesViewController.h"
#import "TeacherViewController.h"

@interface AddStudentController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic) UIButton* saveButton;
@property(strong, nonatomic) UITableView* tableView;
@property(strong, nonatomic) NSMutableArray* coursesArray;
@property(strong, nonatomic) NSMutableSet* selectedCourses;

@end

@implementation AddStudentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DynamicBackgroundView * view = [[DynamicBackgroundView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];

    NSArray* data= [DataManager.sharedManager getAllCourses];
    self.coursesArray = [[NSMutableArray alloc] initWithArray:data];
    self.selectedCourses = [[NSMutableSet alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 250, 100, 30)];
    [self.saveButton addTarget:self
                        action:@selector(saveInfo)
              forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.backgroundColor = [UIColor redColor];
    self.saveButton.layer.cornerRadius = 7;
    [self.saveButton setTitle:@"Сохранить" forState:UIControlStateNormal];

    self.navigationItem.title = @"Создание";

    [self.view addSubview:self.saveButton];
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                               target:self
                                                                               action:@selector(closeAction)];
    self.navigationItem.rightBarButtonItem = barButton;

    [self createTableView];
    [self createCustomView];
    [self.tableView reloadData];
}

-(void) createTableView {
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;

    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 310, width, height/2)
                                                          style:UITableViewStyleGrouped];
    [tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"Cell"];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}

-(void) createCustomView {
    self.studentInfo = [[StudentInfoView alloc] init];
    self.studentInfo.backgroundColor = [UIColor clearColor];
    self.studentInfo.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.studentInfo];
    
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self.studentInfo
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0f
                                                                        constant:350];
    
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self.studentInfo
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0f
                                                                         constant:130];
    
    [self.studentInfo addConstraint:constraintWidth];
    [self.studentInfo addConstraint:constraintHeight];
    
    NSLayoutConstraint *constraintX = [NSLayoutConstraint constraintWithItem:self.studentInfo
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0f
                                                                    constant:0];
    
    NSLayoutConstraint *constraintY = [NSLayoutConstraint constraintWithItem:self.studentInfo
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
    return [self.coursesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
   Course*  curses = [self.coursesArray objectAtIndex:indexPath.row];
    
    if ([self.selectedCourses containsObject:curses]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text =[NSString stringWithFormat:@"%@", curses.name];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Добавить курсы";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor whiteColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Course* curses = [self.coursesArray objectAtIndex:indexPath.row];
     if ([self.selectedCourses containsObject:curses]) {
          [self.selectedCourses removeObject:curses];
     }else {
          [self.selectedCourses addObject:curses];
     }
   
    [self.tableView reloadData];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

-(void)saveInfo{
    BOOL isNameFieldEmpty = [self.studentInfo.nameField.text length] == 0;
    BOOL isSurnameFieldEmpty = [self.studentInfo.surnameField.text length] == 0;

    if (!isNameFieldEmpty & !isSurnameFieldEmpty ) {
        [DataManager.sharedManager addNewStudent:self.studentInfo.nameField.text
                                             and:self.studentInfo.surnameField.text
                                             and:self.studentInfo.numberField.text
                                      andCourses:self.selectedCourses];
        [self closeAction];
    }
}

-(void) closeAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
