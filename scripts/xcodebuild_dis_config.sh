#!/bin/sh

#使用方法：bash -l ./xcodebuild_dis_config.sh

target_name="IcePointCloud.xcworkspace" # 有效值 ****.xcodeproj / ****.xcworkspace (cocoapods项目)
project_name="IcePointCloud" # 工程名
work_type="workspace" # 有效值 project / workspace (cocoapods项目)
api_token="9469d6a9c492a262cc2e314ac4205b64" # fir token

sctipt_path=$(cd `dirname $0`; pwd)
echo sctipt_path=${sctipt_path}
work_path=${sctipt_path}/..
rm -rf ${work_path}/build

#cd ../
#pod install --no-repo-update
#cd ${sctipt_path}


out_sub_path=`date "+%Y-%m-%d-%H-%M-%S"`
out_base_path="xcode_build_ipa_dis"
out_path=${work_path}/${out_base_path}/${out_sub_path}
mkdir -p ${out_path}


if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
    source $HOME/.rvm/scripts/rvm
    rvm use system
fi

xcodebuild -$work_type ${work_path}/$target_name -scheme $project_name -configuration TestRelease -sdk iphoneos clean
xcodebuild archive -$work_type ${work_path}/$target_name -scheme $project_name -configuration TestRelease -archivePath ${out_path}/$project_name.xcarchive

xcodebuild -exportArchive -archivePath ${out_path}/$project_name.xcarchive -exportPath ${out_path} -exportOptionsPlist ${sctipt_path}/xcodebuild_dis_config.plist

echo ${out_path}/$project_name.ipa

if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
    source ~/.rvm/scripts/rvm
    rvm use default
fi

fir p ${out_path}/$project_name.ipa -T $api_token -c

exit 0