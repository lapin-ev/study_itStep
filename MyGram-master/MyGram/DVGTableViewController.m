//
//  DVGTableViewController.m
//  instagramClient
//
//  Created by Dmitry Volevodz on 26.03.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "DVGTableViewController.h"
#import "DVGNewsLoader.h"
#import "AFNetworking.h"
#import "DVGTableViewCell.h"
#import "DVGDetailViewController.h"
#import "DVGViewController.h"


#define kCellHeight 400

@interface DVGTableViewController ()

@end

@implementation DVGTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.manager = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:90.0f tableView:self.tableView withClient:self];
    self.managerTop = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:90.0f tableView:self.tableView withClient:self];
    
    // ios 6 method
    //[self.tableView registerClass:[DVGTableViewCell class] forCellReuseIdentifier:@"MyCell"];
    self.loader = [DVGNewsLoader newsLoader];
    self.loader.myTableVC = self;
    self.cache = self.loader.sharedCache;
    
    /*
    UIRefreshControl *refresher = [[UIRefreshControl alloc] init];
    refresher.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh."];
    [refresher addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresher;
     */
    
    UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(logout)];
    self.navigationItem.leftBarButtonItem = logout;
    
    
    // self.tableView.delegate = [DVGNewsLoader newsLoader];
    // self.tableView.dataSource = [DVGNewsLoader newsLoader];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    // Return the number of rows in the section.
    DVGNewsLoader *loader = [DVGNewsLoader newsLoader];
    if (loader.dataArray != nil)
    {
    
    return [loader.parsedData count];
    }
    else
    {
        return 0;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCell";
    DVGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if(cell == nil){
        
        cell = [[DVGTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.tag = indexPath.row;
    
    if (self.loader.parsedData[indexPath.row] != nil)
    {
        cell.imageCustom.image = nil;
        
        if ([[self.loader.parsedData[indexPath.row] objectForKey:@"liked"] intValue])
        {
            [cell.imageLike setHidden:NO];
        }
        
        else
        {
            [cell.imageLike setHidden:YES];
        }
        
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^(void) {
                
                NSString *url = [self.loader.parsedData[indexPath.row] objectForKey:@"imageLR"];
                NSData *imageData = nil;
                if ([self.cache objectForKey:url] != nil)
                {
                    imageData = [self.cache objectForKey:url];
                }
                
                else
                {
                    imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                [self.cache setObject:imageData forKey:[self.loader.parsedData[indexPath.row] objectForKey:@"imageLR"]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (cell.tag == indexPath.row) {
                        UIImage *image = [[UIImage alloc] initWithData:imageData];
                        cell.imageCustom.image = image;
                        [cell setNeedsLayout];
                    }
                });
            });

    //cell.textLabel.text = [self.loader.parsedData[indexPath.row] objectForKey:@"id"];
    }
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
     
    
     // ...
     // Pass the selected object to the new view controller.
    
    DVGDetailViewController *detail = [[DVGDetailViewController alloc] initWithNumber:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
}


// Высота яейки.

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell.tag != indexPath.row)
    {
        cell.imageView.image = nil;
    }
}
/*
- (void) refreshView:(UIRefreshControl *) refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating data..."];
    
    [self.loader getData];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"hh:mm"];
    NSString *lastUpdate = [NSString stringWithFormat:@"Last updated: %@", [format stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdate];
    [refresh endRefreshing];
    [self.tableView reloadData];
}


*/

- (void) logout
{
    [self presentViewController:[[DVGViewController alloc] init] animated:NO completion:nil];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.manager tableViewScrolled];
    [self.managerTop tableViewScrolled];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.manager tableViewReleased];
    [self.managerTop tableViewReleased];
}

- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager
{    
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
}

- (void)pullToRefreshTriggered:(MNMPullToRefreshManager *)manager
{    
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}


- (void) loadTable
{
    [self.loader getMoreData];
}

- (void) refreshTable
{
    [self.loader getData];
    [self.managerTop tableViewReloadFinishedAnimated:YES];
}


- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [self.manager relocatePullToRefreshView];
}




     @end
