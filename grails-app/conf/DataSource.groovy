dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"

}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost:3306/softrack?zeroDateTimeBehavior=convertToNull"
            username = "root"
            password = "root"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
            properties {
                maxActive = 50
                maxIdle = 25
                minIdle = 5
                initialSize = 5
                maxWait = 10000
                removeAbandoned = true
                removeAbandonedTimeout = 400
                logAbandoned = true
                minEvictableIdleTimeMillis = 1800000
                timeBetweenEvictionRunsMillis = 1800000
                numTestsPerEvictionRun = 3
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = true
                validationQuery = "SELECT 1"
            }
        }
        hibernate {
            show_sql = false
        }
    }
    test {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost:3306/softrack?zeroDateTimeBehavior=convertToNull"
            username = "root"
            password = "root"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost:3306/softrack?zeroDateTimeBehavior=convertToNull"
            username = "root"
            password = "root"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
            properties {
                maxActive = 50
                maxIdle = 25
                minIdle = 5
                initialSize = 5
                maxWait = 10000
                removeAbandoned = true
                removeAbandonedTimeout = 400
                logAbandoned = true
                minEvictableIdleTimeMillis = 1800000
                timeBetweenEvictionRunsMillis = 1800000
                numTestsPerEvictionRun = 3
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = true
                validationQuery = "SELECT 1"
            }
        }
    }
}