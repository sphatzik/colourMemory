//
//  Card.h
//  colourMemory
//
//  Created by minus one on 15/02/16.
//  Copyright © 2016 Spyridon Chatzikotoulas. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface Card : NSObject


@property (nonatomic) int btnNumber;
@property (nonatomic) NSString* cardName;



-(void)setBtnNumber:(int)_btnNumber;
-(int)getBtnNumber;


-(void)setCardName:(NSString*)_cardName;
-(NSString*)getCardName;

@end
