#!/bin/sh

cd `echo $(cd $(dirname $0) && pwd)`
date_time=`date '+%Y-%m-%d_%H:%M:%S'`

find ~/ -atime -1 -print0 | xargs -n 100 -0 stat -f "%d\t%i\t%p\t%l\t%u\t%g\t%r\t%z\t%Sa\t%Sm\t%Sc\t%HT\t%k\t%b\t%f\t%N" -t '%F %T' >> "Documents_file/${date_time}"
wait

bundle exec ruby -Ku create_db.rb "Documents_file/${date_time}"
