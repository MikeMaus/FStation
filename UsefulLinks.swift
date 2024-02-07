//
//  UsefulLinks.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 23/04/2021.
//

// https://itnext.io/format-phone-numbers-entirely-in-swiftui-9456f52990a1

// Speech recognition:
// https://developer.apple.com/documentation/speech/asking_permission_to_use_speech_recognition

// The Science of Sound:
// https://www.apple.com/sound/

// Getting the Sound Volume
// You can look for query "making tuner app iOS"
// Queries:
// - how to measure audio volume swift
// - using avaudioengine together with AVAudioRecorder
// - microphone input visualizer swift
// - wave animation swiftUI
//
// AVAudioRecorder
// https://developer.apple.com/documentation/avfaudio/avaudiorecorder <- look for metering (audio metering)
//
// Monitoring Audio Input on iPhone Without Recording it?
// https://stackoverflow.com/a/28195669/11419259
//
// Continuous speech recogn. with SFSpeechRecognizer
// https://stackoverflow.com/questions/37821826/continuous-speech-recogn-with-sfspeechrecognizer-ios10-beta
// https://stackoverflow.com/a/40460420/11419259 <- Here is the answer!
// https://stackoverflow.com/a/62062502/11419259 <- This is also interesting
// -------TOP--------
// https://stackoverflow.com/a/68086137/11419259 <- Apple on Device Recognition, this is the solution!!!
// https://developer.apple.com/documentation/speech/sfspeechrecognitionrequest/3152603-requiresondevicerecognition <- more about requiresOnDeviceRecognition

//
// AVCaptureSession ? | An object that manages capture activity and coordinates the flow of data from input devices to capture outputs.
// https://developer.apple.com/documentation/avfoundation/avcapturesession
//
//
// Read about PCM, Pulse-code modulation | https://en.wikipedia.org/wiki/Pulse-code_modulation
// https://developer.apple.com/documentation/avfaudio/avaudiopcmbuffer/1386212-floatchanneldata
// https://developer.apple.com/documentation/avfaudio/avaudiopcmbuffer
//
// https://madtealab.com/?V=1&C=7&F=5&G=1&O=1&W=685&GW=631&GX=0.47154764619588563&GY=0.4112919503908122&GS=6.9548657083441885&GSY=0.2&EH=215&a=0.1&aMa=0.5&aN=Decay&b=0.2&bN=Noise&c=440&cMi=50&cMa=1000&cN=Freq&d=0.01&dN=envAtk&l=0.09&lN=envDec&m=0.06111111111111111&mN=slowFilter&n=4900&nMa=44100&nI=1&nN=sampleRate&f1=tri%28-x%2A10-0.2%29&f1N=Dec&f2=Dec%28x%29%20%2A%20sin%28x%2Api%2A2%2AFreq%29%20%2A%20%281%20-%20Noise%29&f2N=testAudio&f3=aToF%28outEnvelope%2Clinear%2C0%2C1%29%28x%29&f4=aToF%28outEnvelopeSlow%2Clinear%2C0%2C1%29%28x%29&f5=marker%28x%2CfirstEvent%29&Expr=var%20samples%20%3D%20sample%28testAudio%2C%5B0%2C1%2CsampleRate%5D%29%0Avar%20envelopeState%20%3D%200%0Avar%20envelopeStateSlow%20%3D%200%0Avar%20envConstantAtk%20%3D%201%20-%20exp%28-2%2F%28envAtk%2AsampleRate%29%29%20%0Avar%20envConstantDec%20%3D%201%20-%20exp%28-2%2F%28envDec%2AsampleRate%29%29%20%0Avar%20slowFilterConstant%20%3D%201%20-%20exp%28-2%2F%28slowFilter%2AsampleRate%29%29%20%0A%0AoutEnvelope%20%3D%20%5B%5D%0AoutEnvelopeSlow%20%3D%20%5B%5D%0AfirstEvent%20%3D%20-1%0A%0Afor%28var%20i%20%3D%200%3B%20i%20%3C%20samples.length%3B%20i%2B%2B%29%20%7B%0A%20%20var%20rectified%20%3D%20abs%28samples%5Bi%5D%29%0A%20%20if%28envelopeState%20%3C%20rectified%29%20%7B%0A%20%20%20%20envelopeState%20%2B%3D%20envConstantAtk%20%2A%20%28rectified%20-%20envelopeState%29%0A%20%20%7D%20else%20%7B%0A%20%20%20%20envelopeState%20%2B%3D%20envConstantDec%20%2A%20%28rectified%20-%20envelopeState%29%0A%20%20%7D%0A%0A%20%20envelopeStateSlow%20%2B%3D%20slowFilterConstant%20%2A%20%28envelopeState%20-%20envelopeStateSlow%29%0A%0A%20%20if%28i%20%21%3D%200%20%26%26%20firstEvent%20%3D%3D%20-1%20%26%26%20%0A%20%20%20%20%20envelopeStateSlow%20%3C%20envelopeState%20%26%26%0A%20%20%20%20%20outEnvelope%5BoutEnvelope.length-1%5D%20%3C%20outEnvelopeSlow%5BoutEnvelopeSlow.length-1%5D%0A%29%20%7B%0A%20%20%20%20%20firstEvent%20%3D%20i%20%2F%20sampleRate%0A%20%20%7D%0A%0A%20%20outEnvelope.push%28envelopeState%29%0A%20%20outEnvelopeSlow.push%28envelopeStateSlow%29%0A%0A%7D%0A%0A

//
