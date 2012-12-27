//
//  TouchLayer.h
//  BasicCocos2D
//
//  Created by Fan Tsai Ming on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface TouchLayer : CCLayer
{
  CCSprite *ballSprite;
  CCLabelTTF *infoLabel;
}

+(CCScene *) scene;

@end
