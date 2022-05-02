#!/usr/bin/env coffee

import {单行注释,多行注释} from '../态'
import 行缩进 from './行缩进'

export default (返,源,行,列)=>
  始 = 行
  文 = 源[行]
  if 文[列] == '#'
    if 文[列+1] == ':'
      值 = [文[列..]]
      缩进 = 行缩进 文
      总行数 = 源.length
      while ++行 < 总行数
        文 = 源[行]
        if 行缩进(文)<=缩进
          break
        值.push 文
      返 [多行注释,缩进],始,列,值.join('\n')
      return 行
    else
      返 单行注释,始,列,文[列..]
      return ++行
  return
