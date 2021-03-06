hadoop_de:
  cmd.script:
    - source: salt://utils/de.sh
    - args: "http://www.us.apache.org/dist/hadoop/common/hadoop-2.9.1/hadoop-2.9.1.tar.gz /opt/"
    - creates: /opt/hadoop-2.9.1/
  file.directory:
    - name: /opt/hadoop-2.9.1/
    - user: root
    - group: root
    - recurse:
      - user
      - group


hadoop28_de:
  cmd.script:
    - source: salt://utils/de.sh
    - args: "http://www.us.apache.org/dist/hadoop/common/hadoop-2.8.4/hadoop-2.8.4.tar.gz /opt/"
    - creates: /opt/hadoop-2.8.4/
  file.directory:
    - name: /opt/hadoop-2.8.4/
    - user: root
    - group: root
    - recurse:
      - user
      - group

hadoop27_de:
  cmd.script:
    - source: salt://utils/de.sh
    - args: "http://www.us.apache.org/dist/hadoop/common/hadoop-2.7.6/hadoop-2.7.6.tar.gz /opt/"
    - creates: /opt/hadoop-2.7.6/
  file.directory:
    - name: /opt/hadoop-2.7.6/
    - user: root
    - group: root
    - recurse:
      - user
      - group

hadoop_path:
  file.append:
    - name: /etc/profile.d/path_additions.sh
    - text:
      - export HADOOP_VERSION=__HADOOP_VERSION__
      - export PATH=$PATH:/opt/$HADOOP_VERSION/bin

hadoop_env:
  file.append:
    - name: /etc/profile.d/hadoop_env.sh
    - text:
      - export HADOOP_VERSION=__HADOOP_VERSION__
      - export HADOOP_PREFIX=/opt/$HADOOP_VERSION/
      - export HADOOP_CONF_DIR=/opt/$HADOOP_VERSION/etc/hadoop