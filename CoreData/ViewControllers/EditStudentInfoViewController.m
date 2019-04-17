//
//  EditStudentInfoViewController.m
//  CoreData
//
//  Created by mbp on 22/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "EditStudentInfoViewController.h"
#import "DataManager.h"
#import "CoursesViewController.h"

@interface EditStudentInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic) UIButton* editButton;
@property(strong, nonatomic) UITableView* tableView;

@end

@implementation EditStudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DynamicBackgroundView * view = [[DynamicBackgroundView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
    
    NSArray* data= [DataManager.sharedManager getAllCourses];
    self.coursesArray = [[NSMutableArray alloc] initWithArray:data];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                               target:self
                                                                               action:@selector(closeAction)];
    
    
    self.editButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 250, 100, 30)];
    [self.editButton addTarget:self
                        action:@selector(editInfo)
              forControlEvents:UIControlEventTouchUpInside];
    self.editButton.backgroundColor = [UIColor redColor];
    self.editButton.layer.cornerRadius = 7;
    [self.editButton setTitle:@"Save" forState:UIControlStateNormal];
    
    self.navigationItem.title = @"Редактирование";
    
    [self.view addSubview:self.editButton];
    
    self.navigationItem.rightBarButtonItem = barButton;
    [self createCustomView];
    [self createTableView];
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
    
    self.studentInfo = [[StudentInfoView alloc] init];
    self.studentInfo.backgroundColor = [UIColor clearColor];
    self.studentInfo.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.studentInfo.nameField.text = self.student.name;
    self.studentInfo.surnameField.text = self.student.surname;
    self.studentInfo.numberField.text = self.student.number;
    
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


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

-(void)editInfo{
    BOOL isNameFieldEmpty = [self.studentInfo.nameField.text length] == 0;
    BOOL isSurnameFieldEmpty = [self.studentInfo.surnameField.text length] == 0;
    
    if (!isNameFieldEmpty & !isSurnameFieldEmpty ) {
        self.student.name = self.studentInfo.nameField.text;
        self.student.surname = self.studentInfo.surnameField.text;
        self.student.number = self.studentInfo.numberField.text;
        self.student.courses = self.selectedCourses;
        
        [DataManager.sharedManager editStudent:self.student];
        [self closeAction];
    }
}

-(void) closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    Course*  curses = [self.coursesArray objectAtIndex:indexPath.row];
    if ([self.selectedCourses containsObject:curses]) {
        [self.selectedCourses removeObject:curses];
    }else {
        [self.selectedCourses addObject:curses];
    }
    
    [self.tableView reloadData];
    
}




@end
