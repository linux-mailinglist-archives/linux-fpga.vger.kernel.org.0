Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D5026554F
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Sep 2020 01:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgIJXFY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Sep 2020 19:05:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:62602 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgIJXFU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Sep 2020 19:05:20 -0400
IronPort-SDR: UrRWmgJaYF1uGX0k/S2U9EbqnkgI5Y3NIo9dHrKF/YmL/x8TWslwt6+/kosSfXqNohWJpr2PvK
 qmvjyw51gJVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="146348654"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="146348654"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 16:05:18 -0700
IronPort-SDR: w2tFuBjMM0CmMF7sj6Pd8ElrF6zCr9mSpqDsXtZpyAIydGLRU0blIg/X/lLMfFAH/ipbZTET/v
 lzYhVkc70HTw==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="300730203"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.209.53.173])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 16:05:17 -0700
Subject: Re: [PATCH v1 01/12] fpga: fpga security manager class driver
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-2-russell.h.weight@intel.com>
 <ebb5b52d-c296-478a-c970-a1845edb4de0@redhat.com>
 <ebf251a0-5f13-d1a1-6915-e3c940bb19fe@intel.com>
 <1753de1d-e8a0-ffa3-9e2a-350df926f5cd@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <4fefba96-a131-c29a-9c4d-9842b01e66aa@intel.com>
Date:   Thu, 10 Sep 2020 16:05:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1753de1d-e8a0-ffa3-9e2a-350df926f5cd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/10/20 2:51 PM, Tom Rix wrote:
> On 9/10/20 1:22 PM, Russ Weight wrote:
>>     
>>
>> On 9/5/20 12:09 PM, Tom Rix wrote:
>>
>>    
>>
>>>       
>>> On 9/4/20 4:52 PM, Russ Weight wrote:
>>>       
>>>>         
>>>> Create the Intel Security Manager class driver. The security
>>>> manager provides interfaces to manage secure updates for the
>>>> FPGA and BMC images that are stored in FLASH. The driver can
>>>> also be used to update root entry hashes and to cancel code
>>>> signing keys.
>>>>
>>>> This patch creates the class driver and provides sysfs
>>>> interfaces for displaying root entry hashes, canceled code
>>>> signing keys and flash counts.
>>>>
>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>>> ---
>>>>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  75 ++++
>>>>  MAINTAINERS                                   |   8 +
>>>>  drivers/fpga/Kconfig                          |   9 +
>>>>  drivers/fpga/Makefile                         |   3 +
>>>>  drivers/fpga/ifpga-sec-mgr.c                  | 339 ++++++++++++++++++
>>>>  include/linux/fpga/ifpga-sec-mgr.h            | 145 ++++++++
>>>>  6 files changed, 579 insertions(+)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>>>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>>>>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>>> new file mode 100644
>>>> index 000000000000..86f8992559bf
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>>> @@ -0,0 +1,75 @@
>>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/name
>>>> +Date:		Sep 2020
>>>> +KernelVersion:  5.10
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Name of low level fpga security manager driver.
>>>> +
>>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/sr_root_entry_hash
>>>> +Date:		Sep 2020
>>>> +KernelVersion:  5.10
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Read only. Returns the root entry hash for the static
>>>> +		region if one is programmed, else it returns the
>>>> +		string: "hash not programmed".  This file is only
>>>> +		visible if the underlying device supports it.
>>>> +		Format: "0x%x".
>>>> +
>>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/pr_root_entry_hash
>>>> +Date:		Sep 2020
>>>> +KernelVersion:  5.10
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Read only. Returns the root entry hash for the partial
>>>> +		reconfiguration region if one is programmed, else it
>>>> +		returns the string: "hash not programmed".  This file
>>>> +		is only visible if the underlying device supports it.
>>>> +		Format: "0x%x".
>>>> +
>>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/bmc_root_entry_hash
>>>> +Date:		Sep 2020
>>>> +KernelVersion:  5.10
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Read only. Returns the root entry hash for the BMC image
>>>> +		if one is programmed, else it returns the string:
>>>> +		"hash not programmed".  This file is only visible if the
>>>> +		underlying device supports it.
>>>> +		Format: "0x%x".
>>>> +
>>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/sr_canceled_csks
>>>> +Date:		Sep 2020
>>>> +KernelVersion:  5.10
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Read only. Returns a list of indices for canceled code
>>>> +		signing keys for the static region. The standard bitmap
>>>> +		list format is used (e.g. "1,2-6,9").
>>>> +
>>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/pr_canceled_csks
>>>> +Date:		Sep 2020
>>>> +KernelVersion:  5.10
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Read only. Returns a list of indices for canceled code
>>>> +		signing keys for the partial reconfiguration region. The
>>>> +		standard bitmap list format is used (e.g. "1,2-6,9").
>>>> +
>>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/bmc_canceled_csks
>>>> +Date:		Sep 2020
>>>> +KernelVersion:  5.10
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Read only. Returns a list of indices for canceled code
>>>> +		signing keys for the BMC.  The standard bitmap list format
>>>> +		is used (e.g. "1,2-6,9").
>>>> +
>>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/user_flash_count
>>>> +Date:		Sep 2020
>>>> +KernelVersion:  5.10
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Read only. Returns number of times the user image for the
>>>> +		static region has been flashed.
>>>> +		Format: "%d".
>>>>       
>>>       
>>> could this be %u ?
>>>     
>> Yes - I'll make the change for both of the flash update counts.
>>
>>>       
>>>>         
>>>> +
>>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/bmc_flash_count
>>>> +Date:		Sep 2020
>>>> +KernelVersion:  5.10
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Read only. Returns number of times the BMC image has been
>>>> +		flashed.
>>>> +		Format: "%d".
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index deaafb617361..4a2ebe6b120d 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -6830,6 +6830,14 @@ F:	Documentation/fpga/
>>>>  F:	drivers/fpga/
>>>>  F:	include/linux/fpga/
>>>>  
>>>> +INTEL FPGA SECURITY MANAGER DRIVERS
>>>> +M:	Russ Weight <russell.h.weight@intel.com>
>>>> +L:	linux-fpga@vger.kernel.org
>>>> +S:	Maintained
>>>> +F:	Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>>> +F:	drivers/fpga/ifpga-sec-mgr.c
>>>> +F:	include/linux/fpga/ifpga-sec-mgr.h
>>>> +
>>>>  FPU EMULATOR
>>>>  M:	Bill Metzenthen <billm@melbpc.org.au>
>>>>  S:	Maintained
>>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>>>> index 88f64fbf55e3..97c0a6cc2ba7 100644
>>>> --- a/drivers/fpga/Kconfig
>>>> +++ b/drivers/fpga/Kconfig
>>>> @@ -235,4 +235,13 @@ config FPGA_MGR_ZYNQMP_FPGA
>>>>  	  to configure the programmable logic(PL) through PS
>>>>  	  on ZynqMP SoC.
>>>>  
>>>> +config IFPGA_SEC_MGR
>>>> +	tristate "Intel Security Manager for FPGA"
>>>> +        help
>>>> +	  The Intel Security Manager class driver presents a common
>>>> +	  user API for managing secure updates for Intel FPGA
>>>> +	  devices, including flash images for the FPGA static
>>>> +	  region and for the BMC. Select this option to enable
>>>> +	  updates for secure FPGA devices.
>>>> +
>>>>  endif # FPGA
>>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>>>> index c69bfc931519..ec9fbacdedd8 100644
>>>> --- a/drivers/fpga/Makefile
>>>> +++ b/drivers/fpga/Makefile
>>>> @@ -21,6 +21,9 @@ obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>>>>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>>>>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>>>  
>>>> +# Intel FPGA Security Manager Framework
>>>> +obj-$(CONFIG_IFPGA_SEC_MGR)		+= ifpga-sec-mgr.o
>>>> +
>>>>  # FPGA Bridge Drivers
>>>>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>>>>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>>>> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
>>>> new file mode 100644
>>>> index 000000000000..97bf80277ed2
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/ifpga-sec-mgr.c
>>>> @@ -0,0 +1,339 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Intel Security Manager for FPGA
>>>> + *
>>>> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
>>>> + */
>>>> +
>>>> +#include <linux/fpga/ifpga-sec-mgr.h>
>>>> +#include <linux/idr.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/vmalloc.h>
>>>> +
>>>> +static DEFINE_IDA(ifpga_sec_mgr_ida);
>>>> +static struct class *ifpga_sec_mgr_class;
>>>> +
>>>> +static ssize_t show_canceled_csk(struct ifpga_sec_mgr *imgr,
>>>> +				 sysfs_csk_hndlr_t get_csk,
>>>> +				 sysfs_csk_nbits_t get_csk_nbits,
>>>>       
>>>       
>>> Param 2&3 can be accessed by imgr->iops so the signature
>>>
>>> of this and similar functions should be reduced.
>>>     
>> There are three different types of CSK vectors (sr, pr, and bmc).
>> For each type, there are two function pointers. When calling
>> show_canceled_csk, it is necessary to identify the type of CSK.
>> While it is true that all three pairs of pointers are in imgr->iops,
>> I think the easiest way to identify the CSK type is by passing in
>> the appropriate pair of pointers.
> ok.
>>>       
>>>       
>>>>         
>>>> +				 char *buf)
>>>> +{
>>>> +	unsigned long *csk_map = NULL;
>>>> +	unsigned int nbits;
>>>> +	int cnt, ret;
>>>> +
>>>> +	ret = get_csk_nbits(imgr);
>>>>       
>>>       
>>> Any access to a function pointer must check if the
>>>
>>> the pointer is valid.
>>>     
>> The pointers are all validated when a device driver registers with the class
>> driver. The corresponding CSK sysfs file will only be visible if the pointers
>> have been validated. Is that sufficient, or should I add a redundant check
>> here? I don't mind doing it if you think it is needed.
> ok, fine as-is.
>>>       
>>>       
>>>>         
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	nbits = (unsigned int)ret;
>>>> +	csk_map = vmalloc(sizeof(unsigned long) * BITS_TO_LONGS(nbits));
>>>> +	if (!csk_map)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	ret = get_csk(imgr, csk_map, nbits);
>>>>       
>>>       
>>> The type of returned by get_csk_nbits and its use should
>>>
>>> be consistent. likely this is 'int'
>> The CSK data is returned using memory provided by the csk_map pointer parameter. The
>> return value is an integer value and provides error/success status. Do you think
>> something should be changed here?
> Later i comment on how the error code duplicate standard error codes.
>
> It would be good the standard codes could be used, part of that
>
> is returning int.

get_csk_nbits() _does_ return int.
 

>>>       
>>>>         
>>>> +	if (ret)
>>>> +		goto vfree_exit;
>>>> +
>>>> +	cnt = bitmap_print_to_pagebuf(1, buf, csk_map, nbits);
>>>>       
>>>       
>>> simplify to
>>>
>>> ret = ..
>> Sure - I will do that.
>>
>>>       
>>>>         
>>>> +
>>>> +vfree_exit:
>>>> +	vfree(csk_map);
>>>> +	return ret ? : cnt;
>>>> +}
>>>> +
>>>> +static ssize_t show_root_entry_hash(struct ifpga_sec_mgr *imgr,
>>>> +				    sysfs_reh_hndlr_t get_reh,
>>>> +				    sysfs_reh_size_t get_reh_size,
>>>> +				    char *buf)
>>>> +{
>>>> +	unsigned int size, i;
>>>> +	int ret, cnt = 0;
>>>> +	u8 *hash;
>>>> +
>>>> +	ret = get_reh_size(imgr);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +	else if (!ret)
>>>> +		return sprintf(buf, "hash not programmed\n");
>>>> +
>>>> +	size = (unsigned int)ret;
>>>>       
>>>       
>>> does size and i need to unsigned?
>> In the context of their usage here, they should never be negative. Sizes are
>> typically unsigned, right? Would there be a reason to prefer int over unsigned?
> My issue is specifically the typecast. It would be good
>
> if the typecast could be removed.

OK - I can change the types so that the typecast can be dropped.

>
>>>       
>>>>         
>>>> +	hash = vmalloc(size);
>>>> +	if (!hash)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	ret = get_reh(imgr, hash, size);
>>>> +	if (ret)
>>>> +		goto vfree_exit;
>>>>       
>>>       
>>> ret is 0 here
>>>
>>> so simplify replacing cnt with ret.
>> Is the goal to have less variables? It seems like a trade-off with readability...
>>
>> I can make this change.
> The next comment/change will makes this comment superfluous.
>
> ignore it. 
>
>>>       
>>>>         
>>>> +
>>>> +	cnt += sprintf(buf, "0x");
>>>>       
>>>       
>>> or change += to =, this is the first time sprintf is done.
>> Sure - I 'll just do the assignment instead if initializing to zero.
>>
>>>       
>>>>         
>>>> +	for (i = 0; i < size; i++)
>>>> +		cnt += sprintf(buf + cnt, "%02x", hash[i]);
>>>> +	cnt += sprintf(buf + cnt, "\n");
>>>> +
>>>> +vfree_exit:
>>>> +	vfree(hash);
>>>> +	return ret ? : cnt;
>>>>       
>>>       
>>> with simplification this should be
>>>
>>> return ret;
>>>
>>>       
>>>>         
>>>> +}
>>>> +
>>>> +#define to_sec_mgr(d) container_of(d, struct ifpga_sec_mgr, dev)
>>>>       
>>>       
>>> Since this is used widely move closer to top of file.
>> OK
>>
>>>       
>>>>         
>>>> +
>>>> +#define DEVICE_ATTR_SEC_CSK(_name) \
>>>> +static ssize_t _name##_canceled_csks_show(struct device *dev, \
>>>> +					  struct device_attribute *attr, \
>>>> +					  char *buf) \
>>>> +{ \
>>>> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev); \
>>>> +	return show_canceled_csk(imgr, \
>>>> +	       imgr->iops->_name##_canceled_csks, \
>>>> +	       imgr->iops->_name##_canceled_csk_nbits, buf); \
>>>> +} \
>>>> +static DEVICE_ATTR_RO(_name##_canceled_csks)
>>>> +
>>>> +#define DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(_name) \
>>>> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
>>>> +				     struct device_attribute *attr, \
>>>> +				     char *buf) \
>>>> +{ \
>>>> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev); \
>>>> +	return show_root_entry_hash(imgr, \
>>>> +	       imgr->iops->_name##_root_entry_hash, \
>>>> +	       imgr->iops->_name##_reh_size, buf); \
>>>> +} \
>>>> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
>>>> +
>>>> +#define DEVICE_ATTR_SEC_FLASH_CNT(_name) \
>>>> +static ssize_t _name##_flash_count_show(struct device *dev, \
>>>> +		    struct device_attribute *attr, char *buf) \
>>>> +{ \
>>>> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev); \
>>>> +	int cnt = imgr->iops->_name##_flash_count(imgr); \
>>>> +	return cnt < 0 ? cnt : sprintf(buf, "%d\n", cnt); \
>>>> +} \
>>>> +static DEVICE_ATTR_RO(_name##_flash_count)
>>>> +
>>>> +DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(sr);
>>>> +DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(pr);
>>>> +DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(bmc);
>>>> +DEVICE_ATTR_SEC_FLASH_CNT(user);
>>>> +DEVICE_ATTR_SEC_FLASH_CNT(bmc);
>>>> +DEVICE_ATTR_SEC_CSK(sr);
>>>> +DEVICE_ATTR_SEC_CSK(pr);
>>>> +DEVICE_ATTR_SEC_CSK(bmc);
>>>> +
>>>> +static struct attribute *sec_mgr_security_attrs[] = {
>>>> +	&dev_attr_user_flash_count.attr,
>>>> +	&dev_attr_bmc_flash_count.attr,
>>>> +	&dev_attr_bmc_root_entry_hash.attr,
>>>> +	&dev_attr_sr_root_entry_hash.attr,
>>>> +	&dev_attr_pr_root_entry_hash.attr,
>>>> +	&dev_attr_sr_canceled_csks.attr,
>>>> +	&dev_attr_pr_canceled_csks.attr,
>>>> +	&dev_attr_bmc_canceled_csks.attr,
>>>> +	NULL,
>>>> +};
>>>> +
>>>> +#define check_attr(attribute, _name) \
>>>> +	((attribute) == &dev_attr_##_name.attr && imgr->iops->_name)
>>>> +
>>>> +static umode_t sec_mgr_visible(struct kobject *kobj,
>>>> +			       struct attribute *attr, int n)
>>>> +{
>>>> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(kobj_to_dev(kobj));
>>>> +
>>>> +	if (check_attr(attr, user_flash_count) ||
>>>> +	    check_attr(attr, bmc_flash_count) ||
>>>> +	    check_attr(attr, bmc_root_entry_hash) ||
>>>> +	    check_attr(attr, sr_root_entry_hash) ||
>>>> +	    check_attr(attr, pr_root_entry_hash) ||
>>>> +	    check_attr(attr, sr_canceled_csks) ||
>>>> +	    check_attr(attr, pr_canceled_csks) ||
>>>> +	    check_attr(attr, bmc_canceled_csks))
>>>> +		return attr->mode;
>>>> +
>>>>       
>>>       
>>> This is all or nothing, shouldn't the interface
>>>
>>> allow for null iop ?
>> All or nothing? Each of the above attributes is optional and is enabled by
>> providing a handler function. This is the "is_visible" op for sysfs and it
>> ensures that only the enabled sysfs entries are displayed (any combination
>> of enabled sysfs files).
>>
>> While these operations are all optional, there are some required operations in iops
>> for the update process (in a later patch), so for the overall patchset iops
>> cannot be NULL.
> Ok. then add a comment.

Will do.

>>>       
>>>>         
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static struct attribute_group sec_mgr_security_attr_group = {
>>>> +	.name = "security",
>>>> +	.attrs = sec_mgr_security_attrs,
>>>> +	.is_visible = sec_mgr_visible,
>>>> +};
>>>> +
>>>> +static ssize_t name_show(struct device *dev,
>>>> +			 struct device_attribute *attr, char *buf)
>>>> +{
>>>> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>>>> +
>>>> +	return sprintf(buf, "%s\n", imgr->name);
>>>> +}
>>>> +static DEVICE_ATTR_RO(name);
>>>> +
>>>> +static struct attribute *sec_mgr_attrs[] = {
>>>> +	&dev_attr_name.attr,
>>>> +	NULL,
>>>> +};
>>>> +
>>>> +static struct attribute_group sec_mgr_attr_group = {
>>>> +	.attrs = sec_mgr_attrs,
>>>> +};
>>>> +
>>>> +static const struct attribute_group *ifpga_sec_mgr_attr_groups[] = {
>>>> +	&sec_mgr_attr_group,
>>>> +	&sec_mgr_security_attr_group,
>>>> +	NULL,
>>>> +};
>>>> +
>>>> +static bool check_sysfs_handler(struct device *dev,
>>>> +				void *sysfs_handler, void *size_handler,
>>>> +				const char *sysfs_handler_name,
>>>> +				const char *size_handler_name)
>>>> +{
>>>> +	if (sysfs_handler) {
>>>>       
>>>       
>>> These two checks can be simplified to
>>>
>>> if (!sysfs_handler || !size_handler)
>> That would require changes to the "else if" condition that follows, which
>> assumes that syfs_handler is null. The purpose of this block of code is
>> to ensure that if the size_handler or the sysfs_handler is defined, that
>> they are both defined. It is OK if they are both undefined.
>>
>> If you wanted to reduce the code, I think we could do something like this, but
>> but I'm afraid it might be confusing and less readable.
>>
>> if (!!size_handler != !!sysfs_handler) {
>> 	dev_err(dev, "%s and %s must both be registered to enable the sysfs file\n",
>> 		size_handler_name, sysfs_handler_name);
>> 	return false;
>> }
>>
>> What do you think?
> The more creative uses of '!' the better. ;)
>
> This is fine as-is, maybe add a comment.
>
>>>       
>>>>         
>>>> +		if (!size_handler) {
>>>> +			dev_err(dev, "%s registered without %s\n",
>>>> +				sysfs_handler_name, size_handler_name);
>>>> +			return false;
>>>> +		}
>>>> +	} else if (size_handler) {
>>>> +		dev_err(dev, "%s registered without %s\n",
>>>> +			size_handler_name, sysfs_handler_name);
>>>> +		return false;
>>>> +	}
>>>> +	return true;
>>>> +}
>>>> +
>>>> +#define check_reh_handler(_dev, _iops, _name) \
>>>> +	check_sysfs_handler(_dev, (_iops)->_name##_root_entry_hash, \
>>>> +			    (_iops)->_name##_reh_size, \
>>>> +			    __stringify(_name##_root_entry_hash), \
>>>> +			    __stringify(_name##_reh_size))
>>>> +
>>>> +#define check_csk_handler(_dev, _iops, _name) \
>>>> +	check_sysfs_handler(_dev, (_iops)->_name##_canceled_csks, \
>>>> +			    (_iops)->_name##_canceled_csk_nbits, \
>>>> +			    __stringify(_name##_canceled_csks), \
>>>> +			    __stringify(_name##_canceled_csk_nbits))
>>>> +
>>>> +/**
>>>> + * ifpga_sec_mgr_register - register an IFPGA security manager struct
>>>> + *
>>>> + * @dev:  create ifpga security manager device from pdev
>>>> + * @name: ifpga security manager name
>>>> + * @iops: pointer to a structure of ifpga callback functions
>>>> + * @priv: ifpga security manager private data
>>>> + *
>>>> + * Returns &struct ifpga_sec_mgr pointer on success, or ERR_PTR() on error.
>>>> + */
>>>> +struct ifpga_sec_mgr *
>>>> +ifpga_sec_mgr_register(struct device *dev, const char *name,
>>>> +		       const struct ifpga_sec_mgr_ops *iops, void *priv)
>>>> +{
>>>> +	struct ifpga_sec_mgr *imgr;
>>>> +	int id, ret;
>>>> +
>>>> +	if (!check_reh_handler(dev, iops, bmc) ||
>>>> +	    !check_reh_handler(dev, iops, sr) ||
>>>> +	    !check_reh_handler(dev, iops, pr) ||
>>>> +	    !check_csk_handler(dev, iops, bmc) ||
>>>> +	    !check_csk_handler(dev, iops, sr) ||
>>>> +	    !check_csk_handler(dev, iops, pr)) {
>>>> +		return ERR_PTR(-EINVAL);
>>>> +	}
>>>> +
>>>> +	if (!name || !strlen(name)) {
>>>> +		dev_err(dev, "Attempt to register with no name!\n");
>>>> +		return ERR_PTR(-EINVAL);
>>>> +	}
>>>> +
>>>> +	imgr = kzalloc(sizeof(*imgr), GFP_KERNEL);
>>>> +	if (!imgr)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	imgr->name = name;
>>>>       
>>>       
>>> should name be dup-ed?
>> The name is string constant that is provided by the underlying device driver
>> (from the kernel space) so I don't think it would be necessary to dup the string.
> If the underlying driver unloads, the name ptr will be invalid.
>
> Will the driver unregister remove its use here ?
Yes. If the underlying driver is unloaded, it will unregister with the class driver.
>
>>>       
>>>>         
>>>> +	imgr->priv = priv;
>>>> +	imgr->iops = iops;
>>>> +	mutex_init(&imgr->lock);
>>>> +
>>>> +	id = ida_simple_get(&ifpga_sec_mgr_ida, 0, 0, GFP_KERNEL);
>>>> +	if (id < 0) {
>>>> +		ret = id;
>>>> +		goto exit_free;
>>>> +	}
>>>> +
>>>> +	imgr->dev.class = ifpga_sec_mgr_class;
>>>> +	imgr->dev.parent = dev;
>>>> +	imgr->dev.id = id;
>>>> +
>>>> +	ret = dev_set_name(&imgr->dev, "ifpga_sec%d", id);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Failed to set device name: ifpga_sec%d\n", id);
>>>> +		ida_simple_remove(&ifpga_sec_mgr_ida, id);
>>>> +		goto exit_free;
>>>> +	}
>>>> +
>>>> +	ret = device_register(&imgr->dev);
>>>> +	if (ret) {
>>>> +		put_device(&imgr->dev);
>>>> +		return ERR_PTR(ret);
>>>> +	}
>>>> +
>>>> +	return imgr;
>>>> +
>>>> +exit_free:
>>>> +	kfree(dev);
>>>> +	return ERR_PTR(ret);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(ifpga_sec_mgr_register);
>>>> +
>>>> +/**
>>>> + * ifpga_sec_mgr_unregister - unregister a IFPGA security manager
>>>> + *
>>>> + * @mgr: fpga manager struct
>>>> + *
>>>> + * This function is intended for use in a IFPGA security manager
>>>> + * driver's remove() function.
>>>> + */
>>>> +void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr)
>>>> +{
>>>> +	dev_info(&imgr->dev, "%s %s\n", __func__, imgr->name);
>>>> +
>>>> +	device_unregister(&imgr->dev);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(ifpga_sec_mgr_unregister);
>>>> +
>>>> +static void ifpga_sec_mgr_dev_release(struct device *dev)
>>>> +{
>>>> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>>>> +
>>>> +	mutex_destroy(&imgr->lock);
>>>> +	ida_simple_remove(&ifpga_sec_mgr_ida, imgr->dev.id);
>>>> +	kfree(imgr);
>>>> +}
>>>> +
>>>> +static int __init ifpga_sec_mgr_class_init(void)
>>>> +{
>>>> +	pr_info("Intel FPGA Security Manager\n");
>>>> +
>>>> +	ifpga_sec_mgr_class = class_create(THIS_MODULE, "ifpga_sec_mgr");
>>>> +	if (IS_ERR(ifpga_sec_mgr_class))
>>>> +		return PTR_ERR(ifpga_sec_mgr_class);
>>>> +
>>>> +	ifpga_sec_mgr_class->dev_groups = ifpga_sec_mgr_attr_groups;
>>>> +	ifpga_sec_mgr_class->dev_release = ifpga_sec_mgr_dev_release;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void __exit ifpga_sec_mgr_class_exit(void)
>>>> +{
>>>> +	class_destroy(ifpga_sec_mgr_class);
>>>> +	ida_destroy(&ifpga_sec_mgr_ida);
>>>> +}
>>>> +
>>>> +MODULE_DESCRIPTION("Intel FPGA Security Manager Driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> +
>>>> +subsys_initcall(ifpga_sec_mgr_class_init);
>>>> +module_exit(ifpga_sec_mgr_class_exit)
>>>> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
>>>> new file mode 100644
>>>> index 000000000000..e391b0c8f448
>>>> --- /dev/null
>>>> +++ b/include/linux/fpga/ifpga-sec-mgr.h
>>>> @@ -0,0 +1,145 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Header file for Intel FPGA Security Manager
>>>> + *
>>>> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
>>>> + */
>>>> +#ifndef _LINUX_IFPGA_SEC_MGR_H
>>>> +#define _LINUX_IFPGA_SEC_MGR_H
>>>> +
>>>> +#include <linux/device.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/types.h>
>>>> +
>>>> +struct ifpga_sec_mgr;
>>>> +
>>>> +/**
>>>> + * typedef sysfs_reh_size_t - Function to return byte size of root entry hash
>>>> + *
>>>> + * @imgr:      pointer to security manager structure
>>>> + *
>>>> + * This datatype is used to define a function that returns the byte size of a
>>>> + * root entry hash.
>>>> + *
>>>> + * Context: No locking requirements are imposed by the security manager.
>>>> + * Return:  Byte count on success, negative errno on failure
>>>> + */
>>>> +typedef int (*sysfs_reh_size_t)(struct ifpga_sec_mgr *imgr);
>>>> +
>>>> +/**
>>>> + * typedef sysfs_reh_hndlr_t - Function pointer to sysfs file handler
>>>> + *			       for root entry hashes
>>>> + * @imgr:      pointer to security manager structure
>>>> + * @hash:      pointer to an array of bytes in which to store the hash
>>>> + * @size:      byte size of root entry hash
>>>> + *
>>>> + * This datatype is used to define a sysfs file handler function to
>>>> + * return root entry hash data to be displayed via sysfs.
>>>> + *
>>>> + * Context: No locking requirements are imposed by the security manager.
>>>> + * Return:  0 on success, negative errno on failure
>>>> + */
>>>> +typedef int (*sysfs_reh_hndlr_t)(struct ifpga_sec_mgr *imgr, u8 *hash,
>>>> +				 unsigned int size);
>>>> +
>>>> +/**
>>>> + * typedef sysfs_cnt_hndlr_t - Function pointer to sysfs file handler
>>>> + *			       for flash counts
>>>> + * @imgr: pointer to security manager structure
>>>> + *
>>>> + * This datatype is used to define a sysfs file handler function to
>>>> + * return a flash count to be displayed via sysfs.
>>>> + *
>>>> + * Context: No locking requirements are imposed by the security manager
>>>> + * Return: flash count or negative errno
>>>> + */
>>>> +typedef int (*sysfs_cnt_hndlr_t)(struct ifpga_sec_mgr *imgr);
>>>> +
>>>> +/**
>>>> + * typedef sysfs_csk_nbits_t - Function to return the number of bits in
>>>> + *				      a Code Signing Key cancellation vector
>>>> + *
>>>> + * @imgr:      pointer to security manager structure
>>>> + *
>>>> + * This datatype is used to define a function that returns the number of bits
>>>> + * in a Code Signing Key cancellation vector.
>>>> + *
>>>> + * Context: No locking requirements are imposed by the security manager.
>>>> + * Return:  Number of bits on success, negative errno on failure
>>>> + */
>>>> +typedef int (*sysfs_csk_nbits_t)(struct ifpga_sec_mgr *imgr);
>>>> +
>>>> +/**
>>>> + * typedef sysfs_csk_hndlr_t - Function pointer to sysfs file handler
>>>> + *			       bit vector of canceled keys
>>>> + *
>>>> + * @imgr:    pointer to security manager structure
>>>> + * @csk_map: pointer to a bitmap to contain cancellation key vector
>>>> + * @nbits:   number of bits in CSK vector
>>>> + *
>>>> + * This datatype is used to define a sysfs file handler function to
>>>> + * return a bitmap of canceled keys to be displayed via sysfs.
>>>> + *
>>>> + * Context: No locking requirements are imposed by the security manager.
>>>> + * Return:  0 on success, negative errno on failure
>>>> + */
>>>> +typedef int (*sysfs_csk_hndlr_t)(struct ifpga_sec_mgr *imgr,
>>>> +				 unsigned long *csk_map, unsigned int nbits);
>>>> +
>>>> +/**
>>>> + * struct ifpga_sec_mgr_ops - device specific operations
>>>> + * @user_flash_count:	    Optional: Return sysfs string output for FPGA
>>>> + *			    image flash count
>>>> + * @bmc_flash_count:	    Optional: Return sysfs string output for BMC
>>>> + *			    image flash count
>>>> + * @sr_root_entry_hash:	    Optional: Return sysfs string output for static
>>>> + *			    region root entry hash
>>>> + * @pr_root_entry_hash:	    Optional: Return sysfs string output for partial
>>>> + *			    reconfiguration root entry hash
>>>> + * @bmc_root_entry_hash:    Optional: Return sysfs string output for BMC
>>>> + *			    root entry hash
>>>> + * @sr_canceled_csks:	    Optional: Return sysfs string output for static
>>>> + *			    region canceled keys
>>>> + * @pr_canceled_csks:	    Optional: Return sysfs string output for partial
>>>> + *			    reconfiguration canceled keys
>>>> + * @bmc_canceled_csks:	    Optional: Return sysfs string output for bmc
>>>> + *			    canceled keys
>>>> + * @bmc_canceled_csk_nbits: Optional: Return BMC canceled csk vector bit count
>>>> + * @sr_canceled_csk_nbits:  Optional: Return SR canceled csk vector bit count
>>>> + * @pr_canceled_csk_nbits:  Optional: Return PR canceled csk vector bit count
>>>> + * @bmc_reh_size:	    Optional: Return byte size for BMC root entry hash
>>>> + * @sr_reh_size:	    Optional: Return byte size for SR root entry hash
>>>> + * @pr_reh_size:	    Optional: Return byte size for PR root entry hash
>>>> + */
>>>> +struct ifpga_sec_mgr_ops {
>>>> +	sysfs_cnt_hndlr_t user_flash_count;
>>>>       
>>>       
>>> These typedef's hide the function signatures and are
>>>
>>> not consistent with how the other headers in include/linux/fpga
>>>
>>> specify ops.
>> OK - I can remove the typedefs.
>>
>>>       
>>>>         
>>>> +	sysfs_cnt_hndlr_t bmc_flash_count;
>>>> +	sysfs_cnt_hndlr_t smbus_flash_count;
>>>> +	sysfs_reh_hndlr_t sr_root_entry_hash;
>>>> +	sysfs_reh_hndlr_t pr_root_entry_hash;
>>>> +	sysfs_reh_hndlr_t bmc_root_entry_hash;
>>>> +	sysfs_csk_hndlr_t sr_canceled_csks;
>>>> +	sysfs_csk_hndlr_t pr_canceled_csks;
>>>> +	sysfs_csk_hndlr_t bmc_canceled_csks;
>>>> +	sysfs_reh_size_t bmc_reh_size;
>>>> +	sysfs_reh_size_t sr_reh_size;
>>>> +	sysfs_reh_size_t pr_reh_size;
>>>> +	sysfs_csk_nbits_t bmc_canceled_csk_nbits;
>>>> +	sysfs_csk_nbits_t sr_canceled_csk_nbits;
>>>> +	sysfs_csk_nbits_t pr_canceled_csk_nbits;
>>>> +};
>>>> +
>>>> +struct ifpga_sec_mgr {
>>>> +	const char *name;
>>>> +	struct device dev;
>>>> +	const struct ifpga_sec_mgr_ops *iops;
>>>> +	struct mutex lock;		/* protect data structure contents */
>>>>       
>>>       
>>> comment is redundant for a lock.
>> "scripts/checkpatch.pl --strict" will complain about mutex definitions that do not
>> have a comment. Are you asking for a more descriptive comment? Or are you saying
>> that the comment is not required?
> Fine as-is.
>
> If checkpatch wants it, just do it.
>
> Tom
>
>>> Tom
>>>
>>>       
>>>>         
>>>> +	void *priv;
>>>> +};
>>>> +
>>>> +struct ifpga_sec_mgr *
>>>> +ifpga_sec_mgr_register(struct device *dev, const char *name,
>>>> +		       const struct ifpga_sec_mgr_ops *iops, void *priv);
>>>> +void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr);
>>>> +
>>>> +#endif
>>>>       
>>>     

