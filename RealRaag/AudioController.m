//
//  AudioController.m
//  RealRaag
//
//  Created by Matthew S. Hill on 7/22/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "AudioController.h"
#import <AssertMacros.h>

@interface AudioController()

@property (readwrite) Float64 graphSampleRate;
@property (readwrite) AUGraph processingGraph;
@property (readwrite) AudioUnit mixerUnit;
@property (readwrite) AudioUnit samplerUnit1;
@property (readwrite) AudioUnit samplerUnit2;
@property (readwrite) AudioUnit samplerUnit3;
@property (readwrite) AudioUnit ioUnit;
@property (nonatomic) NSMutableArray *notes1;
@property (nonatomic) NSMutableArray *notes2;
@property (nonatomic) NSMutableArray *notes3;
@property (nonatomic) AUNode mixerNode;

- (OSStatus) loadSamplerFromAUPresetURL: (NSURL *) presetURL sampler:(AudioUnit)samplerUnit;
- (BOOL) createAUGraph;
- (void) configureAndStartAudioProcessingGraph: (AUGraph) graph;
- (void) stopAudioProcessingGraph;
- (void) restartAudioProcessingGraph;

@end

@implementation AudioController

+ (AudioController *)sharedInstance
{
    static AudioController *sharedInstance = nil;
    if(!sharedInstance)
    {
        sharedInstance = [[AudioController alloc] init];
    }
    return sharedInstance;
    
}

- (id)init
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    //TODO: DRIVER
    BOOL audioSessionActivated = [self setupAudioSession];
    NSAssert (audioSessionActivated == YES, @"unable to set up audio session.");
    [self createAUGraph];
    [self configureAndStartAudioProcessingGraph:self.processingGraph];
    [self loadAUPresets: self];
    
    return self;
}

#pragma mark - Core Audio Setup/Teardown

-(BOOL) createAUGraph {
    
    OSStatus result = noErr;
    AUNode samplerNode1, samplerNode2, samplerNode3, ioNode;
    AudioComponentDescription cd = {};
    
    cd.componentManufacturer = kAudioUnitManufacturer_Apple;
    cd.componentFlags = 0;
    cd.componentFlagsMask = 0;
    
    result = NewAUGraph(&_processingGraph);
    NSCAssert(result == noErr, @"Unable to create an AUGraph object. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    //Sampler AU
    cd.componentType = kAudioUnitType_MusicDevice;
    cd.componentSubType = kAudioUnitSubType_Sampler;
    
    //Add the Sampler unit node to the graph
    result = AUGraphAddNode(self.processingGraph, &cd, &samplerNode1);
    result = AUGraphAddNode(self.processingGraph, &cd, &samplerNode2);
    result = AUGraphAddNode(self.processingGraph, &cd, &samplerNode3);
    
    NSCAssert(result == noErr, @"Unable to add the Sampler unit to the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *) &result);
    
    //Multichannell mixer unit to add
    AudioComponentDescription MixerUnitDescription;
    MixerUnitDescription.componentType = kAudioUnitType_Mixer;
    MixerUnitDescription.componentSubType = kAudioUnitSubType_MultiChannelMixer;
    MixerUnitDescription.componentManufacturer = kAudioUnitManufacturer_Apple;
    
    MixerUnitDescription.componentFlags = 0;
    MixerUnitDescription.componentFlagsMask = 0;
    result = AUGraphAddNode(self.processingGraph, &MixerUnitDescription, &_mixerNode);
    
    if (noErr !=  result) {
        //DebugLog(@"AUGraphNewNode failied for Mixer Unit");
        return NO;
    }
    
    //Specify the Output unit, to be used as the second and final node to the graph
    cd.componentType = kAudioUnitType_Output;
    cd.componentSubType = kAudioUnitSubType_RemoteIO;
    
    //Add the Output unit node to the graph
    result = AUGraphAddNode(self.processingGraph, &cd, &ioNode);
    NSCAssert(result == noErr, @"Unable to add the Output unit to the audio processing graph. Error code: %d, '%.4s'", (int) result, (const char *)&result);
    
    //Open the Graph
    result = AUGraphOpen(self.processingGraph);
    NSCAssert(result == noErr, @"Unable to open the audio processing graph. Error code %d '%.4s'", (int) result, (const char *) &result);
    
    //Connect each AUSampler to a different input bus on the mixer
    AUGraphConnectNodeInput(self.processingGraph, samplerNode1, 0, _mixerNode, 0);
    AUGraphConnectNodeInput(self.processingGraph, samplerNode2, 0, _mixerNode, 1);
    AUGraphConnectNodeInput(self.processingGraph, samplerNode3, 0, _mixerNode, 2);
    AUGraphConnectNodeInput(self.processingGraph, _mixerNode, 0, ioNode, 0);
    
    //save Sampler Units
    result = AUGraphNodeInfo(self.processingGraph, samplerNode1, 0, &_samplerUnit1);
    result = AUGraphNodeInfo(self.processingGraph, samplerNode2, 0, &_samplerUnit2);
    result = AUGraphNodeInfo(self.processingGraph, samplerNode3, 0, &_samplerUnit3);
    NSCAssert(result == noErr, @"Unable to obtain a reference to the Sampler Unit. Error code %d '%.4s'", (int) result, (const char *)&result);
    //save I/O
    result = AUGraphNodeInfo(self.processingGraph, ioNode, 0, &_ioUnit);
    NSCAssert(result == noErr, @"Unable to obtain a reference to the I/O unit. Eror code: %d '%.4s'", (int) result, (const char *)&result);
    
    return YES;
}

- (void) configureAndStartAudioProcessingGraph:(AUGraph)graph {
    
    OSStatus result = noErr;
    UInt32 framesPerSlice = 0;
    UInt32 framesPerSlicePropertySize = sizeof(framesPerSlice);
    UInt32 sampleRatePropertySize = sizeof(self.graphSampleRate);
    
    result = AudioUnitInitialize(self.ioUnit);
    NSCAssert(result == noErr, @"Unable to initialize the I/O unit. Error code: %d '%.4s'", (int) result, (const char *) &result);
    
    //set the I/O unit's output sample rate
    result = AudioUnitSetProperty(self.ioUnit, kAudioUnitProperty_SampleRate, kAudioUnitScope_Output, 0, &_graphSampleRate, sampleRatePropertySize);
    
    //Obtain the value of the max-frames-per-slice form the I/O unit
    result = AudioUnitGetProperty(self.ioUnit, kAudioUnitProperty_MaximumFramesPerSlice, kAudioUnitScope_Global, 0, &framesPerSlice, &framesPerSlicePropertySize);
    NSCAssert(result == noErr, @"Unable to retrieve the maximum frames per slice property from the I/O unit. Error code: %d '%.4s", (int) result, (const char *) &result);
    
    //Set the Sampler unit's output sample rate
    result = AudioUnitSetProperty(self.samplerUnit1, kAudioUnitProperty_SampleRate, kAudioUnitScope_Output, 0, &_graphSampleRate, sampleRatePropertySize);
    result = AudioUnitSetProperty(self.samplerUnit2, kAudioUnitProperty_SampleRate, kAudioUnitScope_Output, 0, &_graphSampleRate, sampleRatePropertySize);
    result = AudioUnitSetProperty(self.samplerUnit3, kAudioUnitProperty_SampleRate, kAudioUnitScope_Output, 0, &_graphSampleRate, sampleRatePropertySize);
    
    NSAssert(result == noErr, @"AudioUnitSetProperty (set Sampler unit output stream sample rate). Error code: %d '%.4s", (int) result, (const char *) &result);
    
    //Set the Sampler unit's maximum frames-per-slice
    result = AudioUnitSetProperty(self.samplerUnit1, kAudioUnitProperty_MaximumFramesPerSlice, kAudioUnitScope_Global, 0, &framesPerSlice, framesPerSlicePropertySize);
    result = AudioUnitSetProperty(self.samplerUnit2, kAudioUnitProperty_MaximumFramesPerSlice, kAudioUnitScope_Global, 0, &framesPerSlice, framesPerSlicePropertySize);
    result = AudioUnitSetProperty(self.samplerUnit3, kAudioUnitProperty_MaximumFramesPerSlice, kAudioUnitScope_Global, 0, &framesPerSlice, framesPerSlicePropertySize);
    
    NSAssert(result == noErr, @"AudioUnitSetProperty (set Sampler unit max frames per slice). Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    if(graph) {
        
        //Initialize the audio processing graph
        result = AUGraphInitialize(graph);
        NSAssert(result == noErr, @"Unable to initialize AUGraph object. Error code: %d '%.4s", (int) result, (const char *)&result);
        
        //Start the Graph
        result = AUGraphStart(graph);
        NSAssert(result == noErr, @"Unable to start audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
        
        //print out the graph to the console
        CAShow(graph);
    }
}

- (IBAction)loadAUPresets:(id)sender {
    
    NSURL *presetURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"rubab1stString" ofType:@"aupreset"]];
    if(presetURL){
        NSLog(@"Attempting to load preset 1 '%@'\n", [presetURL description]);
    }
    else {
        NSLog(@"COULD NOT GET PRESET PATH");
    }
    
    [self loadSamplerFromAUPresetURL:presetURL sampler:_samplerUnit1];
    
    presetURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"rubab2ndString" ofType:@"aupreset"]];
    if(presetURL){
        NSLog(@"Attempting to load preset 2 '%@'\n", [presetURL description]);
    }
    
    else {
        NSLog(@"COULD NOT GET PRESET PATH");
    }
    
    [self loadSamplerFromAUPresetURL:presetURL sampler:_samplerUnit2];

    presetURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"rubab3rdString" ofType:@"aupreset"]];
    if(presetURL){
        NSLog(@"Attempting to load preset 3 '%@'\n", [presetURL description]);
    }
    
    [self loadSamplerFromAUPresetURL:presetURL sampler:_samplerUnit3];
}

- (OSStatus) loadSamplerFromAUPresetURL:(NSURL *)presetURL sampler:(AudioUnit)samplerUnit {
    
    CFDataRef propertyResourceData = 0;
    Boolean status;
    SInt32 errorCode = 0;
    OSStatus result = noErr;
    
    // Read from the URl and convert into a CFData chunk
    status = CFURLCreateDataAndPropertiesFromResource(kCFAllocatorDefault, (__bridge CFURLRef) presetURL, &propertyResourceData, NULL, NULL, &errorCode);
    
    NSAssert (status == YES && propertyResourceData != 0, @"Unable to create data and properties from a preset. Error code: %d '%.4s'", (int) errorCode, (const char * )&errorCode);
    
    //Convert the data object into a property list
    CFPropertyListRef presetPropertyList = 0;
    CFPropertyListFormat dataFormat = 0;
    CFErrorRef errorRef = 0;
    presetPropertyList = CFPropertyListCreateWithData(kCFAllocatorDefault, propertyResourceData, kCFPropertyListImmutable, &dataFormat, &errorRef);
    
    //Set the class info  property for the Sampler unit using the property list as the value
    if (presetPropertyList != 0) {
        result = AudioUnitSetProperty(samplerUnit, kAudioUnitProperty_ClassInfo, kAudioUnitScope_Global, 0, &presetPropertyList, sizeof(CFPropertyListRef));
        CFRelease(presetPropertyList);
    }
    
    if (errorRef) CFRelease(presetPropertyList);
    CFRelease(propertyResourceData);
    
    return result;
}

- (BOOL) setupAudioSession {
    AVAudioSession *mySession = [AVAudioSession sharedInstance];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:<#(SEL)#> name:<#(NSString *)#> object:<#(id)#>]
    NSError *audioSessionError = nil;
    [mySession setCategory:AVAudioSessionCategoryPlayback error:&audioSessionError];
    if(audioSessionError != nil) {NSLog(@"Error setting audio session category."); return NO;}
    
    // Request a desired hardware sample rateL iPhone will go up to 48k but if your source content is 44.1 go with that
    self.graphSampleRate = 44100.0;  //Hertz
    
    [mySession setPreferredSampleRate:self.graphSampleRate error:&audioSessionError];
    if (audioSessionError != nil) {NSLog (@"Error setting prefeered hardware samplpe rate."); return NO;}
    
    Float32 prefferedBufferSize = 0.005;//kLatencyInSeconds;
    // Lower value = less latency but higher CPU usage b/c of audio callback setup/teardown overhead
    // Most people will not notice any signifigant benefit below 5msl Android L cannot even get down to 20 ms
    // Also: iOS touch event handling introduces signifigant latency; straight MIDI controller->CCK->iPad will yield much lower latency
    [mySession setPreferredIOBufferDuration:prefferedBufferSize error:&audioSessionError];
    if (audioSessionError != nil) {NSLog (@"Error setting preffered buffer size. "); return NO;}
    
    [mySession setActive:YES error:&audioSessionError];
    if (audioSessionError != nil) {NSLog (@"Unable to stop the audio processing graph. Error code: %d '%.4s'"); return NO;}
    self.graphSampleRate = [mySession sampleRate];
    return YES;
}

- (void) stopAudioProcessingGraph {
    OSStatus result = noErr;
    if(self.processingGraph) result = AUGraphStart(self.processingGraph);
    NSAssert (result == noErr, @"Unable to stop the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *) &result);
}

- (void) restartAudioProcessingGraph {
    OSStatus result = noErr;
    if (self.processingGraph) result = AUGraphStart(self.processingGraph);
    
}

#pragma mark - Audio session delegate

#pragma mark - Boiler Plate Error Logging

#pragma mark - Public Methods

- (void) playNoteOn:(UInt32)noteNum withVelocity:(UInt32)velocity {
    AudioUnit *sampler = &(_samplerUnit2);
    MusicDeviceMIDIEvent(*sampler, 144, 48, 127, 0);
    NSLog(@"%d", (unsigned int)noteNum);
    
    
}


@end
