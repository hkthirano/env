# docker build ./ -t hirano_v1
# docker run --gpus all -it --privileged --name hirano_v1 hirano_v1 /bin/bash

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

LABEL maintainer="Admin <admin@admin.com>"

CMD echo "now running..."

RUN apt-get update -y
RUN apt-get install -y vim git curl wget tmux openssh-server sudo cifs-utils
RUN apt-get install -y net-tools zlib1g-dev libssl-dev

# ssh
RUN mkdir /var/run/sshd
RUN echo 'root:kkk' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN mkdir -p /usr/local/etc/bash_completion.d
RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh 
RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
RUN mv git-prompt.sh /usr/local/etc/bash_completion.d/
RUN mv git-completion.bash /usr/local/etc/bash_completion.d/

RUN git clone https://github.com/hkthirano/env.git
RUN mv env/.bash_profile /root/
RUN mv env/.tmux.conf /root/
RUN mv env/.vimrc /root/

ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
RUN git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
RUN echo 'export PYENV_ROOT=$HOME/.pyenv' >> $HOME/.bashrc && \
    echo 'export PATH=$PYENV_ROOT/bin:$PATH' >> $HOME/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc && \
    eval "$(pyenv init -)"

RUN echo '## CUDA and cuDNN paths' >> $HOME/.bash_profile && \
    echo 'export PATH=/usr/local/cuda-9.0/bin:${PATH}' >> $HOME/.bash_profile && \
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:${LD_LIBRARY_PATH}' >> $HOME/.bash_profile

RUN apt-get install language-pack-ja-base language-pack-ja ibus-mozc -y
RUN echo 'export LANG=ja_JP.UTF-8' >> ~/.bash_profile
RUN echo 'export LANGUAGE="ja_JP:ja"' >> ~/.bash_profile

ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PATH:$HOME/.pyenv/shims:$HOME/.pyenv/bin
RUN chmod 777 $HOME/.pyenv -R
ARG python_version="anaconda3-5.0.0"
RUN pyenv install ${python_version}
RUN pyenv global ${python_version}
RUN conda install mkl
RUN pip install tensorflow-gpu==1.12.0
RUN pip install keras==2.2.4
RUN pip install imblearn
RUN conda install -c conda-forge opencv

RUN mkdir /root/workspace

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
