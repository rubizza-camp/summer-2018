# versus.rb
versus.rb is an analyzer of versus battles. All text files must be in "texts" folder which is located in the same directory with program file. The name of each file must mutch to next pattern: NAME_1 (VS|vs)|((П|п)ротив) NAME_2. Each file can include one or more rounds, if there are several rounds, they must be defined with line that matchs to ((Р|р)аунд NUM)|(NUM (Р|р)аунд) pattern. 

     Usage: versus.rb [options]

        --help -h               displays this message
        --top-bad-words=<num>   displays <num> of the most rude rappers (default 5)
        --top-words=<num>       displays top <num> words of each rapper (default 30)
        --name=<name>           specifies the above options to given rapper name



