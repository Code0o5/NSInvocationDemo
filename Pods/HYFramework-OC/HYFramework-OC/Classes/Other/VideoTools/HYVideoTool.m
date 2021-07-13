//
//  WGVideoTool.m
//  findmiHotel
//
//  Created by 帅棋 on 2020/12/5.
//

#import "HYVideoTool.h"

@implementation HYVideoTool
+ (void)getVideoPreViewImageURL:(NSURL *)path
                   imageSuccess:(void (^)(UIImage *image))imageSuccess{
   dispatch_group_t group = dispatch_group_create();
   __block UIImage *videoImage;
   dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
       AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
       AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
       assetGen.appliesPreferredTrackTransform = YES;
       CMTime time = CMTimeMakeWithSeconds(0.0, 2);
       NSError *error = nil;
       CMTime actualTime;
       CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
       videoImage = [[UIImage alloc] initWithCGImage:image];
       CGImageRelease(image);
       dispatch_group_notify(group, dispatch_get_main_queue(), ^{
           //主线程
           if (imageSuccess) {
               imageSuccess(videoImage);
           }
       });
   });
}

+ (void)getVideoImageFromPHAsset:(PHAsset *)asset Complete:(void (^)(UIImage *image))resultBack{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        UIImage *iamge = result;
        resultBack(iamge);
    }];
}

+ (void)getVideoPathFromPHAsset:(PHAsset *)asset Complete:(void (^)(NSString *filePatch, NSData *data, NSString *dTime))result {
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;

    [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        AVURLAsset *urlAsset = (AVURLAsset *)asset;
        NSString *filePath = [urlAsset.URL path];
        NSData *data = [NSData dataWithContentsOfURL:urlAsset.URL];
        
        CMTime   time = [asset duration];
        int seconds = ceil(time.value/time.timescale);
        //format of minute
        NSString *str_minute = [NSString stringWithFormat:@"%d",seconds/60];
        //format of second
        NSString *str_second = [NSString stringWithFormat:@"%.2d",seconds%60];
        //format of time
        NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
        result(filePath,data,format_time);
    }];
}


+ (void)convertMovSourceURL:(NSURL *)sourceUrl Complete:(void (^)(NSString * filePath, NSArray *files))result{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:sourceUrl options:nil];
    NSArray *compatiblePresets=[AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession=[[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
        [formater setDateFormat:@"yyyyMMddHHmmss"];
        NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        exportSession.outputURL=[NSURL fileURLWithPath:resultPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void){
             switch (exportSession.status) {
                case AVAssetExportSessionStatusCancelled:
                     NSLog(@"AVAssetExportSessionStatusCancelled");
                     break;
                 case AVAssetExportSessionStatusCompleted:
                 {
                     NSError * error;
                     NSArray *files=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/"] error:&error];
                     NSLog(@"%@",files);
                     result(resultPath,files);
                     if (error) {
                         NSLog(@"%@",error);
                     }
                     
                     break;
                 }
                 case AVAssetExportSessionStatusFailed:
                     NSLog(@"AVAssetExportSessionStatusFailed");
                     break;
                 default:
                     break;
             }
         }];
    }
}

@end
    
