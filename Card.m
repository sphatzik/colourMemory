//
//  Card.m
//  colourMemory
//
//  Created by minus one on 15/02/16.
//  Copyright © 2016 Spyridon Chatzikotoulas. All rights reserved.
//



#import "Card.h"


@implementation Card
@synthesize btnNumber;
@synthesize cardName;


-(void)setBtnNumber:(int)_btnNumber{
    
    btnNumber = _btnNumber;
}

-(int)getBtnNumber{
    
    return btnNumber;
}

-(void)setCardName:(NSString *)_cardName{
    
    cardName = _cardName;
}

-(NSString*)getCardName{
    
    return cardName;
}

@end
