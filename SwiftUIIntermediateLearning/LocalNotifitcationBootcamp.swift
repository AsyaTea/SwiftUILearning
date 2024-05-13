//
//  LocalNotifitcationBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 08/05/2024.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager() //Singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This was soooooo easy!"
        content.sound = .default
        content.badge = 1
        
        //3 type of triggers -> Time, Calendar, Location
        
        //Time
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //Calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 16
//        dateComponents.minute = 11
//        dateComponents.weekday = 1
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //Location
        let coordinates = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        let region = CLCircularRegion(center: coordinates, radius: 100, identifier: UUID().uuidString)
        region.notifyOnExit = false
        region.notifyOnEntry = true
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        let request =  UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)


        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotifitcationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotifications()
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().setBadgeCount(0)
        }
    }
}

#Preview {
    LocalNotifitcationBootcamp()
}
