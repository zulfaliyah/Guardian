//
//  AppDelegate.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 05/01/21.
//

import UIKit
import CoreData
import Moscapsule
import SwiftyJSON

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var user_id = Int()
    var trx_id = Int()
    
    var machine_id = String()
    var setor_id = Int()
    
    var nasabah_id = Int()
    
    var jumlah0 = String()
    var harga0 = String()
    var jumlah1 = String()
    var harga1 = String()
    var jumlah2 = String()
    var harga2 = String()
    
    var sessionCanceled = Bool()
    var sessionTerminate = Bool()
    
    var TotalHarga = Int()
    
    var mqttClient: MQTTClient? = nil
    var hasAlreadyLaunched :Bool!

    
    func StartMQTT() -> Void {
     
            moscapsule_init()
     
            //set MQTT client configuration
            let RandomId : String = "zulfachu"
            let mqttConfig = MQTTConfig(clientId: RandomId, host: "test.mosquitto.org", port: 1883, keepAlive: 60)
            mqttConfig.mqttAuthOpts = MQTTAuthOpts(username: "", password: "")
            mqttConfig.onPublishCallback = { messageId in
                print("published (msg id=\(messageId)))")
            }
     
            
    // Receive published message here
        mqttConfig.onMessageCallback = { [self] mqttMessage in
               print("MQTT Message received: payload=\(mqttMessage.payloadString ?? "no value")")
                let receivedMessage = mqttMessage.payloadString!
                let receivedTopic = mqttMessage.topic
                print("Topic : \(receivedTopic)")
                print(receivedMessage)
                let data = receivedMessage.data(using: .utf8, allowLossyConversion: false)!
                print("xxxxxxx = \(data)")
                
                let decryptedJsonStr = JSON.init(parseJSON: mqttMessage.payloadString ?? "no value")
            
                machine_id = decryptedJsonStr["machineID"].stringValue
                setor_id = decryptedJsonStr["trxID"].intValue
                print(setor_id)
                sessionTerminate = decryptedJsonStr["sessionTerminate"].boolValue
                //print("mesin: \(machine_id)")
                sessionCanceled = decryptedJsonStr["sessionCanceled"].boolValue
                //print("mesin: \(machine_id)")
                if sessionCanceled || sessionTerminate{
                    mqttClient?.disconnect()
//                    alert.alertHome(alert.alertHome())
//                    let alert  = UIAlertController(title: "gfg", message: "hhgjh", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
//                    let window = UIWindow(frame: UIScreen.main.bounds)
//                    DispatchQueue.main.async {
//                        window.rootViewController = SetorDetailViewController()
//                        window.makeKeyAndVisible()
//
//                        window.rootViewController?.present(alert, animated: true, completion:nil)
//                      }
                }
//
                
            }
     
            mqttConfig.onSubscribeCallback = { (messageId, grantedQos) in
                print("MQTT subscribed (mid=\(messageId),grantedQos=\(grantedQos))")
            }
     
            mqttConfig.onPublishCallback = { messageId in
                NSLog("published (mid=\(messageId))")
            }
     
    // Connecting to Mqtt server
            mqttClient = MQTT.newConnection(mqttConfig, connectImmediately: true)
        if ((mqttClient?.isConnected) != nil) {
                subscribeToTopic()
            }
    }
     
    //Subscribing to Topics
        func subscribeToTopic() -> Void {
     
            let Topic :String = "guardian-machine-1/#"
            print("subsc: ")
            mqttClient?.subscribe(Topic, qos: 2)
            print(Topic)
     
        }

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //StartMQTT()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Guardian")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

