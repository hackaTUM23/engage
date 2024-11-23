import UIKit
import BackgroundTasks
import UserNotifications
import HealthKit



class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    let healthStore = HKHealthStore()
    let STEPS_DAYS = 3
    let STEPS_THRESHOLD = 1000
    let TIME_TO_SHOW_NOTIFICATION: TimeInterval = 5
    let TIME_TO_SCHEDULE_BG_TASK: TimeInterval = 10
    
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

        // Request HealthKit permission
        requestHealthKitPermission()

        return true
    }

    func handleBackgroundTask(task: BGTask) {
        print("Background task started")
        // Check step count
        checkStepCount { isUnderThreshold in
            if isUnderThreshold {
                print("Steps are under the threshold")
                // TODO: Send notification
            } else {
                print("Steps are above the threshold")
            }
        }

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
        request.earliestBeginDate = Date(timeIntervalSinceNow: TIME_TO_SCHEDULE_BG_TASK ) // 15 minutes
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

    func checkScreenTime() -> Bool {
        // TODO: Call screentime check
        true
    }

    // Handle notification actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification received")
        // Check step count when notification is received for debugging purposes
        checkStepCount { isUnderThreshold in
            if isUnderThreshold {
                print("Steps are under the threshold")
                // TODO: Send notification
            } else {
                print("Steps are above the threshold")
            }
        }
        
        let userInfo = response.notification.request.content.userInfo
        if let meetingID = userInfo["MEETING_ID"] as? String, let userID = userInfo["USER_ID"] as? String {
            print("Notification \(response.actionIdentifier) received for meeting \(meetingID) with user \(userID)")
        } else {
            print("Notification \(response.actionIdentifier) received with missing userInfo")
        }

        NotificationCenter.default.post(name: NSNotification.Name("ShowAcceptEventModal"), object: nil)

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

    // Request HealthKit permission
    func requestHealthKitPermission() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let typesToRead: Set = [stepType]

        healthStore.requestAuthorization(toShare: [], read: typesToRead) { success, error in
            if success {
                print("HealthKit authorization granted")
            } else {
                print("HealthKit authorization denied: \(String(describing: error))")
            }
        }
    }

    // Check step count for the last x days
    func getTotalSteps(forPast days: Int, completion: @escaping (Double) -> Void) {
        guard let stepsQuantityType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            print("Unable to create a step count type")
            completion(0.0)
            return
        }

        let now = Date()
        let startDate = Calendar.current.date(byAdding: DateComponents(day: -days), to: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        healthStore.execute(query)
    }

    func checkStepCount(completion: @escaping (Bool) -> Void) {
        getTotalSteps(forPast: STEPS_DAYS) { totalSteps in
            print("Total steps in last \(self.STEPS_DAYS) days: \(totalSteps)")
            completion(totalSteps < Double(self.STEPS_THRESHOLD))
        }
    }
}
