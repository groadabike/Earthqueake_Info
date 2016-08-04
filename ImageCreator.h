//----------------------------------------------------------------------------
//
//  ImageCreator.h
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This class create an UIImage with text inside.
//
//----------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCreator : NSObject

@property (strong) UIImage *image;

-(id)initWithText:(double)text;

@end
