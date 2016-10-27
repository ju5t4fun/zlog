LOCAL_PATH:=$(call my-dir)

all_c_files_recursively = \
	$(eval src_files = $(wildcard $1/*.c)) \
	$(eval src_files = $(src_files:$(LOCAL_PATH)/%=%))$(src_files) \
	$(eval item_all = $(wildcard $1/*)) \
	$(foreach item, $(item_all) $(),\
		$(eval item := $(item:%.c=%)) \
		$(call all_c_files_recursively, $(item))\
	)

define my_add_exectable
	include $(CLEAR_VARS)
	LOCAL_C_INCLUDES := $(LOCAL_PATH)/../src/
	LOCAL_SRC_FILES:= $1
	LOCAL_SHARED_LIBRARIES:= libzlog
	LOCAL_MODULE_TAGS:=optional
	LOCAL_MODULE:= $(subst .c,,$1)
	include $(BUILD_EXECUTABLE)
endef

$(foreach source_file, $(call all_c_files_recursively, $(LOCAL_PATH)), \
	$(eval $(call my_add_exectable, $(source_file))))
