#!/usr/bin/env ruby
class PushFile
  def retdir
    system 'cd ../..'
  end
  def transfile
    if system('scp -i ~/.ec2/tokyoInstance devjs/* root@issues.insprie.net:/home/bitnami/apps')
      exit
    end
    puts 'error'
  end
  def gitAdd
    `git add --all :/`
    # gitid=gets.chomp
    `git status`
    gitid=`date`
    puts('please put content:')
    gitcontent=gets.chomp
    `git commit -m \"#{gitid}\n  Content:#{gitcontent}.\"`
    if system 'git branch -r'
      # puts('input branch :')
      # branch=gets.chomp
      branch='master'
      `git push -u origin #{branch}`

    end
  end

  if __FILE__ == $0
    su=PushFile.new
    su.gitAdd
  end
end