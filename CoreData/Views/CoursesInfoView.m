//
//  CoursesInfoViewController.m
//  CoreData
//
//  Created by mbp on 31/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "CoursesInfoView.h"

@interface CoursesInfoView ()

@property(strong, nonatomic) UILabel* nameLabel;
@property(strong, nonatomic) UILabel* lessonLabel;
@property(strong, nonatomic) UILabel* teacherLabel;

@end

@implementation CoursesInfoView

- (void)commonInit{
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"Курс";
    self.nameLabel.font =[UIFont systemFontOfSize:20];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.lessonLabel = [[UILabel alloc] init];
    self.lessonLabel.text = @"Количество уроков";
    self.lessonLabel.font =[UIFont systemFontOfSize:20];
    self.lessonLabel.textColor = [UIColor whiteColor];
    self.lessonLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.teacherLabel = [[UILabel alloc] init];
    self.teacherLabel.text = @"Имя преподавателя";
    self.teacherLabel.font =[UIFont systemFontOfSize:20];
    self.teacherLabel.textColor = [UIColor whiteColor];
    self.teacherLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.nameField = [[UITextField alloc] init];
    self.nameField.placeholder = @"Название курса";
    self.nameField.textAlignment = NSTextAlignmentCenter;
    [self.nameField setBorderStyle:UITextBorderStyleRoundedRect];
    self.nameField.translatesAutoresizingMaskIntoConstraints = NO;

    
    self.lessonField = [[UITextField alloc] init];
    self.lessonField.placeholder = @"Количество уроков";
    self.lessonField.textAlignment = NSTextAlignmentCenter;
    [self.lessonField setBorderStyle:UITextBorderStyleRoundedRect];
    self.lessonField.translatesAutoresizingMaskIntoConstraints = NO;

    self.teacherField = [[UITextField alloc] init];
    self.teacherField.placeholder = @"Имя преподавателя";
    self.teacherField.textAlignment = NSTextAlignmentCenter;
    [self.teacherField setBorderStyle:UITextBorderStyleRoundedRect];
    self.teacherField.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:self.nameLabel];
    [self addSubview:self.lessonLabel];
    [self addSubview:self.teacherLabel];
    
    [self addSubview:self.nameField];
    [self addSubview:self.lessonField];
    [self addSubview:self.teacherField];
    
    [self applyConstraints];
}

-(void)applyConstraints {
    NSDictionary* views = @{
                            @"nameL" : self.nameLabel,
                            @"surnameL" : self.lessonLabel,
                            @"numberL":self.teacherLabel,
                            @"nameF":self.nameField,
                            @"surnameF" : self.lessonField,
                            @"numberF" : self.teacherField
                            };
    
    NSArray* constraints =[[NSArray alloc] initWithObjects:
                           @"H:|-[nameL]-[nameF(120)]-|",
                           @"H:|-[surnameL]-[surnameF(120)]-|",
                           @"H:|-[numberL]-[numberF(120)]-|",
                           @"V:|-[nameL(30)]-11-[surnameL(30)]-11-[numberL(30)]-|",
                           @"V:|-[nameF(30)]-11-[surnameF(30)]-11-[numberF(30)]-10-|"
                           ,nil];
    
    NSMutableArray* layoutConstraint = [[NSMutableArray alloc] init];
    
    for (NSString* constraint in constraints) {
        NSArray* c = [NSLayoutConstraint constraintsWithVisualFormat:constraint options:0 metrics:nil views:views];
        [layoutConstraint addObjectsFromArray:c];
    }
    [NSLayoutConstraint activateConstraints:layoutConstraint];
}

- (id)initWithFrame:(CGRect)aRect
{
    if ((self = [super initWithFrame:aRect])) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
    if ((self = [super initWithCoder:coder])) {
        [self commonInit];
    }
    return self;
}

@end
