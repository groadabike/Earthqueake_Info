//----------------------------------------------------------------------------
//
//  ImageCreator.m
//  UnderMyFeet
//
//  Created by Luisa Z. and Gerardo R.
//
//  This class create an UIImage with text inside.
//
//----------------------------------------------------------------------------

#import "ImageCreator.h"

@implementation ImageCreator

-(id)initWithText:(double)text{
    self = [super init];
    if (self){
        _image=[self drawText:text inImage:[UIImage imageNamed:@"magnitude.png"] atPoint:CGPointMake(0, 0)];
    }
    return self;
}

-(UIImage*) drawText:(double)t inImage:(UIImage*)image atPoint:(CGPoint)point{
    
    NSString *text = [NSString stringWithFormat:@"%0.1f",t];
    UIFont *font = [UIFont boldSystemFontOfSize:50];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    if (t < 5.0){
        [[UIColor greenColor] set];
    }else if (t< 6.0){
        [[UIColor orangeColor] set];
    }else if (t< 7.0){
        [[UIColor redColor] set];
    }else{
        // Burgundy
        UIColor *burgundyColour = [UIColor colorWithRed:0.5019607/*128/255*/ green:0.0/*0/255*/ blue:0.1254901/*32/255*/ alpha:1];
        [burgundyColour set];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    // the pragma sentences are used to ignore one warning of deprecated function
    [text drawInRect:CGRectIntegral(rect) withFont:font];
#pragma clang diagnostic pop
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
            
    return newImage;
}

@end
