// swift-tools-version:5.9
import PackageDescription

var prefix: String = ""
#if (arch(x86_64))
prefix = "/usr/local"
#else
prefix = "/opt/homebrew"
#endif

let cxxSettings: [CXXSetting] = [
    .unsafeFlags(
        [
            "-I\(prefix)/opt/qt@6/lib/QtCore.framework/Headers",
            "-I\(prefix)/opt/qt@6/lib/QtGui.framework/Headers",
            "-I\(prefix)/opt/qt@6/lib/QtWidgets.framework/Headers",
            "-I\(prefix)/opt/qt@6/include"
        ],
        .when(platforms: [.macOS])
    ),
    .unsafeFlags(
        [
            "-IC:\\Qt\\6.4.3\\msvc2019_64\\include\\QtCore",
            "-IC:\\Qt\\6.4.3\\msvc2019_64\\include\\QtGui",
            "-IC:\\Qt\\6.4.3\\msvc2019_64\\include\\QtWidgets",
            "-IC:\\Qt\\6.4.3\\msvc2019_64\\include"
        ],
        .when(platforms: [.windows])
    )
]

let linkerSettings: [LinkerSetting] = [
    .unsafeFlags([
            "\(prefix)/opt/qt@6/lib/QtCore.framework/QtCore",
            "\(prefix)/opt/qt@6/lib/QtGui.framework/QtGui",
            "\(prefix)/opt/qt@6/lib/QtWidgets.framework/QtWidgets",
        ],
        .when(platforms: [.macOS])
    ),
    .unsafeFlags([
            "C:\\Qt\\6.4.3\\msvc2019_64\\lib\\Qt6Core.lib",
            "C:\\Qt\\6.4.3\\msvc2019_64\\lib\\Qt6Gui.lib",
            "C:\\Qt\\6.4.3\\msvc2019_64\\lib\\Qt6Widgets.lib",
        ],
        .when(platforms: [.windows])
    )
]

let package = Package(
    name: "Qlift",
    products: [
        .executable(name: "qlift-uic", targets: ["qlift-uic"]),
        .library(name: "Qlift", targets: ["Qlift"]),
    ],
    targets: [
        .target(name: "Qlift",
            cxxSettings: cxxSettings,
            swiftSettings: [.interoperabilityMode(.Cxx)],
            linkerSettings: linkerSettings
        ),
        .executableTarget(name: "qlift-uic")
    ],
    cxxLanguageStandard: .cxx17
)
