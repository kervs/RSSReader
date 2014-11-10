//
//  FavoritePost.h
//  RSS reader app
//
//  Created by Kervins Valcourt on 11/10/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FavoritePost : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * post;
@property (nonatomic, retain) NSData * postImage;
@property (nonatomic, retain) NSString * linkToSite;
@property (nonatomic, retain) NSString * cost;

@end
