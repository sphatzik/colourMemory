//
//  HighScoreViewController.m
//  colourMemory
//
//  Created by minus one on 18/02/16.
//  Copyright © 2016 Spyridon Chatzikotoulas. All rights reserved.
//

#import "HighScoreViewController.h"
#import "HighScoreTableViewCell.h"


@implementation HighScoreViewController

NSMutableArray *highScoreArray;
NSArray *sortedhighScoreArray;
NSMutableArray *nameArray;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dict = [defaults objectForKey:@"dictionary"];

    highScoreArray = [NSMutableArray arrayWithArray:dict.allKeys];
    
    sortedhighScoreArray = [highScoreArray sortedArrayUsingComparator:^(NSString *str1, NSString *str2){
        return [@([str2 intValue]) compare:@([str1 intValue])];  //sort the elements of the array according to the intValue of the String
    }];
    
    
    nameArray = [[NSMutableArray alloc] init];
    
    for(int i=0; i<sortedhighScoreArray.count;i++){
        [nameArray addObject:[dict objectForKey:[sortedhighScoreArray objectAtIndex:i]]];  //get the correct names according to sortedHighScoreArray
    }
    

    
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [highScoreArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellIdentifier = @"HighScoreCell";
    NSString* ranking;
    
    
    HighScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[HighScoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
        ranking = @(indexPath.row+1).stringValue;
        
        cell.rankLabel.text =  ranking;
        cell.nameLabel.text = [nameArray objectAtIndex:indexPath.row];
        cell.scoreLabel.text = [sortedhighScoreArray objectAtIndex:indexPath.row];
    
    
    return cell;
    
}


@end
