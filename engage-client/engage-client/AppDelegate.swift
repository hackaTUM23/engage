import UIKit
import BackgroundTasks
import UserNotifications

let TIME_TO_SHOW_NOTIFICATION: TimeInterval = 5
let TIME_TO_SCHEDULE_BG_TASK: TimeInterval = 10

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Register background task
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "io.hackaTUM23.engage-client.background", using: nil) { task in
            self.handleBackgroundTask(task: task)
        }

        // Request notification permission
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
                self.setupNotificationActions()
                self.scheduleNotification()
            } else {
                print("Notification permission denied: \(String(describing: error))")
            }
        }
        notificationCenter.delegate = self

        return true
    }

    func handleBackgroundTask(task: BGTask) {
        print("Background task started")
        // Reschedule the background task
        scheduleBackgroundTask()
        task.setTaskCompleted(success: true)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Schedule the background task
        scheduleBackgroundTask()
    }

    func scheduleBackgroundTask() {
        let request = BGAppRefreshTaskRequest(identifier: "io.hackaTUM23.engage-client.background")
        request.earliestBeginDate = Date(timeIntervalSinceNow: TIME_TO_SCHEDULE_BG_TASK )
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Failed to submit background task: \(error)")
        }
    }

    func setupNotificationActions() {
        // Define the custom actions.
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
                                                title: "Yes I'll Attend",
                                                options: [])
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
                                                 title: "I don't want to attend",
                                                 options: [])
        // Define the notification type
        let meetingInviteCategory = UNNotificationCategory(identifier: "MEETING_INVITATION",
                                                           actions: [acceptAction, declineAction],
                                                           intentIdentifiers: [],
                                                           hiddenPreviewsBodyPlaceholder: "",
                                                           options: .customDismissAction)
        // Register the notification type.
        UNUserNotificationCenter.current().setNotificationCategories([meetingInviteCategory])
    }

    func scheduleNotification() {
        print("Schedule Notification")
        let content = UNMutableNotificationContent()
        content.title = "Let's meet!"
        content.body = "What do you think about a meeting at 2pm for a round of chess?"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "MEETING_INVITATION"
        content.userInfo = ["MEETING_ID": "12345", "USER_ID": "67890"]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TIME_TO_SHOW_NOTIFICATION, repeats: false)
        let notificationUUID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationUUID, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }

    // Handle notification actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification received")
        
        let userInfo = response.notification.request.content.userInfo
        if let meetingID = userInfo["MEETING_ID"] as? String, let userID = userInfo["USER_ID"] as? String {
            print("Notification \(response.actionIdentifier) received for meeting \(meetingID) with user \(userID)")
        } else {
            print("Notification \(response.actionIdentifier) received with missing userInfo")
        }

        if response.actionIdentifier == "ACCEPT_ACTION" {
            print("Accept action triggered")
        } else if response.actionIdentifier == "DECLINE_ACTION" {
            print("Decline action triggered")
        }
        completionHandler()
    }

    // Handle notification delivery while app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification will present while app is in foreground")
        completionHandler([.banner, .sound])
    }
}
