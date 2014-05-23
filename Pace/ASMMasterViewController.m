//
//  ASMMasterViewController.m
//  Pace
//
//  Created by Andrew Molloy on 5/21/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import "ASMMasterViewController.h"
#import "ASMTrack.h"

@interface ASMMasterViewController ()
@property (nonatomic, strong) NSArray* tracks;
@property (nonatomic, strong) NSTimer* reloadOnInsertTime;
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

	self.tracks = [ASMTrack instancesOrderedBy:@"title"];
}

- (void)viewWillAppear:(BOOL)animated
{
	[NSNotificationCenter.defaultCenter addObserver:self
										   selector:@selector(modelDidUpdate:)
											   name:FCModelInsertNotification
											 object:ASMTrack.class];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[NSNotificationCenter.defaultCenter removeObserver:self
												  name:FCModelInsertNotification
												object:ASMTrack.class];
	[NSNotificationCenter.defaultCenter removeObserver:self
												  name:FCModelUpdateNotification
												object:ASMTrack.class];
}

- (void)modelDidUpdate:(NSNotification*)notification
{
	static NSInteger sUpdateCount = 0;

	sUpdateCount++;

	[self.reloadOnInsertTime invalidate];
	self.reloadOnInsertTime = nil;
	if (sUpdateCount % 50 == 0)
	{
		[self reloadAllData];
	}
	else
	{
		self.reloadOnInsertTime = [NSTimer scheduledTimerWithTimeInterval:0.5
																   target:self
																 selector:@selector(reloadAllData)
																 userInfo:nil
																  repeats:NO];
	}
}

- (void)reloadAllData
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		self.tracks = [ASMTrack instancesOrderedBy:@"title"];
		[self.tableView performSelectorOnMainThread:@selector(reloadData)
										 withObject:nil
									  waitUntilDone:NO];
	});
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
	ASMTrack* track = self.tracks[indexPath.row];

    cell.textLabel.text = track.title;
	cell.detailTextLabel.text = [track.tempo description];
}

@end
