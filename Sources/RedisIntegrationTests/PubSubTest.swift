import Redis
import XCTest
import Foundation

final class PubSubTest: XCTestCase {

  let context: Redis = Redis(host: Environment.IP, port: Environment.Port)

  func testThatWeCanSubscribe() {
    let pubsub = PubSub(redis: context)

    pubsub.subscribeSync(toChannel: "testThatWeCanSubscribe") { message in
      print("Message Recieved")
      print(message)
      pubsub.unsubscribeSync("testThatWeCanSubscribe")
      XCTAssertEqual("asdf", message)
    }
  }


  func testThatWeCanSubscribeAsync() {
    let pubsub = PubSub(redis: context)


    //
    // pubsub.subscribeAsync(toChannel: "testThatWeCanSubscribeAsync") { message in
    //   print("Message Recieved")
    //   print(message)
    //   pubsub.unsubscribeSync("testThatWeCanSubscribeAsync")
    //   XCTAssertEqual("asdf", message)
    // }
    // let timer = NSTimer.scheduledTimer(1000.0, repeats: true) { timer in
      pubsub.subscribeAsync(toChannel: "testThatWeCanSubscribeAsync") { message in
        print("Message Recieved")
        print(message)
        // pubsub.unsubscribeSync("testThatWeCanSubscribeAsync")
        XCTAssertEqual("asdf", message)
      }


    pubsub.publishAsync(message:"Bob was here", toChannel: "testThatWeCanSubscribeAsync")
    //
    // let runLoop = NSRunLoop.currentRunLoop()
    // runLoop.addTimer(timer, forMode: NSDefaultRunLoopMode)
    // runLoop.runUntilDate(NSDate(timeIntervalSinceNow: NSDate().timeIntervalSince1970))

  }



  func testThatWeCanSendMessages() {
    let pubsub = PubSub(redis: context)

    pubsub.publishSync(message:"Test", toChannel: "testThatWeCanSendMessages")

  }
  static var allTests: [(String, PubSubTest -> () throws -> Void)] {
    return [
      ("testThatWeCanSubscribeAsync", testThatWeCanSubscribeAsync),
      ("testThatWeCanSubscribe", testThatWeCanSubscribe),
      ("testThatWeCanSendMessages", testThatWeCanSendMessages)
    ]
  }
}
