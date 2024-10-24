#!/bin/bash
cd /root/blog-source
git pull
hexo g
rm /opt/1panel/apps/openresty/openresty/www/sites/blog.ymbit.cn/index/*
mv ./public/* /opt/1panel/apps/openresty/openresty/www/sites/blog.ymbit.cn/
