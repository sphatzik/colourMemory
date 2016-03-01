//
//  ViewController.m
//  colourMemory
//
//  Created by minus one on 15/02/16.
//  Copyright © 2016 Spyridon Chatzikotoulas. All rights reserved.
//

#import "ViewController.h"
#import "Card.h"


@interface ViewController ()


@end

@implementation ViewController

@synthesize scoreLabel;

NSMutableArray *boardCards;
NSMutableArray *uniqueNumsArray;
NSString* firstCard;
NSString* secondCard;
BOOL initialize;


int cardsNum = 16, tag1=0, tag2=0, countFlip = 0, countRand = 0, score=0, tag=0;


- (void)viewDidLoad {
    [super viewDidLoad];
    initialize=false;
    
    boardCards = [[NSMutableArray alloc] initWithCapacity:cardsNum];
    uniqueNumsArray =[[NSMutableArray alloc] initWithCapacity:cardsNum];
    
    [self initializeBoard];    //initialization of the deck

    score=0;

    
    scoreLabel.text = @"0";
    
    // Do any additional setup after loading the view, typically from a nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)flipCardBtn:(id)sender {
    
    countFlip++;
    
    
    if(countFlip == 1){   //start count how many flipped card are on deck maximum 10.
        for (int i=0; i<boardCards.count; i++) {
            if([sender tag] ==[[boardCards objectAtIndex:i] getBtnNumber]){
                
                firstCard = [[boardCards objectAtIndex:i] getCardName];
                UIImage *imgCard = [UIImage imageNamed:[[boardCards objectAtIndex:i] getCardName]];
                [sender setImage:imgCard forState:UIControlStateNormal];
            }
        }
        tag1 = [sender tag];   //get the tag of the selected card and then disable button interaction
        [self disableButtonInteraction:tag1];
    }
    
    
    if(countFlip == 2){
        
        for (int i=0; i<boardCards.count; i++) {
            if([sender tag]==[[boardCards objectAtIndex:i] getBtnNumber]){
                
                UIImage *imgCard = [UIImage imageNamed:[[boardCards objectAtIndex:i] getCardName]];
                [sender setImage:imgCard forState:UIControlStateNormal];
                secondCard = [[boardCards objectAtIndex:i] getCardName];
            }
        }
        tag2 = [sender tag];
        [self disableButtonInteraction:0];
    
    
        countFlip = 0;

    
        if([firstCard isEqualToString:secondCard] && tag1!=tag2){   //check if the cards are the same -> give 2 points
     
                score += 2;
        
                scoreLabel.text = [NSString stringWithFormat:@"%d",score];
                [self.view viewWithTag:(NSInteger)firstCard];
                [self.view viewWithTag:(NSInteger)secondCard];
                [self removeButtonFromDeck:tag1];
                [self removeButtonFromDeck:tag2];
        
                cardsNum-=2;
            
            
            if(cardsNum<=0){
                
                [self getPlayersName];
                cardsNum=16;
            }
            
            
        }
        else{
                score -= 1;   //if didn't found a match minus 1 point
                scoreLabel.text = [NSString stringWithFormat:@"%d",score];
        
                tag = tag1;
                [self performSelector:@selector(flipCardFromDeck) withObject:self afterDelay:1.0f]; //do the flipping after a certain delay
                tag = tag2;
                [self performSelector:@selector(flipCardFromDeck) withObject:self afterDelay:1.0f];
        }
        
    }
}






-(void) getPlayersName{  //pop up a warning to receive the name of the user and perform the seque
    
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Well Done!!!"
                               message:@"submit your high score"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* submit = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   UITextField *textField = alert.textFields[0];
                                                   
                                                   if ([textField hasText]){
                                                       
                                                       NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];  //store the score and name in a dictionary and then to NSUserdefaults
                                                       
                                                       
                                                       NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[defaults objectForKey:@"dictionary"]];
                                                       [dict setObject:textField.text forKey:scoreLabel.text];
                                                       [defaults setObject:dict forKey:@"dictionary"];
                                                       [defaults synchronize];
                                                       initialize=true;
                                                       [self performSegueWithIdentifier:@"highScores" sender:self];
                                                       
                                                   }
                                                   else{
                                                       [self getPlayersName];
                                                   }
                                                }];
    
    [alert addAction:submit];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"enter your name";
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark Helper methods


- (void) removeButtonFromDeck: (int) tag{

    [self.view viewWithTag:(NSInteger)tag].alpha = 0;
    
    [self enableButtonInteraction:0];
}



- (void) flipCardFromDeck{
    
    dispatch_async(dispatch_get_main_queue(),^{
        [[self.view viewWithTag:(NSInteger)tag1] setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
    });
    
    dispatch_async(dispatch_get_main_queue(),^{
        [[self.view viewWithTag:(NSInteger)tag2] setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
    });
    
    [self enableButtonInteraction:0];
    [self enableButtonInteraction:tag1];
    [self enableButtonInteraction:tag2];

    
}



-(void)disableButtonInteraction:(int)flag{
    
    if(flag==tag1){
        [[self.view viewWithTag:flag] setUserInteractionEnabled:NO];
    }
    else if(flag==tag2){
        [[self.view viewWithTag:flag] setUserInteractionEnabled:NO];
    }
    else{
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }
}



-(void)enableButtonInteraction:(int)flag{
    if(flag==tag1){
        [[self.view viewWithTag:flag] setUserInteractionEnabled:YES];
    }
    else if(flag==tag2){
        [[self.view viewWithTag:flag] setUserInteractionEnabled:YES];
    }
    else{
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
    
}



- (int)returnRandomNumber{  //helper method to retrieve 16 unique random numbers
    int num = arc4random_uniform(cardsNum)+1;
    int i=0;
    countRand++;
    
    while(i<=uniqueNumsArray.count){
        
        if(![uniqueNumsArray containsObject:[NSNumber numberWithInt:num]]){
            
            [uniqueNumsArray addObject:[NSNumber numberWithInt:num]];
            i++;
            break;
        }
        else{
            num = arc4random_uniform(cardsNum)+1;
        }
    }
    
    return num;
}


#pragma mark Initialization of the cards


-(void)initializeBoard{
    
    
    
    NSArray *colourCards = [NSArray arrayWithObjects:@"colour1",@"colour2",@"colour3",@"colour4",@"colour5",@"colour6",@"colour7",@"colour8",nil];
    
    
    for(int i=0; i<cardsNum/2; i++){
        
        Card *card1 = [[Card alloc] init];   //create a card
        Card *card2 = [[Card alloc] init];

        [card1 setCardName:[colourCards objectAtIndex:i]]; //give to the card a colour
        [card2 setCardName:[colourCards objectAtIndex:i]];

        [card1 setBtnNumber:[self returnRandomNumber]];  //initialize it with a random number (shuffle the deck)
        [card2 setBtnNumber:[self returnRandomNumber]];

        [boardCards addObject:card1];  //add the object to the Deck
        [boardCards addObject:card2];

    }
    
    
}

@end