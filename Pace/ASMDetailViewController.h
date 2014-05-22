//
//  ASMDetailViewController.h
//  Pace
//
//  Created by Andrew Molloy on 5/21/14.
//  Copyright (c) 2014 Andrew Molloy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASMDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
