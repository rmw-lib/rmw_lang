#!/usr/bin/env coffee

import 译 from './译'
import {模块} from './态'

export default (流,映射)=>

  li = []
  印 = (行,列,译文)=>
    映射 行,列,译文
    li.push 译文
    return

  前行 = 0

  for [态,行,列,原文] from 流
    if Array.isArray(态)
      参 = 态[1..]
      态 = 态[0]
      转 = 译[态] ...参
    else
      转 = 译[态]

    if not 转
      continue

    if 行!= 前行
      缩进 = '\n'
      if 态!=模块
        缩进 = 缩进.padEnd(列+1)
      印(行,0,缩进)
      前行 = 行

    译文 = 转 原文,行,列
    if typeof(译文) == 'string'
      印 行,列,译文
    else
      for i from 译文
        if typeof(i) == 'string'
          印 行,列,i
        else
          印 ...i

  txt = li.join ''
  console.log txt
  txt
