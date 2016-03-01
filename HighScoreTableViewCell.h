//
//  HighScoreTableViewCell.h
//  colourMemory
//
//  Created by minus one on 18/02/16.
//  Copyright © 2016 Spyridon Chatzikotoulas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@end
