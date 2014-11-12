//
//  Datasource.m
//  RSS reader app
//
//  Created by Kervins Valcourt on 11/9/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "Datasource.h"
#import "Post.h"
#import "FavoritePost.h"
#import "AppDelegate.h"

@interface Datasource()
@property (nonatomic, strong)NSArray *rssItems;
@end

@implementation Datasource

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        

        
        self.managedObjectContext = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
        [self getRssData];

        
        
        }
    return self;
}


- (void) addNewPost:(NSString *)title andPost:(NSString *)post andImage:(UIImage*)image andLink:(NSString *)link andCost:(NSString *)cost {
    FavoritePost  *favPost = [NSEntityDescription insertNewObjectForEntityForName:@"FavoritePost" inManagedObjectContext:self.managedObjectContext];

    favPost.title = title;
    favPost.post = post;
    favPost.postImage = UIImageJPEGRepresentation(image,1);
    favPost.linkToSite = link;
    favPost.cost = cost;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Erorr: %@",error);
    }
    

}

- (void) getRssData {
    dispatch_queue_t fetchQ = dispatch_queue_create("Rss fectcher", NULL);
    dispatch_async(fetchQ, ^{
        NSURL *url = [NSURL URLWithString:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topgrossingapplications/sf=143441/limit=25/json"];
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSDictionary *rssList = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
        rssList = [rssList valueForKeyPath:@"feed.entry"];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSMutableArray *tmpRSSItems = [NSMutableArray array];
            //NSLog(@"RSS json %@",rssList);
            for (NSDictionary *rssDic in rssList) {
                Post *postItem = [[Post alloc]initWithDictionary:rssDic];
                //NSLog(@"%@",postItem.postImage);
                if (postItem) {
                    [tmpRSSItems addObject:postItem];
                }
            }
            //NSLog(@"count %@",tmpRSSItems[0]);
            self.rssItems = [[NSArray alloc]initWithArray:tmpRSSItems];
        });
        


    });
}

@end
