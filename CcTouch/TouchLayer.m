//
//  TouchLayer.m
//  BasicCocos2D
//
//  Created by Fan Tsai Ming on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TouchLayer.h"

@implementation TouchLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];	
	TouchLayer *layer = [TouchLayer node];
	[scene addChild: layer];
  
	return scene;
}

#pragma mark -
#pragma mark Touch Event

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint point = [touch locationInView:[touch view]];
  point = [[CCDirector sharedDirector]convertToGL:point];
  
  CGRect rect = CGRectMake(point.x - 0.5*ballSprite.contentSize.width, point.y - 0.5*ballSprite.contentSize.height, ballSprite.contentSize.width, ballSprite.contentSize.height);
  if (CGRectContainsPoint(rect, point)) {
    [ballSprite runAction:[CCScaleTo actionWithDuration:0.15 scale:1.2]];
    
    //hide info
    [infoLabel runAction:[CCSequence actions:[CCFadeOut actionWithDuration:0.3],[CCHide action],nil]];
  }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint point = [touch locationInView:[touch view]];
  point = [[CCDirector sharedDirector]convertToGL:point];
  
  CGPoint oldTouchPoint = [touch previousLocationInView:[touch view]];
  oldTouchPoint = [[CCDirector sharedDirector]convertToGL:oldTouchPoint];
  
  CGRect rect = CGRectMake(point.x - 0.5*ballSprite.contentSize.width, point.y - 0.5*ballSprite.contentSize.height, ballSprite.contentSize.width, ballSprite.contentSize.height);
  if (CGRectContainsPoint(rect, point)) {
//    [ballSprite setPosition:ccp(point.x, point.y)];
    [ballSprite setPosition:ccpAdd(ballSprite.position, ccpSub(point, oldTouchPoint))];
  }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint point = [touch locationInView:[touch view]];
  point = [[CCDirector sharedDirector]convertToGL:point];
  
  CGRect rect = CGRectMake(point.x - 0.5*ballSprite.contentSize.width, point.y - 0.5*ballSprite.contentSize.height, ballSprite.contentSize.width, ballSprite.contentSize.height);
  if (CGRectContainsPoint(rect, point)) {
    [ballSprite runAction:[CCScaleTo actionWithDuration:0.15 scale:1]];
  }
}

#pragma mark -
#pragma mark Infomation Label

-(void)setInfoLabel {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  int fontSize = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad? 28:18;
  
  infoLabel = [CCLabelTTF labelWithString:@"Tap on Ball and Drag it around" fontName:@"Helvetica" fontSize:fontSize];
  [infoLabel setPosition:ccp(winSize.width/2, winSize.height/2-100)];
  [self addChild:infoLabel];
}

#pragma mark -
#pragma mark Set Ball

-(void)setBall {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  ballSprite = [CCSprite spriteWithFile:@"ball.png"];
  [ballSprite setPosition:ccp(winSize.width/2, winSize.height/2)];
  [self addChild:ballSprite];
}

/*
 Target:
 Drag the ball around.
 
 1. Set a ball.
 2. Set a information label.
 3. Set Touch Event for handling touch begin, touch move, and touch end.
 */

#pragma mark -
#pragma mark Init

-(id) init {
	if( (self = [super init])) {
    [self setBall];
    
    [self setInfoLabel];
    
    self.isTouchEnabled = YES;
	}
  
	return self;
}

- (void) dealloc {
	[super dealloc];
}


@end
