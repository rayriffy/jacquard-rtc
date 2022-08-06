//
//  KeyboardPicker.swift
//  macOS
//
//  Created by Phumrapee Limpianchop on 2022/08/07.
//

import SwiftUI

struct KeyboardPicker: View {
  var label: String
  @Binding var selection: KeyboardKey

  var body: some View {
    Picker(
      selection: $selection,
      label: Text(label),
      content: {
        Group {
          Text("A").tag(KeyboardKey.key_a)
          Text("B").tag(KeyboardKey.key_b)
          Text("C").tag(KeyboardKey.key_c)
          Text("D").tag(KeyboardKey.key_d)
          Text("E").tag(KeyboardKey.key_e)
          Text("F").tag(KeyboardKey.key_f)
          Text("G").tag(KeyboardKey.key_g)
          Text("H").tag(KeyboardKey.key_h)
          Text("I").tag(KeyboardKey.key_i)
          Text("J").tag(KeyboardKey.key_j)
        }
        Group {
          Text("K").tag(KeyboardKey.key_k)
          Text("L").tag(KeyboardKey.key_l)
          Text("M").tag(KeyboardKey.key_m)
          Text("N").tag(KeyboardKey.key_n)
          Text("O").tag(KeyboardKey.key_o)
          Text("P").tag(KeyboardKey.key_p)
          Text("Q").tag(KeyboardKey.key_q)
          Text("R").tag(KeyboardKey.key_r)
          Text("S").tag(KeyboardKey.key_s)
          Text("T").tag(KeyboardKey.key_t)
        }
        Group {
          Text("U").tag(KeyboardKey.key_u)
          Text("V").tag(KeyboardKey.key_v)
          Text("W").tag(KeyboardKey.key_w)
          Text("X").tag(KeyboardKey.key_x)
          Text("Y").tag(KeyboardKey.key_y)
          Text("Z").tag(KeyboardKey.key_z)
        }
        Group {
          Text("←").tag(KeyboardKey.key_arrowLeft)
          Text("→").tag(KeyboardKey.key_arrowRight)
          Text("↑").tag(KeyboardKey.key_arrowUp)
          Text("↓").tag(KeyboardKey.key_arrowDown)
          Text("↵").tag(KeyboardKey.key_return)
          Text("⌫").tag(KeyboardKey.key_backSpace)
          Text("PgUp").tag(KeyboardKey.key_pageUp)
          Text("PgDown").tag(KeyboardKey.key_pageDown)
          Text("End").tag(KeyboardKey.key_end)
          Text("Home").tag(KeyboardKey.key_home)
        }
        Group {
          Text("␣").tag(KeyboardKey.key_space)
          Text("Esc").tag(KeyboardKey.key_esc)
          Text("Del").tag(KeyboardKey.key_delete)
        }
      }
    )
  }
}
