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
          Divider()
        }
        Group {
          Text("`").tag(KeyboardKey.key_grave)
          Text("1").tag(KeyboardKey.key_1)
          Text("2").tag(KeyboardKey.key_2)
          Text("3").tag(KeyboardKey.key_3)
          Text("4").tag(KeyboardKey.key_4)
          Text("5").tag(KeyboardKey.key_5)
          Text("6").tag(KeyboardKey.key_6)
          Text("7").tag(KeyboardKey.key_7)
          Text("8").tag(KeyboardKey.key_8)
          Text("9").tag(KeyboardKey.key_9)
        }
        Group {
          Text("0").tag(KeyboardKey.key_0)
          Text("-").tag(KeyboardKey.key_dash)
          Text("=").tag(KeyboardKey.key_equal)
          Divider()
        }
        Group {
          Text("[").tag(KeyboardKey.key_bracketOpen)
          Text("]").tag(KeyboardKey.key_bracketClose)
          Text(";").tag(KeyboardKey.key_semiColon)
          Text("'").tag(KeyboardKey.key_singleQuote)
          Text(",").tag(KeyboardKey.key_comma)
          Text(".").tag(KeyboardKey.key_dot)
          Text("/").tag(KeyboardKey.key_slash)
          Text("\\").tag(KeyboardKey.key_backSlash)
          Divider()
        }
        Group {
          Text("←").tag(KeyboardKey.key_arrowLeft)
          Text("→").tag(KeyboardKey.key_arrowRight)
          Text("↑").tag(KeyboardKey.key_arrowUp)
          Text("↓").tag(KeyboardKey.key_arrowDown)
          Divider()
        }
        Group {
          Text("↵").tag(KeyboardKey.key_return)
          Text("⌫").tag(KeyboardKey.key_backSpace)
          Text("␣").tag(KeyboardKey.key_space)
          Divider()
        }
        Group {
          Text("PgUp").tag(KeyboardKey.key_pageUp)
          Text("PgDown").tag(KeyboardKey.key_pageDown)
          Text("Home").tag(KeyboardKey.key_home)
          Text("End").tag(KeyboardKey.key_end)
          Divider()
        }
        Group {
          Text("Esc").tag(KeyboardKey.key_esc)
          Text("Del").tag(KeyboardKey.key_delete)
        }
      }
    )
  }
}
