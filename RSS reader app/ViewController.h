//
//  ViewController.h
//  RSS reader app
//
//  Created by Kervins Valcourt on 11/9/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface ViewController : UIViewController
@property (nonatomic,strong)Post *currentPost;
@property (nonatomic,assign)BOOL favorPost;


@end

