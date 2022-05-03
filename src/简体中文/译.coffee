#!/usr/bin/env coffee

import {camelCase} from 'lodash-es'

import {字符串,导入别名冒号,单行注释,多行注释,模块,模块导入} from './态'
import nt2json5 from '@rmw/nt2json5'

export default 译 = {}

译[字符串] = (文)=>
  if 文[0] == '"'
    文 = nt2json5 JSON.parse 文
  文

译[单行注释] = (文)=>
  ' //' + 文[1..]

译[多行注释] = (缩进)=>
  (文)=>
    '/*' + 文[2..] + '\n'.padEnd(缩进+1) + '*/'

译[模块] = (子)=>
  (文)->
    别名 = 子.shift()
    变量名 = =>
      t = 文
      p = t.lastIndexOf('/')
      if ~p
        t = t[p+1..]
      p = t.indexOf('.')
      if ~p
        t = t[...p]
      return camelCase t

    len = 子.length
    有别名 = 别名.length
    if not len and not 有别名
      yield "import #{变量名(文)} from '#{文}'"

    if 有别名
      别名 = 别名.pop()
      名 = 别名[2]
      if 别名[2] == '@'
        别名[2] = 变量名 文
      yield "import "
      yield 别名
      yield " from '#{文}'"
      if len
        yield '\n'
    if len
      --len
      yield "import {"
      for i,pos in 子
        if pos != len
          i[2] += ','
        yield i[..3]
        if i[3].length
          [冒号,别名] = i[3]
          冒号[2] = ' as '
          yield 冒号
          yield 别名
      yield "} from '#{文}'"
    return
