//
//  KeyboardPicker.swift
//  macOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import SwiftUI

struct KeyboardPicker: View {
  var label: String
  @ObservedObject var gestureKeyboard: GestureKeyboard

  var body: some View {
    Picker(
      selection: $gestureKeyboard.keyboardKey,
      label: Text(label),
      content: {
        Group {
          KeyOption(label: "A", value: KeyboardKey.key_a)
          KeyOption(label: "B", value: KeyboardKey.key_b)
          KeyOption(label: "C", value: KeyboardKey.key_c)
          KeyOption(label: "D", value: KeyboardKey.key_d)
          KeyOption(label: "E", value: KeyboardKey.key_e)
          KeyOption(label: "F", value: KeyboardKey.key_f)
          KeyOption(label: "G", value: KeyboardKey.key_g)
          KeyOption(label: "H", value: KeyboardKey.key_h)
          KeyOption(label: "I", value: KeyboardKey.key_i)
          KeyOption(label: "J", value: KeyboardKey.key_j)
        }
        Group {
          KeyOption(label: "K", value: KeyboardKey.key_k)
          KeyOption(label: "L", value: KeyboardKey.key_l)
          KeyOption(label: "M", value: KeyboardKey.key_m)
          KeyOption(label: "N", value: KeyboardKey.key_n)
          KeyOption(label: "O", value: KeyboardKey.key_o)
          KeyOption(label: "P", value: KeyboardKey.key_p)
          KeyOption(label: "Q", value: KeyboardKey.key_q)
          KeyOption(label: "R", value: KeyboardKey.key_r)
          KeyOption(label: "S", value: KeyboardKey.key_s)
          KeyOption(label: "T", value: KeyboardKey.key_t)
        }
        Group {
          KeyOption(label: "U", value: KeyboardKey.key_u)
          KeyOption(label: "V", value: KeyboardKey.key_v)
          KeyOption(label: "W", value: KeyboardKey.key_w)
          KeyOption(label: "X", value: KeyboardKey.key_x)
          KeyOption(label: "Y", value: KeyboardKey.key_y)
          KeyOption(label: "Z", value: KeyboardKey.key_z)
          Divider()
        }
        Group {
          KeyOption(label: "`", value: KeyboardKey.key_grave)
          KeyOption(label: "1", value: KeyboardKey.key_1)
          KeyOption(label: "2", value: KeyboardKey.key_2)
          KeyOption(label: "3", value: KeyboardKey.key_3)
          KeyOption(label: "4", value: KeyboardKey.key_4)
          KeyOption(label: "5", value: KeyboardKey.key_5)
          KeyOption(label: "6", value: KeyboardKey.key_6)
          KeyOption(label: "7", value: KeyboardKey.key_7)
          KeyOption(label: "8", value: KeyboardKey.key_8)
          KeyOption(label: "9", value: KeyboardKey.key_9)
        }
        Group {
          KeyOption(label: "0", value: KeyboardKey.key_0)
          KeyOption(label: "-", value: KeyboardKey.key_dash)
          KeyOption(label: "=", value: KeyboardKey.key_equal)
          Divider()
        }
        Group {
          KeyOption(label: "[", value: KeyboardKey.key_bracketOpen)
          KeyOption(label: "]", value: KeyboardKey.key_bracketClose)
          KeyOption(label: ";", value: KeyboardKey.key_semiColon)
          KeyOption(label: "'", value: KeyboardKey.key_singleQuote)
          KeyOption(label: ",", value: KeyboardKey.key_comma)
          KeyOption(label: ".", value: KeyboardKey.key_dot)
          KeyOption(label: "/", value: KeyboardKey.key_slash)
          KeyOption(label: "\\", value: KeyboardKey.key_backSlash)
          Divider()
        }
        Group {
          KeyOption(label: "←", value: KeyboardKey.key_arrowLeft)
          KeyOption(label: "→", value: KeyboardKey.key_arrowRight)
          KeyOption(label: "↑", value: KeyboardKey.key_arrowUp)
          KeyOption(label: "↓", value: KeyboardKey.key_arrowDown)
          Divider()
        }
        Group {
          KeyOption(label: "↵", value: KeyboardKey.key_return)
          KeyOption(label: "⌫", value: KeyboardKey.key_backSpace)
          KeyOption(label: "␣", value: KeyboardKey.key_space)
          Divider()
        }
        Group {
          KeyOption(label: "PgUp", value: KeyboardKey.key_pageUp)
          KeyOption(label: "PgDown", value: KeyboardKey.key_pageDown)
          KeyOption(label: "Home", value: KeyboardKey.key_home)
          KeyOption(label: "End", value: KeyboardKey.key_end)
          Divider()
        }
        Group {
          KeyOption(label: "Esc", value: KeyboardKey.key_esc)
          KeyOption(label: "Del", value: KeyboardKey.key_delete)
        }
      }
    )
  }
}
