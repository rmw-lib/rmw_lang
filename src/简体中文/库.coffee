#!/usr/bin/env coffee

import chalk from 'chalk'

export $log = (args...)=>
  console.log chalk.green('→'), chalk.gray ...args
