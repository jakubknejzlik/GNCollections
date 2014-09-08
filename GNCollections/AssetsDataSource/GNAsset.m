//
//  GNAsset.m
//
//  Created by Jakub Knejzlik on 08/09/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//


#import "GNAsset.h"

typedef struct {
    void *assetRepresentation;
    int decodingIterationCount;
} ThumbnailDecodingContext;
static const int kThumbnailDecodingContextMaxIterationCount = 16;


static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count) {
    ThumbnailDecodingContext *decodingContext = (ThumbnailDecodingContext *)info;
    ALAssetRepresentation *assetRepresentation = (__bridge ALAssetRepresentation *)decodingContext->assetRepresentation;
    if (decodingContext->decodingIterationCount == kThumbnailDecodingContextMaxIterationCount) {
        NSLog(@"WARNING: Image %@ is too large for thumbnail extraction.", [assetRepresentation url]);
        return 0;
    }
    ++decodingContext->decodingIterationCount;
    NSError *error = nil;
    size_t countRead = [assetRepresentation getBytes:(uint8_t *)buffer fromOffset:position length:count error:&error];
    if (countRead == 0 || error != nil) {
        NSLog(@"ERROR: Failed to decode image %@: %@", [assetRepresentation url], error);
        return 0;
    }
    return countRead;
}



@implementation GNAsset
-(id)initWithAsset:(ALAsset *)asset{
    self = [super init];
    if (self) {
        _asset = asset;
    }
    return self;
}

-(NSString *)type{
    return [self.asset valueForProperty:ALAssetPropertyType];
}
-(CLLocation *)location{
    return [self.asset valueForProperty:ALAssetPropertyLocation];
}
-(NSNumber *)duration{
    return [self.asset valueForProperty:ALAssetPropertyDuration];
}
-(NSNumber *)orientation{
    return [self.asset valueForProperty:ALAssetPropertyOrientation];
}
-(NSDate *)date{
    return [self.asset valueForProperty:ALAssetPropertyDate];
}
-(NSURL *)URL{
    return [self.asset valueForProperty:ALAssetPropertyAssetURL];
}

-(UIImage *)thumbnail{
    return [UIImage imageWithCGImage:[self.asset thumbnail]];
}
-(UIImage *)aspectRatioThumnail{
    return [UIImage imageWithCGImage:[self.asset aspectRatioThumbnail]];
}

-(UIImage *)fullResolutionImage{
    return [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullResolutionImage]];
}
-(UIImage *)fullScreenImage{
    return [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullScreenImage]];
}
-(CGSize)dimensions{
    return [[self.asset defaultRepresentation] dimensions];
}

- (UIImage *)thumbnailWithMaxPixelSize:(CGFloat)size{
    NSParameterAssert(self.asset);
    NSParameterAssert(size > 0);
    ALAssetRepresentation *representation = [self.asset defaultRepresentation];
    if (!representation) {
        return nil;
    }
    CGDataProviderDirectCallbacks callbacks = {
        .version = 0,
        .getBytePointer = NULL,
        .releaseBytePointer = NULL,
        .getBytesAtPosition = getAssetBytesCallback,
        .releaseInfo = NULL
    };
    ThumbnailDecodingContext decodingContext = {
        .assetRepresentation = (__bridge void *)representation,
        .decodingIterationCount = 0
    };
    CGDataProviderRef provider = CGDataProviderCreateDirect((void *)&decodingContext, [representation size], &callbacks);
    NSParameterAssert(provider);
    if (!provider) {
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    NSParameterAssert(source);
    if (!source) {
        CGDataProviderRelease(provider);
        return nil;
    }
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{(NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                                                                      (NSString *)kCGImageSourceThumbnailMaxPixelSize          : [NSNumber numberWithFloat:size],
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailWithTransform   : @YES});
    UIImage *image = nil;
    if (imageRef) {
        image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    CFRelease(source);
    CGDataProviderRelease(provider);
    return image;
}

static const NSUInteger BufferSize = 1024*1024;
-(BOOL)exportDataToURL:(NSURL*)fileURL error:(NSError**)error
{
    [[NSFileManager defaultManager] createFileAtPath:[fileURL path] contents:nil attributes:nil];
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingToURL:fileURL error:error];
    if (!handle) {
        return NO;
    }
    
    ALAssetRepresentation *rep = [self.asset defaultRepresentation];
    uint8_t *buffer = calloc(BufferSize, sizeof(*buffer));
    NSUInteger offset = 0, bytesRead = 0;
    
    do {
        @try {
            bytesRead = [rep getBytes:buffer fromOffset:offset length:BufferSize error:error];
            [handle writeData:[NSData dataWithBytesNoCopy:buffer length:bytesRead freeWhenDone:NO]];
            offset += bytesRead;
        } @catch (NSException *exception) {
            free(buffer);
            return NO;
        }
    } while (bytesRead > 0);
    
    free(buffer);
    return YES;
}

@end