//React Native Audio Player logic(no UI)

#import "RCTBridgeModule.h"
#import "RCTEventEmitter.h"
@import AVFoundation;

@interface RNAudioPlayerURL : RCTEventEmitter <RCTBridgeModule>

@property (strong, nonatomic) AVPlayerItem *audioItem;
@property (strong, nonatomic) AVPlayer *audioPlayer;

@end
