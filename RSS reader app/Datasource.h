//
//  Datasource.h
//  RSS reader app
//
//  Created by Kervins Valcourt on 11/9/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface Datasource : NSObject

+(instancetype) sharedInstance;

@property (nonatomic, strong, readonly) NSArray *rssItems;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void) addNewPost:(NSString *)title andPost:(NSString *)post andImage:(UIImage *)image andLink:(NSString *)link andCost:(NSString *)cost;

- (void) getRssData;
@end
