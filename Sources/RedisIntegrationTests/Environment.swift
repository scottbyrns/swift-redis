import hiredis
import Foundation

struct Environment {
  static let Environment = env
  static let IP = env["REDIS_PORT_6379_TCP_ADDR"]!
  static let Port = Int(env["REDIS_PORT_6379_TCP_PORT"]!)!
}

func newContext() -> HiRedis.redisContext {
 return HiRedis.connectToRedis(ip: Environment.IP, port: Environment.Port)
}

private let env = NSProcessInfo.processInfo().environment
