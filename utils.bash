clone() {
  if [[ ! -d ~/$1 ]]; then
    git clone --recursive https://github.com/sh19910711/$1 ~/$1
  fi
}

insert() {
  local config=$1
  shift

  touch $config

  if eval "grep -q '$@' $config"; then
    echo "skip: echo $@ >> $config"
  else
    echo $@ >> $config
  fi
}

link() {
  if [[ ! -L $1 ]]; then
    rm $1
    ln -s $2 $1
  fi
}
