FROM centos:7
LABEL "Maintainer"="Layershift <jelastic@layershift.com>"

ENV OPENERP_SERVER /etc/odoo/openerp-server.conf
ENV ODOO_VERSION 12.0
ENV ODOO_RELEASE latest
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN mkdir -p /etc/selinux/targeted/contexts/
RUN echo '<busconfig><selinux></selinux></busconfig>' > /etc/selinux/targeted/contexts/dbus_contexts
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y centos-release-scl
RUN yum install -y rh-python35
RUN yum install -y git gcc wget nodejs-less libxslt-devel bzip2-devel openldap-devel libjpeg-devel freetype-devel
RUN useradd -m -U -r -d /opt/odoo -s /bin/bash odoo
RUN yum install postgresql postgresql-server postgresql-contrib postgresql-libs -y
#RUN postgresql-setup initdb 
#RUN systemctl start postgresql-9.6.service \
#    systemctl enable postgresql-9.6.service \
#    su - postgres -c "createuser -s odoo"
#RUN cd /opt/ \
#    wget https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox-0.12.5-1.centos7.x86_64.rpm \
#    yum localinstall wkhtmltox-0.12.5-1.centos7.x86_64.rpm

#USER odoo
#RUN git clone https://www.github.com/odoo/odoo --depth 1 --branch 12.0 /opt/odoo/odoo12 \
#    scl enable rh-python35 bash \
#    cd /opt/odoo \
#    python3 -m venv odoo12-venv \
#    source odoo12-venv/bin/activate \
#    pip install --upgrade pip \
#    pip3 install wheel \
#    pip3 install -r odoo12/requirements.txt \
#    deactivate
#USER root
COPY configs/odoo12.service /etc/systemd/system/
#RUN systemctl daemon-reload \
#    systemctl start odoo12 \
#    systemctl enable odoo12
COPY configs/entrypoint.sh /
COPY configs/openerp-server.conf /etc/odoo/
#RUN mkdir -p /opt/odoo/extra-addons
#RUN chown odoo /etc/odoo/openerp-server.conf \
#    chown -R odoo: /mnt/extra-addons

VOLUME ["/sys/fs/cgroup" , "/opt/odoo" ]

EXPOSE 8069

#USER odoo

CMD ["/usr/sbin/init"]

#ENTRYPOINT ["/entrypoint.sh"]
#CMD ["openerp-server"]

