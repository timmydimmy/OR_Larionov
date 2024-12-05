REMOTE_USER="root"                      
REMOTE_HOST="localhost"                 
REMOTE_PORT="2222"  


ssh -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST "tar -czf /mnt/project/copy.tar.gz -C /mnt/project copy"


scp -P $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST:/mnt/project/copy.tar.gz /Users/dmitry/Downloads/WORK_AND_STUFF/REPA/OR_Larionov/Lab9/

tar -xzf copy.tar.gz -C local


echo "Процесс завершён успешно!"