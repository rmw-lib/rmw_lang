#!/usr/bin/env coffee

import yargs from 'yargs'
import {hideBin as 隐路径} from 'yargs/helpers'
import 路径监控 from 'chokidar'
import {join,dirname} from 'path'
import {ntDecode} from '@rmw/nestedtext'
import {walkRel as 相对路径遍历} from '@rmw/walk'
import {rmSync as 删,mkdirSync as 建目录,writeFileSync as 写文件,readFileSync as 读文件} from 'fs'
import {$log} from './库'
import 编译 from './编译'

utf8 = 'utf8'

参数解析器 = yargs(隐路径(process.argv)).command(
  '[路径]'
  '编译文件夹'
).option(
  'watch',
  {
    alias: 'w',
    describe: '监控改动并实时编译'
  }
).option(
  'outdir',
  {
    alias: 'o',
    describe: '文件输出目录'
  }
)
参 = 参数解析器.parse()
根 = 参._[0]

_编目录 = (根)=>
  for await i from 相对路径遍历(根)
    if i.endsWith('.rmw')
      编文件(i)


rmw_js = (path)=>
  path[..-4]+'js'

_编文件 = (根,输出目录,路径)=>
  $log '编译',路径
  输出文件名 = rmw_js 路径
  输出文件 = join(输出目录,输出文件名)
  建目录(dirname(输出文件),recursive:true)

  源文件 = join(根,路径)
  [译文,映射] = 编译(
    读文件 源文件,utf8
    {
      out: 输出文件
      src: 源文件
    }
  )

  映射文件名 = 输出文件名+'.map'
  译文 += "\n//# sourceMappingURL=#{映射文件名}"
  写文件(
    映射文件名
    映射
  )
  写文件(
    输出文件
    译文
  )
  return

if 根
  输出目录 = 参.outdir || 根
  编目录 = _编目录.bind 编目录,根
  编文件 = _编文件.bind 编文件,根,输出目录

  if 参.watch
    监 = 路径监控.watch(根)
    相对路径 = (path)=>
      path.slice(根.length+1)

    文件改动 = (path)=>
      path = 相对路径 path
      pos = path.lastIndexOf '.'
      if ~pos
        switch path.slice(pos+1)
          when 'rmw'
            编文件(path)
          when 'nt'
            编目录()
    ['add','change'].map (i)=>
      监.on(i,文件改动)
    监.on 'unlink',(path)=>
      $log '删除',path
      删(
        join 输出目录,相对路径(rmw_js path)
      )
  else
    await 编目录()
else
  参数解析器.showHelp()
