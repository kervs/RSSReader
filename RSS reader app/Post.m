//
//  Post.m
//  RSS reader app
//
//  Created by Kervins Valcourt on 11/9/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "Post.h"

@implementation Post


- (instancetype) initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    if (self) {
        self.linkToSite =  [userDictionary valueForKeyPath:@"link.attributes.href"];
        self.title = userDictionary[@"title"][@"label"];
        self.post = userDictionary[@"summary"][@"label"];
        self.cost = [userDictionary valueForKeyPath:@"im:price.label"];
        NSArray *urlImage = [userDictionary valueForKeyPath:@"im:image.label"];
        NSLog(@"%@",self.cost);
       NSURL *imageURL = [NSURL URLWithString:urlImage[1]];
        
        if (imageURL) {
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
           
            self.postImage = [[UIImage alloc]initWithData:data] ;
        }
        
    }
    
    return self;
}











@end
