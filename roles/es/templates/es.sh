export ES_PATH_CONF={{app_confRootDir}}{{appName}}/
export ES_HOME={{app_rootDir}}{{appName}}/

export ES_TMPDIR={{app_dataRootDir}}{{appName}}/

export PID_DIR={{app_dataRootDir}}{{appName}}/
export ES_JAVA_OPTS="{{es_config['ES_JAVA_OPTS']}}"




export MAX_LOCKED_MEMORY=unlimited
export MAX_OPEN_FILES=65535