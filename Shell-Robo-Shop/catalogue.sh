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

dnf module disable nodejs -y &>> LOG_FILE
validate $? "disabling the default module"

dnf module enable nodejs:20 -y &>> LOG_FILE
validate $? "enabling specific node"

dnf install nodejs -y &>> LOG_FILE
validate $? "installing nodejs"

id roboshop &>> LOG_FILE
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>> LOG_FILE
    validate $? "adding a user"
else 
    echo -e "$G roboshop user is already exist... $Y skipping $N"
fi

mkdir -p /app &>> LOG_FILE
validate $? "creating a dictory"

yum install curl -y  &>> LOG_FILE
validate $? "installing curl"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip  &>> LOG_FILE
validate $? "downloading code from s3 bucket"

cd /app 

unzip -o  /tmp/catalogue.zip  -d /app &>> LOG_FILE
cd /app
npm install  &>> LOG_FILE

sudo cp catalogue.service /etc/systemd/system/ 
validate $? "copying code from one to other place"




