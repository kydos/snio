import XCTest
@testable import Snio

class SnioTests: XCTestCase {
    let buf = ByteBuffer(1024)
    let byteValue: UInt8 = 0x3e
    let N = 10000
   
    func testByte() {
        buf.clear()
        do {
            try self.buf.put(byte: self.byteValue)
            buf.flip()
            XCTAssertEqual(try self.buf.getByte(), self.byteValue)
            
        } catch ByteBufferError.OverFlow {
            XCTAssert(false, "TestByte failed with overflow ")
        } catch  ByteBufferError.Underflow {
            XCTAssert(false, "TestByte failed with underflow ")
        }
        catch  _ {
            XCTAssert(false, "TestByte failed")
        }
    }
    
    func testVle() {

        for _ in 0...N {
            buf.clear()
            let v = arc4random_uniform(UInt32.max)
        
            do {
                
                try self.buf.put(vle: UInt(v))
                buf.flip()
                XCTAssertEqual(try self.buf.getVle(), UInt(v))
                
            } catch ByteBufferError.OverFlow {
                XCTAssert(false, "TestByte failed with overflow ")
            } catch  ByteBufferError.Underflow {
                XCTAssert(false, "TestByte failed with underflow ")
            }
            catch  _ {
                XCTAssert(false, "TestByte failed")
            }
        }
    }
    

    static var allTests = [
        ("testByte", testByte),
        ("testVle", testVle)
    ]
}
