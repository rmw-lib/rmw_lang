#!/usr/bin/env coffee

import {SourceMapGenerator} from 'source-map-js'

export default (source)=>
  map = new SourceMapGenerator()
  l = 1
  c = 0

  [
    (行,列,译文)=>
      map.addMapping({
        source
        generated:
          line: l
          column: c
        original:
          line: 1+行
          column: 列
      })

      li = 译文.split('\n')
      文 = li.pop()
      行数 = li.length
      if 行数
        l += 行数
        c = 文.length
      else
        c += 译文.length
      return
    map.toString.bind map
  ]
