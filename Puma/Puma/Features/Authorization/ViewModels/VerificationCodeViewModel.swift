import Foundation


@Observable
final class VerificationCodeViewModel {
    let email: String
    
    private(set) var secondsRemaining: Int
    
    private var timer: Timer?
    private let totalSeconds = 1
    
    init(email: String) {
        self.email = email
        self.secondsRemaining = totalSeconds
        startTimer()
    }
    
    var isTimerFinished: Bool {
        secondsRemaining <= 0
    }
    
    var formattedTime: String {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    
    func resendLinkTapped() {
        // MARK: - обновить, когда появится сервис - отправить запрос на повторную отправку письма
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        secondsRemaining = totalSeconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func tick() {
        guard secondsRemaining > 0 else {
            stopTimer()
            return
        }
        
        secondsRemaining -= 1
        
        if secondsRemaining == 0 {
            stopTimer()
        }
    }
}
