import Foundation

extension RawRepresentable where RawValue: NSCoding {

    /// Encodes `self` using a given archiver.
    public func encode(with coder: NSCoder) {
        rawValue.encodeWithCoder(coder)
    }

    /// Creates an instance from from data in a given unarchiver.
    public init?(coder: NSCoder) {
        guard let raw = RawValue(coder: coder) else { return nil }
        self.init(rawValue: raw)
    }

}

extension RawRepresentable where RawValue: ValueCodable {

    /// Encodes `self` using a given archiver.
    public func encode(with coder: NSCoder) {
        coder.encodeValue(rawValue)
    }

    /// Creates an instance from from data in a given unarchiver.
    public init?(coder: NSCoder) {
        guard let raw = coder.decodeValue(ofType: RawValue.self) else { return nil }
        self.init(rawValue: raw)
    }
    
}

extension RawRepresentable where RawValue: SignedIntegerType {

    /// Encodes `self` using a given archiver.
    public func encode(with coder: NSCoder) {
        coder.encodeInt64(numericCast(rawValue), forKey: NSKeyedArchiveRootObjectKey)
    }

    /// Creates an instance from from data in a given unarchiver.
    public init?(coder: NSCoder) {
        self.init(rawValue: numericCast(coder.decodeInt64ForKey(NSKeyedArchiveRootObjectKey)))
    }
    
}

extension RawRepresentable where RawValue == String {

    /// Encodes `self` using a given archiver.
    public func encode(with coder: NSCoder) {
        coder.encodeValue(rawValue)
    }

    /// Creates an instance from from data in a given unarchiver.
    public init?(coder: NSCoder) {
        guard let raw = coder.decodeValue(ofType: RawValue.self) else { return nil }
        self.init(rawValue: raw)
    }
    
}
