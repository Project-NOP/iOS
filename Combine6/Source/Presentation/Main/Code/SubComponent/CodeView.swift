//
//  CodeView.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

enum CodeError: Error {
    case gettingCameraError
}

class CodeView: View<EmptyViewBindable>, AVCaptureMetadataOutputObjectsDelegate {
    let captureSession = AVCaptureSession()
    lazy var videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    let codeFrameView = UIView()
    
    let currentCode = PublishRelay<String>()
    
    override func attribute() {
        codeFrameView.do {
            $0.layer.borderWidth = 5
            $0.layer.borderColor = UIColor.red.cgColor
            $0.backgroundColor = .clear
        }
    }
    
    override func layout() {
        addSubview(codeFrameView)
    }
    
    func initialize() {
        try? setCaptureSessionInputOutput()
        setVideoPreviewLayer()
    }
    
    func start() {
        videoPreviewLayer.frame = self.bounds
        captureSession.startRunning()
        
        bringSubviewToFront(codeFrameView)
    }
    
    func stop() {
        captureSession.stopRunning()
    }
    
    func setCaptureSessionInputOutput() throws {
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: .video, position: .back)
        
        guard let device = session.devices.first else {
            throw CodeError.gettingCameraError
        }
        
        let input = try AVCaptureDeviceInput(device: device)
        captureSession.addInput(input)
        
        let output = AVCaptureMetadataOutput()
        captureSession.addOutput(output)
        
        output.do {
            $0.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            let types = $0.availableMetadataObjectTypes
            $0.metadataObjectTypes = types
        }
    }
    
    func setVideoPreviewLayer() {
        videoPreviewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(videoPreviewLayer)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = (metadataObjects.first) as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        guard let codeObject = videoPreviewLayer.transformedMetadataObject(for: object) else {
            return
        }
        
        codeFrameView.frame = codeObject.bounds
        
        if let code = object.stringValue {
            currentCode.accept(code)
        }
    }
}
