folder=`basename $1 .jar`
mkdir $folder
cd $folder
unzip ../$1

find . -name "*.class" | while read file
do
    sudo chown amin.amin $file
    chmod 775 $file
    class=`basename $file .class`
    out_file=$(dirname $file)/${class}.java
    echo "Decompiling $class"
    jad -p $file > $out_file
    rm $file    
done
cd ../
chmod 775 $folder -R
jar cf $folder.src.jar $folder
rm $folder -rf
