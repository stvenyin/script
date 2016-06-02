function sync_from {
  if [ -z "$1" ]; then
    echo "collection name is required"
    exit 1
  fi
  date=$(date +%F)
  backup_file=${1}_$date.json
  echo "mongoexport -h mongo -d gpws -c $1 -o /data/backup/$backup_file"
  mongoexport -h mongo -d gpws -c $1 -o /data/backup/$backup_file

  echo "mongoimport -d gpws-dev -c $1 /data/backup/$backup_file"
  mongoimport -d gpws-dev -c $1 --drop /data/backup/$backup_file
}

for i in code_info stock theme theme_stock top_info
do
  sync_from $i
done
