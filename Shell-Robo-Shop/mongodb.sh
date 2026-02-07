STARTTIME=$(date +%s)
TIMESTAMP=$(date)
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/Shell-script"
LOG_FILE="$LOG_FOLDER/$0.log"

mkdir -p /var/log/Shell-script &>> LOG_FILE

validate(){
    if [ $1 -ne 0 ];then 
    echo -e "$2..$R failed $N" | tee -a $LOG_FILE
    else 
    echo -e "$2..$G success $N" | tee -a $LOG_FILE
    fi
}

if [ $ID -ne 0 ]; then 
echo -e " $R..please run this script with root user $N"
exit 1
fi

cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOG_FILE
validate $? "copying mongo.repo"

dnf install mongodb-org -y  &>> $LOG_FILE
validate $? "installing mongodb"

systemctl enable mongod &>> $LOG_FILE
validate $? "enabling mongodb"

systemctl start mongod &>> $LOG_FILE
validate $? "staring mongodb"

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf
validate $? "changing the port"

systemctl restart mongod  
validate $? "restarting MONGODB"
