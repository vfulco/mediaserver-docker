/usr/bin/s3fs ngs-original-media ${HOMEDIR}/originals -o nosuid,nonempty,nodev,allow_other,retries=5
/usr/bin/s3fs ngs-modified-media ${HOMEDIR}/modified -o nosuid,nonempty,nodev,allow_other,retries=5
