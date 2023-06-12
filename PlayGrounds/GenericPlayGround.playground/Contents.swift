import Foundation
class Container<CType>{
    
    private var cSize : Int? = nil
    private var cContainer : [CType] = []
    private var cDict : [NSObject : [Int]] = [:]
    private var oldestDataIndex = 0
    
    init(){
        print("container created without size")
    }
    
    init(size : Int){
        cSize = size
        print("container created with size = \(size)")
        print(type(of: self))
    }
    
    public func getAllElements()->[CType]{
        return cContainer
    }
    
    public func getElement(at index : Int)->CType?{
        if(index < cContainer.count){
            return cContainer[index]
        }
        return nil
    }
    
    public func insertElement(value : CType){
        if let size = cSize{
            if(cContainer.count < size){
                appendNewValue(value: value, at: nil)
            }
            else{
                showWarningText(msg: "no space for new data, so oldest one is deleted, new one will be added")
                appendNewValue(value: value, at: oldestDataIndex)
                oldestDataIndex += 1
                oldestDataIndex %= size
            }
        }
        else{
            appendNewValue(value: value, at: nil)
        }
    }
    
    public func searchInContainer(for value : CType)->[Int]?{
        if let key = value as? NSObject{
            if let indexList = cDict[key]{
                return indexList
            }
            showWarningText(msg: "No such value in container!")
        }
        else{
            showWarningText(msg: "failed to search given value!")
        }
        return nil
    }
    
    private func appendNewValue(value : CType, at index : Int?){
        guard let key = value as? NSObject else{
            showWarningText(msg: "failed to add new value!")
            return
        }
        var dictValue = -1
        if let idx = index{
            guard let oldKey = cContainer[idx] as? NSObject else{
                print("old value can't be removed and failed to add new value!")
                return
            }
            removeOldestEntry(for: oldKey)
            cContainer[idx] = value
            dictValue = idx
        }
        else{
            cContainer.append(value)
            dictValue = cContainer.count - 1
        }
        addToDict(for: key, value: dictValue)
    }
    
    private func showWarningText(msg : String){
        print("E: " + msg)
    }
    
    private func removeOldestEntry(for key : NSObject){
        print("remove oldes for : \(key)")
        if let valueList = cDict[key]{
            var values = valueList
            if(valueList.count < 2){
                cDict[key] = nil
            }
            else{
                values.removeFirst()
                cDict[key] = values
            }
        }
    }
    
    private func addToDict(for key : NSObject, value : Int){
        if(cDict[key] == nil){
            cDict[key] = [value]
        }
        else{
            var oldValues = cDict[key]
            oldValues?.append(value)
            cDict[key] = oldValues
            showWarningText(msg: "Duplicate entry found!")
        }
        
    }
}

let container = Container<String>(size: 2)
container.insertElement(value: "A")
print(container.getAllElements())
container.insertElement(value: "B")
print(container.getAllElements())
container.insertElement(value: "C")
print(container.getAllElements())
container.insertElement(value: "D")
print(container.getAllElements())
container.insertElement(value: "E")
print(container.getAllElements())
print(type(of: container.getAllElements()[0]))
print(container.searchInContainer(for: "A") ?? "Nil")

var s = "dc kk"
print(s.components(separatedBy: " "))
var st = "10"
print(Int(st))
var dct = [String:String]()
dct ["a"] = "1"
dct["c"] = "3"
dct["b"] = "2"
let sort = dct.sorted(by: {$0.1 < $1.1})
print(sort)
for (key, value )in dct{
    print(key)
}

