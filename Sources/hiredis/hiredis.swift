import CHiRedis
import HiRedisAsync
import Foundation

public class HiRedis {
  // MARK: hiredis wrapper types
  public final class redisAsyncContext {
    private let cContext: UnsafeMutablePointer<HiRedisAsync.redisAsyncContext>
    private init(cContext: UnsafeMutablePointer<HiRedisAsync.redisAsyncContext>) {
      self.cContext = cContext
    }

    deinit {
      redisAsyncFree(cContext)
    }

    /// Error flags, 0 when there is no error
    public var err: Int32 {
      return cContext.pointee.err
    }

    /// String representation of error when applicable
    public var errstr: String? {
      return withUnsafePointer(&cContext.pointee.errstr) { b in
        let str = String(cString:UnsafePointer(b))
        if str == "" {
          return nil
        }
        return str
      }
    }


    //
    // var fd: Int32 {
    //   return cContext.pointee.fd
    // }
    //
    // var flags: Int32 {
    //   return cContext.pointee.flags
    // }
    //
    // /// Write buffer
    // var obuf: UnsafeMutablePointer<CChar> {
    //   return cContext.pointee.obuf
    // }
    //
    // /// Protocol reader
    // var reader: UnsafeMutablePointer<CHiRedis.redisReader> {
    //   return cContext.pointee.reader
    // }
  }
//typedef void (redisCallbackFn)(struct redisAsyncContext*, void*, void*)
  // public final class redisCallback {
  //   // struct redisCallback *next; /* simple singly linked list */
  //   // redisCallbackFn *fn;
  //   // void *privdata;
  //   private let privdata : UnsafeMutablePointer<Void> = nil
  //   private let fn : UnsafeMutablePointer<redisCallbackFn> = nil
  //   private let next: UnsafeMutablePointer<redisCallback> = nil
  //
  //   init (next: next, fn: fn, privdata: privdata) {
  //     self.next = next
  //     self.fn = fn
  //     self.privdata = privdata
  //   }
  //
  // }

  public final class redisContext {
    private let cContext: UnsafeMutablePointer<CHiRedis.redisContext>
    private init(cContext: UnsafeMutablePointer<CHiRedis.redisContext>) {
      self.cContext = cContext
    }

    deinit {
      redisFree(cContext)
    }

    /// Error flags, 0 when there is no error
    public var err: Int32 {
      return cContext.pointee.err
    }

    /// String representation of error when applicable
    public var errstr: String? {
      return withUnsafePointer(&cContext.pointee.errstr) { b in
  	    let str = String(cString:UnsafePointer(b))
      	if str == "" {
      		return nil
      	}
      	return str
      }
    }

    var fd: Int32 {
      return cContext.pointee.fd
    }

    var flags: Int32 {
      return cContext.pointee.flags
    }

    /// Write buffer
    var obuf: UnsafeMutablePointer<CChar> {
      return cContext.pointee.obuf
    }

    /// Protocol reader
    var reader: UnsafeMutablePointer<CHiRedis.redisReader> {
      return cContext.pointee.reader
    }

  //  var connection_type: CHiRedis.redisConnectionType {
  //    return cContext.pointee.connection_type
  //  }

  //  var timeout: UnsafeMutablePointer<CHiRedis.timeval> {
  //    return cContext.pointee.timeout
  //  }
  //
  //  var tcp: tcp {
  //    return cContext.pointee.tcp
  //  }

  //  struct {
  //        char *host;
  //        char *source_addr;
  //        int port;
  //    } tcp;

  //  var unix_sock: unix_sock {
  //    return cContext.pointee.unix_sock
  //  }

  //    struct {
  //        char *path;
  //    } unix_sock;

  }

  public final class redisReply {
    private let cReply: UnsafeMutablePointer<CHiRedis.redisReply>
    private init?(cReply: UnsafeMutablePointer<CHiRedis.redisReply>) {
      guard cReply != nil else {
        return nil
      }
      self.cReply = cReply
    }
    deinit {
      freeReplyObject(cReply)
    }

    /* Used for both REDIS_REPLY_ERROR and REDIS_REPLY_STRING */
    public var str: String {
      return String(cString:cReply.pointee.str)
    }
    /* REDIS_REPLY_* */
    var type: Int32 {
      return cReply.pointee.type
    }
    /* The integer when type is REDIS_REPLY_INTEGER */
    var integer: Int64 {
      return cReply.pointee.integer
    }

    /* elements vector for REDIS_REPLY_ARRAY */
    var element: [redisReply]? {
      guard cReply.pointee.element != nil else { return nil }
      return UnsafeBufferPointer(start: cReply.pointee.element, count: Int(cReply.pointee.elements)).map { creplyptr in
        return redisReply(cReply: creplyptr)!
      }
    }
  //  var len: Swift.Int32
  //  var str: Swift.UnsafeMutablePointer<Swift.Int8>
  ////    int len; /* Length of string */
  ////    char *str;
  }

  public final class redisReader {
    var cReader: UnsafeMutablePointer<CHiRedis.redisReader>
    private init(cReader: UnsafeMutablePointer<CHiRedis.redisReader>) {
      self.cReader = cReader
    }

    deinit {
      redisReaderFree(cReader)
    }
  }

  //extension redisReader {
  //  var err: Swift.Int32
  //  var errstr: String
  //  var buf: Swift.UnsafeMutablePointer<Swift.Int8>
  //  var pos: Swift.Int
  //  var len: Swift.Int
  //  var maxbuf: Swift.Int
  //  var rstack: (CHiRedis.redisReadTask, CHiRedis.redisReadTask, CHiRedis.redisReadTask, CHiRedis.redisReadTask, CHiRedis.redisReadTask, CHiRedis.redisReadTask, CHiRedis.redisReadTask, CHiRedis.redisReadTask, CHiRedis.redisReadTask)
  //  var ridx: Swift.Int32
  //  var reply: Swift.UnsafeMutablePointer<Swift.Void>
  //  var fn: Swift.UnsafeMutablePointer<CHiRedis.redisReplyObjectFunctions>
  //  var privdata: Swift.UnsafeMutablePointer<Swift.Void>
  //typedef struct redisReader {
  //    int err; /* Error flags, 0 when there is no error */
  //    char errstr[128]; /* String representation of error when applicable */
  //
  //    char *buf; /* Read buffer */
  //    size_t pos; /* Buffer cursor */
  //    size_t len; /* Buffer length */
  //    size_t maxbuf; /* Max length of unused buffer */
  //
  //    redisReadTask rstack[9];
  //    int ridx; /* Index of current read task */
  //    void *reply; /* Temporary reply pointer */
  //
  //    redisReplyObjectFunctions *fn;
  //    void *privdata;
  //} redisReader;
  //}

  //struct redisReadTask {
  //  var type: Swift.Int32
  //  var elements: Swift.Int32
  //  var idx: Swift.Int32
  //  var obj: Swift.UnsafeMutablePointer<Swift.Void>
  //  var parent: Swift.UnsafeMutablePointer<CHiRedis.redisReadTask>
  //  var privdata: Swift.UnsafeMutablePointer<Swift.Void>
  //typedef struct redisReadTask {
  //   int type;
  //   int elements; /* number of elements in multibulk container */
  //   int idx; /* index in parent (array) object */
  //   void *obj; /* holds user-generated value for a read task */
  //   struct redisReadTask *parent; /* parent task */
  //   void *privdata; /* user-settable arbitrary field */
  //} redisReadTask;
  //}

  // MARK: hiredis wrapper functions

  public static func redisCommand(context context: redisContext, command: String, args: CVarArg ...) -> redisReply? {
    return withVaList(args) { args in
      redisReply(cReply: UnsafeMutablePointer<CHiRedis.redisReply>(redisvCommand(context.cContext, command, args)))
    }
  }

  public static func redisAsyncCommand(context context: redisAsyncContext, command: String, args: CVarArg ...) {
    withVaList(args) { args in

      let privdata : UnsafeMutablePointer<Void> = nil
      // let redisCallbackFn : (UnsafeMutablePointer<HiRedisAsync.redisAsyncContext>, UnsafeMutablePointer<Void>, UnsafeMutablePointer<Void>) -> Void =

      redisvAsyncCommand(context.cContext, {
        (redisAsyncContext: UnsafeMutablePointer<HiRedisAsync.redisAsyncContext>, reply: UnsafeMutablePointer<Void>, _privdata: UnsafeMutablePointer<Void>) -> Void in
        print("Callback")

        print(reply)
        // print(privdata)
        print(_privdata)
        // handler(message: "Test")

      }, privdata, command, args)
    }
  }

  static var subscriptions : Array<String> = []

    public static func redisSubscribeSync(context context: redisContext, toChannel channel: String, handleWith handler: (message: String) -> (), args: CVarArg ...) {
      withVaList(args) { args in

        let subscribeReply = UnsafeMutablePointer<CHiRedis.redisReply>(redisvCommand(context.cContext, "SUBSCRIBE \(channel)", args))
        freeReplyObject(subscribeReply)

        subscriptions.append(channel)

        var reply : UnsafeMutablePointer<Void> = nil

        while subscriptions.contains(channel) && redisGetReply(context.cContext, &reply) == 0 /*REDIS_OK*/ {
            let response = NSString(string: String(cString:context.reader.pointee.buf))

            let resultParts = response.componentsSeparatedByString("\r\n")
            let message = resultParts[resultParts.count - 2]
            handler(message: message)

            freeReplyObject(reply)
        }

      }
    }


      public static func redisSubscribeAsync(context context: redisAsyncContext, toChannel channel: String, handleWith handler: (message: String) -> (), args: CVarArg ...) {
        withVaList(args) { args in

          let privdata : UnsafeMutablePointer<Void> = nil
          // let redisCallbackFn : (UnsafeMutablePointer<HiRedisAsync.redisAsyncContext>, UnsafeMutablePointer<Void>, UnsafeMutablePointer<Void>) -> Void =

          redisvAsyncCommand(context.cContext, {
            (redisAsyncContext: UnsafeMutablePointer<HiRedisAsync.redisAsyncContext>, reply: UnsafeMutablePointer<Void>, _privdata: UnsafeMutablePointer<Void>) -> Void in
            print("Callback")

            print(reply)
            // print(privdata)
            print(_privdata)
            // handler(message: "Test")

          }, privdata, "SUBSCRIBE \(channel)", args)
        }
      }




      public static func redisPublishSync(context context: redisContext, message: String, toChannel channel: String, args: CVarArg ...) {
        withVaList(args) { args in

          let subscribeReply = UnsafeMutablePointer<CHiRedis.redisReply>(redisvCommand(context.cContext, "PUBLISH \(channel) \(message)", args))
          freeReplyObject(subscribeReply)

        }
      }


      public static func redisPublishAsync(context context: redisAsyncContext, message: String, toChannel channel: String, args: CVarArg ...) {
        withVaList(args) { args in

          let privdata : UnsafeMutablePointer<Void> = nil
          redisvAsyncCommand(context.cContext, {
            (redisAsyncContext: UnsafeMutablePointer<HiRedisAsync.redisAsyncContext>, reply: UnsafeMutablePointer<Void>, privdata: UnsafeMutablePointer<Void>) -> Void in
            print("Callback")

            print(reply)
            print(privdata)
            // handler(message: "Test")

          }, privdata, "PUBLISH \(channel) \(message)", args)

        }
      }


      public static func redisUnsubscribeSync(context context: redisContext, fromChannel channel: String, args: CVarArg ...) {
        withVaList(args) { args in

          let subscribeReply = UnsafeMutablePointer<CHiRedis.redisReply>(redisvCommand(context.cContext, "UNSUBSCRIBE \(channel)", args))
          freeReplyObject(subscribeReply)

          subscriptions = subscriptions.filter {$0 != channel}

        }
      }


      public static func redisUnsubscribeAsync(context context: redisAsyncContext, fromChannel channel: String, args: CVarArg ...) {
        withVaList(args) { args in

          let privdata : UnsafeMutablePointer<Void> = nil
          redisvAsyncCommand(context.cContext, {
            (redisAsyncContext: UnsafeMutablePointer<HiRedisAsync.redisAsyncContext>, reply: UnsafeMutablePointer<Void>, privdata: UnsafeMutablePointer<Void>) -> Void in
            print("Callback")

            print(reply)
            print(privdata)
            // handler(message: "Test")

          }, privdata, "UNSUBSCRIBE \(channel)", args)

        }
      }


  public static func redisCommandWithArguments(context context: redisContext, command: String, args: CVaListPointer) -> redisReply? {
    return redisReply(cReply: UnsafeMutablePointer<CHiRedis.redisReply>(redisvCommand(context.cContext, command, args)))
  }

  public static func connectToRedis(ip ip: String, port: Int) -> redisContext {
    return HiRedis.redisContext(cContext: redisConnect(ip, Int32(port)))
  }

  public static func connectToRedisAsync(ip ip: String, port: Int) -> redisAsyncContext {
    return HiRedis.redisAsyncContext(cContext: redisAsyncConnect(ip, Int32(port)))
  }

}
