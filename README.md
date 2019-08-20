# License Manager

*Generate and validate license keys.*

## Note

This was originally written while [DropPy](https://github.com/geberl/swift-droppy) was a commercial app and [Fastspring](https://fastspring.com/) was used to purchase licenses.

Now the app open source, so I don't need this any more. Feel free to use, probably generate your own DSA keys though.

## Generating DSA keys

Info:

- OpenSSL is already installed on macOS
- These are 512bit DSA keys

Ran the following commands in this order:

- `openssl dsaparam -out dsaparam.pem 512`
- `openssl gendsa -out privkey.pem dsaparam.pem`
- `openssl dsa -in privkey.pem -pubout -out pubkey.pem`

Documentation:

- [https://github.com/glebd/cocoafob/readme.md]()
- Section "Generating Keys"

Came out with those three files:

- dsaparam.pem
- privkey.pem
- pubkey.pem

## CocoaFob

### Version

- Cloned the repo at [https://github.com/glebd/cocoafob]() on 2017-09-20
- Not very active, the last commit was 2 years ago
- Used the files from there (subfolder "swift3/CocoaFob")
- A zip of the repo at that point in time is stored in "Resources"

### cocoafob-keygen

- I could not get this to run on my machine (macOS 10.12, Xcode 9)
- So I built my own version
