#!/usr/bin/env coffee

import {字符串} from '../态'

# 正则 前缀 是 =(/ 空格

反斜杠 = '\\'

export default (返,源,行,列)=>
  line = 源[行]
  始 = line[列]

  if ~ '\'"`'.indexOf 始
    txt = [始]
    r = [字符串,行,列]
    `out: //`
    loop
      {length} = line

      while ++列 < length
        字 = line[列]
        if 字 == 反斜杠
          t = line[++列]
          if t!=undefined
            txt.push t
          continue
        else
          txt.push 字
          if 字 == 始
            r.push txt.join('')
            返 ...r
            ++列
            `break out`

      line = 源[++行]
      if line == undefined
        break
      else
        if 字!=反斜杠
          txt.push '\\n'
        列 = -1
    return [行,列]

  return
