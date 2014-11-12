//
//  RSSTableViewController.m
//  RSS reader app
//
//  Created by Kervins Valcourt on 11/9/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "RSSTableViewController.h"
#import "Datasource.h"
#import "Post.h"
#import "FavPostTableViewController.h"
#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface RSSTableViewController () 
@property (nonatomic,strong)NSArray *rssItems;
@property (nonatomic,strong)UIBarButtonItem *favPost;
@end

@implementation RSSTableViewController


- (instancetype) init {
    self = [super init];
    if (self) {
        
        [[Datasource sharedInstance] addObserver:self forKeyPath:@"self.rssItems" options:NSKeyValueObservingOptionNew context:nil];
        
        
        
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object ) {
        NSMutableArray *rsstmp = [NSMutableArray array];
        
        for (Post *post in [Datasource sharedInstance].rssItems) {
            [rsstmp addObject:post];
            //NSLog(@"%@",post.post);
        }
        
        self.rssItems = rsstmp;
    }
    [self.tableView reloadData];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)dealloc {
    [[Datasource sharedInstance] removeObserver:self forKeyPath:@"self.rssItems"];
}

- (void)loadView {
    [super loadView];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    

    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];

    self.favPost = [[UIBarButtonItem alloc] initWithTitle:@"My Fav Post" style:UIBarButtonItemStylePlain target:self action:@selector(favPostButtonFired:)];
     self.navigationItem.rightBarButtonItem = _favPost;
    
    self.title = @"Apple RSS Post";
    
}

- (void)favPostButtonFired:(id)sender {
    FavPostTableViewController *favPost = [[FavPostTableViewController alloc]init];
    
    [self.navigationController pushViewController:favPost animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.rssItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    // Configure the cell...
    Post *post = [self.rssItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = post.title;
   
    cell.imageView.image = post.postImage;
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewController *viewPost = [[ViewController alloc]init];
    viewPost.currentPost = (Post *)[self.rssItems objectAtIndex:indexPath.row];
    
    
    [self.navigationController pushViewController:viewPost animated:YES];;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
