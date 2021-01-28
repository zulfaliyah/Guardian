//
//  constant.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 18/01/21.
//

import Foundation

class NasabahProfile: NSObject{
    var nama = String()
    var saldo = String()
    var userID = Int()
    var nomor = String()
    
    init?(dict: [String: Any]){
        guard let nama = dict["fullname"] as? String,
        let saldo = dict["balance"] as? String,
        let userID = dict["id"] as? Int,
        let nomor = dict["phone"] as? String else { return nil }
        
        self.nama = nama
        self.saldo = saldo
        self.userID = userID
        self.nomor = nomor
        
    }
}

class NasabahAdmProfile: NSObject{
    var nama = String()
    var saldo = String()
    var userID = Int()
    var nomor = String()
    
    init?(dict: [String: Any]){
        guard let nama = dict["fullname"] as? String,
        let saldo = dict["balance"] as? String,
        let userID = dict["id"] as? Int,
        let nomor = dict["phone"] as? String else { return nil }
        
        self.nama = nama
        self.saldo = saldo
        self.userID = userID
        self.nomor = nomor
        
    }
}

class TrxProfile: NSObject{
    var userID = Int()
    var trxID = Int()
    init?(dict: [String: Any]){
        guard let userID = dict["user_id"] as? Int,
        let trxID = dict["id"] as? Int else { return nil }
        
        self.userID = userID
        self.trxID = trxID
    }
}

class Scan: NSObject{
    var userID = Int()
    init?(dict: [String: Any]){
        guard let userID = dict["user_id"] as? Int else { return nil }
        self.userID = userID
    }
}

class Pencairan: NSObject{
    var sisa = Int()
    
    init?(dict: [String: Any]){
        guard let sisa = dict["balance"] as? Int else { return nil }
        self.sisa = sisa
    }
}

//class SemuaNasabah: NSObject{
//    var nama = String()
//    var saldo = String()
//    var userID = Int()
//    var nomor = String()
//
//    init?(dict: [String: Any]){
//        guard let nama = dict["fullname"] as? String,
//        let saldo = dict["balance"] as? String,
//        let userID = dict["id"] as? Int,
//        let nomor = dict["phone"] as? String else { return nil }
//
//        self.nama = nama
//        self.saldo = saldo
//        self.userID = userID
//        self.nomor = nomor
//    }
//}

class TotalNasabah: NSObject{
    var nasabah = Int()
    init?(dict: [String: Any]){
        guard let nasabah = dict["count"] as? Int else { return nil }
        self.nasabah = nasabah
    }
}

class TotalSampah: NSObject{
    var sampah = Int()
    init?(dict: [String: Any]){
        guard let sampah = dict["totalQuantity"] as? Int else { return nil }
        self.sampah = sampah
    }
}

//class SetorProfile: NSObject{
//    var jumlah0 = Int()
//    var harga0 = Int()
//    var jumlah1 = Int()
//    var harga1 = Int()
//    var jumlah2 = Int()
//    var harga2 = Int()
//
//    init?(dict: [String: Any]){
//        guard let jumlah0 = dict["0"]["count"] as? String,
//            let harga0 = dict["0"]["depositValue"] as? Int,
//            let jumlah1 = dict["1"]["count"] as? Int,
//            let harga1 = dict["1"]["depositValue"] as? Int,
//            let jumlah2 = dict["0"]["count"] as? Int,
//            let harga2 = dict["1"]["depositValue"] as? Int else { return nil }
//
//        self.nama = nama
//        self.saldo = saldo
//        self.userID = userID
//        self.nomor = nomor
//    }
//}


//class Terminat: NSObject{
//    var trxID = String()
//    var saldo = String()
//    var userID = Int()
//    var nomor = String()
//    
//    init?(dict: [String: Any]){
//        guard let nama = dict["fullname"] as? String,
//        let saldo = dict["balance"] as? String,
//        let userID = dict["id"] as? Int,
//        let nomor = dict["phone"] as? String else { return nil }
//        
//        self.nama = nama
//        self.saldo = saldo
//        self.userID = userID
//        self.nomor = nomor
//    }
//}

//class userID: NSObject{
//    var id = String()
//    init?(dict: [String: Any]){
//        guard let id = dict["id"] as? String else { return nil }
//        self.id = id
//        //self.userID = userID
//    }
//}

//struct Riwayat {
//    var tanggal: String?
//         var botol: String?
//        var uang: String?
//}

//class Riwayat: NSObject{
//    var tanggal = String()
//    var botol = String()
//    var uang = String()
//    init?(dict: [String: Any]){
//        guard let tanggal = dict["created_at"] as? String,
//        let botol = dict["quantity"] as? String,
//        let uang = dict["amount"] as? String else { return nil }
//        self.tanggal = tanggal
//        self.botol = botol
//        self.uang = uang
//    }
//}

//public class Riwayat{
//    var tanggal: String?
//     var botol: String?
//    var uang: String?
//
//    public func tanggal(tanggal: String) -> Riwayat {
//        self.tanggal=tanggal
//        return self
//    }
//
//    public func botol(botol: String) -> Riwayat{
//        self.botol=botol
//        return self
//    }
//
//    public func uang(uang: String) -> Riwayat {
//        self.uang=uang
//        return self
//    }
//
//    public func getTanggal() -> String {
//            return self.tanggal!
//        }
//
//        public func getbotol() -> String {
//            return self.botol!
//        }
//
//        public func getUang() -> String {
//            return self.uang!
//        }
//    public  init(){
//
//    }
//
//
//}
