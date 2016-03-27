import PackageDescription

let package = Package(
    name: "SwiftRedis",
    targets: [
      Target(
        name: "RedisIntegrationTests",
        dependencies: [.Target(name: "hiredis"), .Target(name: "Redis")]
      ),
      Target(
        name: "Redis",
        dependencies: [.Target(name: "hiredis")]
      ),
      Target(name: "hiredis"),
      Target(name: "HiRedisAsync"),
    ],
    dependencies: [
        .Package(url: "https://github.com/scottbyrns/CHiRedis.git", majorVersion: 2),
    ]
)
