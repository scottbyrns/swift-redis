import hiredis

public class PubSub {


	var redis : Redis

	public init (redis : Redis) {
		self.redis = redis
	}

	public func subscribeSync(toChannel channel : String, handleWith callback : (message: String) -> ()) {
		HiRedis.redisSubscribeSync(context: redis.context, toChannel: channel, handleWith: callback)
	}


	public func subscribeAsync(toChannel channel : String, handleWith callback : (message: String) -> ()) {
		HiRedis.redisSubscribeAsync(context: redis.asyncContext, toChannel: channel, handleWith: callback)
	}

	public func unsubscribeSync(channel : String) {
		HiRedis.redisUnsubscribeSync(context: redis.context, fromChannel: channel)
	}

	public func unsubscribeAsync(channel : String) {
		HiRedis.redisUnsubscribeAsync(context: redis.asyncContext, fromChannel: channel)
	}

	public func publishSync(message message: String, toChannel channel : String) {
		HiRedis.redisPublishSync(context: redis.context, message: message, toChannel: channel)
	}

	public func publishAsync(message message: String, toChannel channel : String) {
		HiRedis.redisPublishAsync(context: redis.asyncContext, message: message, toChannel: channel)
	}

}
