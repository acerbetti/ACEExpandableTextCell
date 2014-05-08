//
//  ACEViewController.m
//  ACEExpandableTextCellDemo
//
//  Created by Stefano Acerbetti on 6/5/13.
//  Copyright (c) 2013 Stefano Acerbetti. All rights reserved.
//

#import "ACEViewController.h"
#import "ACEExpandableTextCell.h"

@interface ACEViewController ()<ACEExpandableTableViewDelegate> {
    CGFloat _cellHeight[2];
}

@property (nonatomic, strong) NSMutableArray *cellData;

@end

@implementation ACEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cellData = [NSMutableArray arrayWithArray:@[ @"Existing text", @""]];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACEExpandableTextCell *cell = [tableView expandableTextCellWithId:@"cellId"];
    cell.text = [self.cellData objectAtIndex:indexPath.section];
    cell.textView.placeholder = @"Placeholder";
    return cell;
}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAX(50.0, _cellHeight[indexPath.section]);
}

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
    _cellHeight[indexPath.section] = height;
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
    [_cellData replaceObjectAtIndex:indexPath.section withObject:text];
}

@end
