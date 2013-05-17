#!/bin/sh
#
#   Copyright 2013 Jaromír Müller
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License 
#

echo "Node installation has just started..."

HOME_STACK_INSTALL_PATH=/tmp/baseline-box-install
PUPPET_MANIFESTS_PATH=~/.puppet/manifests
PUPPET_MODULE_PATH=~/.puppet/modules

if [ ! -d $PUPPET_MANIFESTS_PATH ]; then
    mkdir -pv $PUPPET_MANIFESTS_PATH
fi

if [ ! -d $PUPPET_MODULE_PATH ]; then
    mkdir -pv $PUPPET_MODULE_PATH
fi

echo "Installation of puppet modules from forge.puppetlabs.com"
puppet module install --debug --modulepath $PUPPET_MODULE_PATH thomasvandoren-redis

echo "Applying puppet manifests"
cp -vR $HOME_STACK_INSTALL_PATH/puppet/manifests/* $PUPPET_MANIFESTS_PATH  
puppet apply --debug --verbose --modulepath=$PUPPET_MODULE_PATH $PUPPET_MANIFESTS_PATH/base.pp

echo "Baseline BOX installation is finished."
exit 0