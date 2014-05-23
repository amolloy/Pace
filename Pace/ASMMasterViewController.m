//
//  ASMMasterViewController.m
//  Pace
//
//  Created by Andrew Molloy on 5/21/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "ASMMasterViewController.h"
#import "ASMTrackFC.h"

@interface ASMMasterViewController ()
@property (nonatomic, strong) NSArray* tracks;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation ASMMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;

	NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
	self.tracks = [ASMTrackFC instancesOrderedBy:@"title"];
	NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];
	NSTimeInterval delta = end - start;
	NSInteger minutes = delta / 60;
	NSInteger seconds = (NSInteger)delta % 60;

	NSLog(@"Loaded: %@:%@", @(minutes), @(seconds));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.tracks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	ASMTrackFC* track = self.tracks[indexPath.row];

    cell.textLabel.text = track.title;
	cell.detailTextLabel.text = [track.tempo description];
}

@end
