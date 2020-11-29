# JSONER
Can convert Package.swift, Cartfile and Podfile to **json**.

### Installaion
```
make
```

### Usage
```
jsoner -h
jsoner --package-swift <PATH_TO_PACKAGE_SWIFT>
jsoner --cartfile <PATH_TO_CARTFILE>
jsoner --podfile <PATH_TO_PODFILE>
```

### How it works?
##### Podfile
For Podfile converting it uses `pod ipc` command with is built into cocaapods cli (`pod` command)

##### Cartfile
For Cartfile converting it uses code from [Carthage repo](https://github.com/Carthage/Carthage)

##### Package.swift
For Package.swift converting it uses code from [SPM repo](https://github.com/apple/swift-package-manager). When installing, it creates `.jsoner` directory under your home directory. In that directory you can find executable SwiftPackage, which contains code to actually **run** code from `Package.swift`. When you call `jsoner` with `--package-swift <PATH>` option, it copies code from `<PATH>` into `main.swift` and just `swift run` it
