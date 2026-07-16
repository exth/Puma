import Foundation
import Combine


@Observable
final class VerificationCodeViewModel {
    let email: String

    private(set) var secondsRemaining: Int
    private(set) var isResending = false
    var resendError: String?

    private var countdownTimer: Timer?
    private var verificationCancellable: AnyCancellable?
    private let totalSeconds = 60

    private let authService: AuthServiceProtocol
    private let session: SessionManager

    init(email: String, authService: AuthServiceProtocol, session: SessionManager) {
        self.email = email
        self.authService = authService
        self.session = session
        self.secondsRemaining = totalSeconds
        startCountdown()
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
        countdownTimer?.invalidate() 
        verificationCancellable?.cancel()
    }


    func resendLinkTapped() {
        guard !isResending else { return }

        Task {
            isResending = true
            resendError = nil

            do {
                try await authService.resendVerificationEmail()
                startCountdown()
            } catch {
                resendError = (error as NSError).firebaseAuthErrorMessage
            }

            isResending = false
        }
    }

    func startCheckingVerification() {
        checkVerificationNow()

        verificationCancellable = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.checkVerificationNow()
            }
    }

    func stopCheckingVerification() {
        verificationCancellable?.cancel()
        verificationCancellable = nil
    }

    func checkVerificationNow() {
        Task {
            let isVerified = (try? await authService.reloadCurrentUser()) ?? false
            if isVerified {
                stopCheckingVerification()
                session.completeAuthentication()
            }
        }
    }

    private func startCountdown() {
        countdownTimer?.invalidate()
        secondsRemaining = totalSeconds

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick() 
        }
    }

    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }

    private func tick() {
        guard secondsRemaining > 0 else {
            stopCountdown()
            return
        }

        secondsRemaining -= 1

        if secondsRemaining == 0 {
            stopCountdown()
        }
    }
}
