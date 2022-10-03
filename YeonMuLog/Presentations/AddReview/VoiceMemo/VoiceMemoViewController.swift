//
//  VoiceMemoViewController.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/02.
//

import UIKit
import AVFoundation

class VoiceMemoViewController: BaseViewController {
    // MARK: - Properties
    let mainView = VoiceMemoView()
    
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private lazy var recordURL: URL = {
        var documentsURL: URL = {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths.first!
        }()

        let fileName = UUID().uuidString + ".m4a"
        let url = documentsURL.appendingPathComponent(fileName)
        return url
    }()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getListOfRecordingFiles()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestMicrophoneAccess { [weak self] allowed in
            if allowed {
                // 녹음 권한 허용
                self?.recorderConfigure()
                self?.record()
            } else {
                // 녹음 권한 거부
            }
        }
        
    }
    
    // MARK: - Actions
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    // MARK: - Helpers
    override func configure() {
        mainView.pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        mainView.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        mainView.finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
}
// MARK: - 녹음, 정지, 재생
extension VoiceMemoViewController {
    @objc func record() {
        requestMicrophoneAccess { [weak self] allowed in
            if allowed {
                guard let self = self else { return }
                if let recorder = self.audioRecorder {
                    let audioSession = AVAudioSession.sharedInstance()
                    guard !recorder.isRecording else {
                        print("녹음 중")
                        return
                    }

                    do {
                        try audioSession.setActive(true)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                    print("녹음")
                    recorder.record()
                    
                }
            }
        }
    }
    
    @objc func pauseButtonTapped(_ sender: UIButton) {
        if let recorder = self.audioRecorder {
            print(recorder, recorder.isRecording)
            if recorder.isRecording {
                self.audioRecorder?.stop()
                print("정지")
                self.playPauseToggle()
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setActive(false)
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
        
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        if let recorder = audioRecorder {
            if !recorder.isRecording {
                let audioSession = AVAudioSession.sharedInstance()
                audioPlayer = try? AVAudioPlayer(contentsOf: recorder.url)
                audioPlayer?.volume = audioSession.outputVolume
                audioPlayer?.delegate = self
                audioPlayer?.play()
                print("재생")
                self.playPauseToggle()
            }
        }
        
    }
    
    @objc func finishButtonTapped(_ sender: UIButton) {
        
    }
    private func playPauseToggle() {
        DispatchQueue.main.async {
            self.mainView.playButton.isHidden = !self.mainView.playButton.isHidden
            self.mainView.pauseButton.isHidden = !self.mainView.pauseButton.isHidden
        }
    }
}
// MARK: - Recorder 관련
extension VoiceMemoViewController {
    /// AVAudioRecorder Initialisation
    private func recorderConfigure() {
        let recorderSettings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        audioRecorder = try? AVAudioRecorder(url: recordURL, settings: recorderSettings)
        audioRecorder?.delegate = self
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.prepareToRecord()
    }
    
    /// 저장된 녹음 파일 목록 출력
    private func getListOfRecordingFiles() {
        // 도큐먼트 디렉토리 URL 가져오기
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            // 디렉토리 내 콘텐트(서브폴더 포함) URL 가져오기
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            print(directoryContents)

            // 디렉토리 내 콘텐트 m4a 필터링
            let m4aFiles = directoryContents.filter{ $0.pathExtension == "m4a" }
            print("m4a urls:", m4aFiles)
            let m4aFileNames = m4aFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("m4a list:", m4aFileNames)

        } catch {
            print(error)
        }
    }

    /// 마이크 접근 권한 요청
    private func requestMicrophoneAccess(completion: @escaping (Bool) -> Void) {
        do {
            let recordingSession: AVAudioSession = AVAudioSession.sharedInstance()
            switch recordingSession.recordPermission {
            case .undetermined: // 아직 녹음 권한 요청이 되지 않았을 경우, 사용자에게 권한 요청
                recordingSession.requestRecordPermission({ allowed in
                    completion(allowed)
                })
            case .denied: // 사용자가 녹음 권한 거부, 사용자가 직접 설정 화면에서 권한 허용을 하게끔 유도
                print("[Failure] 녹음 권한이 거부됨")
                let settingAction: UIAlertAction = UIAlertAction(title: "설정하기", style: .default, handler: { _ in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL,
                                                      options: [:],
                                                      completionHandler: nil)
                        }
                    }
                })
                let cancleAction: UIAlertAction = UIAlertAction(title: "취소", style: .cancel)
                self.showAlert(title: "마이크 오류", message: "마이크에 접근할 수 있는 권한이 없습니다.", actions: cancleAction, settingAction)
            case .granted: // 사용자가 녹음 권한 허용
                print("[Success] 녹음권한이 허용됨")
                completion(true)
            @unknown default:
                fatalError("[ERROR] Record Permission is Unknown Default.")
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

// delegate

extension VoiceMemoViewController: AVAudioRecorderDelegate {
    
}

extension VoiceMemoViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            playPauseToggle()
        }
    }
}
