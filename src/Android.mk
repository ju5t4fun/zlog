LOCAL_PATH:=$(call my-dir)

#3 自定义了一个all_c_files_recursively 函数，递归遍历返回给定目录下所有C源文件。
#all_c_files_recursively = \
	$(eval src_files = $(wildcard $1/*.c)) \
	$(eval src_files = $(src_files:$(LOCAL_PATH)/%=%))$(src_files) \
	$(eval item_all = $(wildcard $1/*)) \
	$(foreach item, $(item_all) $(),\
		$(eval item := $(item:%.c=%)) \
		$(call all_c_files_recursively, $(item))\
	)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)
#LOCAL_SRC_FILES:= $(call all_c_files_recursively,$(LOCAL_PATH))
LOCAL_SRC_FILES:= \
	buf.c \
	category.c \
	category_table.c \
	conf.c \
	event.c \
	format.c \
	level.c \
	level_list.c \
	mdc.c \
	record.c \
	record_table.c \
	rotater.c \
	rule.c \
	spec.c \
	thread.c \
	zc_arraylist.c \
	zc_hashtable.c \
	zc_profile.c \
	zc_util.c \
	zlog.c \
	glob.c
LOCAL_MODULE_TAGS:= optional
LOCAL_MODULE:=libzlog
include $(BUILD_SHARED_LIBRARY)

#=====================================================
include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)
LOCAL_SRC_FILES:= zlog-chk-conf.c
LOCAL_SHARED_LIBRARIES:= libzlog
LOCAL_MODULE_TAGS:=optional
LOCAL_MODULE:=zlog_chk_conf
include $(BUILD_EXECUTABLE)
