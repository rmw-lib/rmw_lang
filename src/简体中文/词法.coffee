#!/usr/bin/env coffee

import {$log} from './库'
import 引 from './词法/引'
import 字符串 from './词法/字符串'

export default 词法 = (源)=>
  源 = 源.replaceAll('\r\n','\n').replaceAll('\r','\n').split('\n')

  流 = []
  返 =  (...args)=>流.push args # 态,行,列,文
  行 = 0
  总行数 = 源.length

  `outer: //`
  while 行<总行数

    for 拆 from [
      引
    ]
      值 = 拆 返,源,行
      if 值
        行 = 值
        `continue outer`

    列 = 0
    `inner: //`
    loop
      line = 源[行]
      if line == undefined
        break
      {length} = line
      while 列 < length
        for 拆 from [
          字符串
        ]
          值 = 拆 返,源,行,列
          if 值
            if 行 == 值[0]
              列 = 值[1]
              continue
            else
              [行,列] = 值
              `continue inner`
          ++列
      break

    ++行
  流
