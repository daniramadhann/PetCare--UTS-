
// ignore_for_file: unnecessary_this

class Ownerdata{
    int? id;
    String? ownerName;
    String? phoneNum;
    String? petName;
    String? address;
    String? services;
    
    Ownerdata({this.id, this.ownerName, this.phoneNum, this.petName, this.address, this.services});
    
    Map<String, dynamic> toMap() {
        var map = Map<String, dynamic>();
    
        if (id != null) {
          map['id'] = id;
        }
        map['ownerName'] = ownerName;
        map['phoneNum'] = phoneNum;
        map['petName'] = petName;
        map['address'] = address;
        map['services'] = services;
        
        return map;
    }
    
    Ownerdata.fromMap(Map<String, dynamic> map) {
        this.id = map['id'];
        this.ownerName = map['ownerName'];
        this.phoneNum = map['phoneNum'];
        this.petName = map['petName'];
        this.address = map['address'];
        this.services = map['services'];
    }
}