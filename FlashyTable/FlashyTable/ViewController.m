//
//  ViewController.m
//  FlashyTable
//
//  Created by Ryan Cohen on 6/29/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

#import <ChameleonFramework/Chameleon.h>
#import "UIScrollView+APParallaxHeader.h"
#import "SWTableViewCell.h"

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSUInteger numberOfCells;

@end

@implementation ViewController

#pragma mark - Table

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Mail (%lu)", self.numberOfCells];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfCells;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.leftUtilityButtons = [self leftButtons];
    cell.delegate = self;
    
    cell.textLabel.text = @"Important Mail";
    cell.detailTextLabel.text = @"From ryan.cohen@flatironschool.com";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - SWDelegates

- (NSArray *)leftButtons {
    NSMutableArray *buttons = [NSMutableArray array];
    [buttons sw_addUtilityButtonWithColor:[UIColor flatBlueColor] title:@"Read"];
    [buttons sw_addUtilityButtonWithColor:[UIColor flatRedColor] title:@"Delete"];
    
    return buttons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    if (index == 0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell hideUtilityButtonsAnimated:YES];
    } else {
        self.numberOfCells--;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numberOfCells = 3;
    
    [self.tableView addParallaxWithImage:[UIImage imageNamed:@"cover"] andHeight:160.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
