#!/usr/bin/env coffee

import 射 from './射'
import 编 from './编'
import 词法 from './词法'
import {join,dirname,relative} from 'path'

export 预设 = {
  sourceMap : true
}

export default (源,设)=>
  {
   sourceMap
  } = 设 = {
    ...预设
    ...(设 or {})
  }
  if sourceMap
    {src,out} = 设
    [映射,映射地图] = 射 relative(dirname(out),src)

  [
    编 词法(源),映射
    映射地图()
  ]
