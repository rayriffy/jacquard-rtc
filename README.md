Jacquard RTC
===

Real-time communication application form Google Jacquard tag to macOS

![](./images/demo.gif)

Abstract
---

Want to use your Google Jacquard equipped product with your Mac? Now you can send gesture from Jcaquard woven to your Mac, and call an action to press a keystroke

For an example, you can brush in-out from your jacket to press an arrow key on your Mac in order to control Keynote presentation. Or press keycombo to trigger [Keysmith](https://www.keysmith.app/) macro

This project is built with [Bonjour](https://developer.apple.com/bonjour/) in mind, this means that iPhone, and Mac can communicate to each other via peer-to-peer protocol. No need for centralized server!

![](./images/draft.jpg)

Feature
---

- Zero configuration
- Peer-to-peer communication with [Bonjour](https://developer.apple.com/bonjour/)
- Modifier keys support (i.e. `⌘ + ⇧ + T`)
- No need to disconnect product from [Jacquard™ by Google](https://apps.apple.com/us/app/jacquard-by-google/id1204971157) app

Compatible products
---

- [Levi’s Trucker Jacket](https://atap.google.com/jacquard/products/levi-trucker/)
- [Samsonite Konnect-i backpack](https://atap.google.com/jacquard/products/samsonite-konnect-i/)
- [Saint Laurent Cit-e Backpack](https://atap.google.com/jacquard/products/ysl/)

What's included?
---

<table width="100%">
  <thead>
    <tr>
      <th width="50%">Jacquard Transmitter</th>
      <th width="50%">Jacquard Receiver</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <img src="./images/transmitter.jpg" />
        <p>Requirements: <b>iOS 16.0+</b></p>
        <p>An iPhone application to foward gestures from Jacquard tag to your Mac</p>
        <details>
          <summary>Live activities also available</summary>
          <img src="./images/live-activity.jpg" />
        </details>
      </td>
      <td>
        <img src="./images/receiver.jpg" />
        <p>Requirements: <b>macOS 12.4+</b></p>
        <p>A macOS application to recieve Jacquard gesture, and configure keystorke to press</p>
      </td>
    </tr>
  </tbody>
</table>

How to get it?
---

Build with Xcode 14 or higher, app will not be distributed to App Store Connect so you have to build and upload running builds to your phone by yourself.

There's an *.ipa* and *.app* provided in [Release](https://github.com/rayriffy/jacquard-rtc/releases/latest) page of repository. Just in case if you want to install iOS app via AltStore but I cannot garantee that it will work.

How to use it?
---

1. Make sure that both Transmitter (iOS), and Reciever (macOS) are located withing the same local network for lower latency.
2. Connect your Jacquard tag to Transmitter
3. Launch Reciever application, configure keystroke to use on each gesture.

> Notes: Reciever will require Acccessibility permission on your macOS, you can enable it in System Preferences first before launch to avoid permission popup to appear

4. Select correct peer on both iOS, and macOS sides.
5. Swipe your jacket, then everything should be work magically

What's next?
---

- [x] Extra key modifier combo (⌘, ⌥, ^, ⇧)
- [ ] Interface revamp
