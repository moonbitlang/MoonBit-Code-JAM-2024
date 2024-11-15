let text_0 :Array[String]=["Hello,welcome\nthis world","#where the voice?","you can guess\n but no answer"]
fn use_text(i:Int)->Unit{
@wasm4.set_draw_colors(2)
@wasm4.text(text_0[i],19,114)
}
fn text_display() ->Unit{
  if all_meun.next_am==1&&map.text_state==true{
  use_text(map.map_test)
  }
}