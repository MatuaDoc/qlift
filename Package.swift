// swift-tools-version:5.8
import PackageDescription

var prefix: String = ""
#if (arch(x86_64))
prefix = "/usr/local"
#else
prefix = "/opt/homebrew"
#endif

let cxxSettings: [CXXSetting] = [
    .unsafeFlags([
            "-I\(prefix)/opt/qt@6/lib/QtCore.framework/Headers",
            "-I\(prefix)/opt/qt@6/lib/QtGui.framework/Headers",
            "-I\(prefix)/opt/qt@6/lib/QtWidgets.framework/Headers",
            "-I\(prefix)/opt/qt@6/include"
        ],
        .when(platforms: [.macOS])
    )
]

let linkerSettings: [LinkerSetting] = [
    .unsafeFlags([
            "\(prefix)/opt/qt@6/lib/QtCore.framework/QtCore",
            "\(prefix)/opt/qt@6/lib/QtGui.framework/QtGui",
            "\(prefix)/opt/qt@6/lib/QtWidgets.framework/QtWidgets",
        ],
        .when(platforms: [.macOS])
    )
]

let package = Package(
    name: "Qlift",
    products: [
        .executable(name: "qlift-uic", targets: ["qlift-uic"]),
        .library(name: "Qlift", targets: ["Qlift"]),
    ],
    targets: [
        .target(name: "Qlift", dependencies: ["CQlift"],
            cxxSettings: cxxSettings,
            linkerSettings: linkerSettings
        ),
        .target(name: "CQlift", dependencies: ["CQt6Widgets"],
            cxxSettings: cxxSettings,
            linkerSettings: linkerSettings
        ),
        .systemLibrary(name: "CQt6Widgets", pkgConfig: "Qt6Widgets"),
        .executableTarget(name: "qlift-uic")
    ],
    cxxLanguageStandard: .cxx17
)
