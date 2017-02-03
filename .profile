# Heroku runs this file during startup.
# See https://devcenter.heroku.com/articles/dynos#the-profile-file

# Set DATABASE_URL to CLEARDB_DATABASE_URL.
# We use the mysql2 gem so we swap "mysql://" with "mysql2://".
# See https://devcenter.heroku.com/articles/cleardb#configuring-your-ruby-application-to-use-cleardb
export DATABASE_URL=`echo $CLEARDB_DATABASE_URL | sed -e 's/mysql:\/\//mysql2:\/\//g'`
