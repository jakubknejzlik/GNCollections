//
//  GNAsset.h
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

@interface GNAsset : NSObject
@property (nonatomic,readonly) ALAsset *asset;
@property (nonatomic,readonly) NSString *type;
@property (nonatomic,readonly) CLLocation *location;
@property (nonatomic,readonly) NSNumber *duration;
@property (nonatomic,readonly) NSNumber *orientation;
@property (nonatomic,readonly) NSDate *date;
@property (nonatomic,readonly) NSURL *URL;

-(id)initWithAsset:(ALAsset *)asset;

-(UIImage *)thumbnail;
-(UIImage *)aspectRatioThumnail;

-(UIImage *)fullResolutionImage;
-(UIImage *)fullScreenImage;
-(CGSize)dimensions;

- (UIImage *)thumbnailWithMaxPixelSize:(CGFloat)size;
-(BOOL)exportDataToURL:(NSURL*)fileURL error:(NSError**)error;

@end
