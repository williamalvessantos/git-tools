#!/usr/bin/env bash
#
# PROPOSAL: ----------------------------------------------------------------------------------------
# Identify from last commit, print branch source
# 
# GitHub Tested    - [ok]
# GitLab Tested    - [no]
# BitBucket Tested - [no]
# 
# Date: 2019-12-05
# Maintainer: William Alves <williamalvessantos@gmail.com>
#
# -------------------------------------------------------------------------------------------------
# Functions
# -------------------------------------------------------------------------------------------------

function last_commit_num(){
   # PARM1 - No Parm
   git log --oneline --all --decorate  $(git reflog | \
   awk '{print $1}') | head -n1 | awk '{print $1}'
}

function last_commit_info(){
   # PARM1 - last_commit_num
   git log --oneline --all --decorate | grep ${1} | sed 's/ //g'
}

function last_commit_branch(){
	 # PARM1 - No Parm
   echo $last_commit_info | sed 's/(\|)/\n/g;s/,/\n/1' | grep "origin" | cut -f1 -d','
}

# -------------------------------------------------------------------------------------------------
# Start
# -------------------------------------------------------------------------------------------------

last_commit_num=`last_commit_num`
last_commit_info=`last_commit_info ${last_commit_num}`
last_commit_branch=`last_commit_branch`

echo ${last_commit_branch}

# -------------------------------------------------------------------------------------------------
# End
# -------------------------------------------------------------------------------------------------
