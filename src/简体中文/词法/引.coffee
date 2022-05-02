#!/usr/bin/env coffee

import 注释 from './注释'
import {引用块开始,模块,模块导入,导入别名,导入别名冒号} from '../态'

冒号 = ':'

别名分隔符 = (文,列)=>
  len = 文.length
  while ++列<len
    字 = 文[列]
    if 字 == ' '
      return true
    if ~ '?/.'.indexOf(字)
      return false
  return true

export default (返,源,行)=>
  文 = 源[行]
  字 = 文[0]
  if 字!='>'
    return

  列 = 0

  生 = (态,词)=>
    返 态,行,列,词


  生 引用块开始,字

  源[行] = ' '+文[1..]

  总行数 = 源.length

  模块缩进 = 0

  子 = []

  `out: //`
  while 行 < 总行数
    文 = 源[行]
    干 = 文.trimStart()

    if 干
      字数 = 文.length
      列 = 缩进 = 字数 - 干.length

      有 = 注释 返,源,行,列
      if 有
        行 = 有
        `continue out`

      if 缩进 == 0
        break
      else if 模块缩进 == 0
        模块缩进 = 缩进

      if 缩进 == 模块缩进
        别名 = []
        子 = [别名]
        态 = [模块,子]
      else
        态 = 模块导入


      暂 = []
      出 = =>
        if not 暂.length
          return
        词 = 暂.join ''
        暂 = []
        追 = [行,列,词]
        if 别名.length == 1
          生 导入别名,词
          别名.push 追
        else
          生 态,词
          if 态 == 模块导入
            子.push 追
            别名 = []
            追.push 别名

      --列

      读别名 = 0

      while 列<字数
        ++列

        有 = 注释 返,源,行,列
        if 有
          行 = 有
          `continue out`

        字 = 文[列]
        if 字!=' '
          if 字 == 冒号 and 别名分隔符 文,列
            出()
            t = [行,列,冒号]
            返 导入别名冒号,...t
            别名.push t
          else
            暂.push 字
        else
          出()

      出()
    ++行

    #console.log 文

  行
