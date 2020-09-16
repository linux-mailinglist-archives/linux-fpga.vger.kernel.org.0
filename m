Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0511A26CAF3
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Sep 2020 22:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgIPUQS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Sep 2020 16:16:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40585 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgIPUQI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Sep 2020 16:16:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id j34so4533840pgi.7;
        Wed, 16 Sep 2020 13:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fLFA7OCLR4Wr3MPVy9CjGpYYuGxOzeDnGLxnNOAKQfw=;
        b=jhLqHsmYYZexeKTNhDeQGhfLdbCOpSWDor6/oxQdXM2mLZM+jqLXC/0ZDmnFHIvLMD
         AkinOmrBC7aTxHBRrMZJbSAoC3aEi6Kgl2KyInko8O+X18SgHF8WdFAUfY7gSw/2cnYE
         LLBXeR8QrlMGE48uiwk0sdJuhZt7R269JERzrngXGn73XQYy9I2BOsyHFuWCTx66rSUk
         qi7bNFaPSJDD4OST5n8WuEZ4gEzCShouGkQljy9B0oB/n5qcHTUlocOtBoptI6gXHTqQ
         +8daZ1DVZfZHWAMadlVseCfYSGCQLSS815xZVcW6VnR622NT3zmFTZ61Njv+nYFD2QK6
         6qYA==
X-Gm-Message-State: AOAM530jvIUEjJxeUOBjyVQb6LCbKVXZgLolGK4UMxZz+EXZXRyvgviB
        byMyrRoOvITL49ibYZxfVEs=
X-Google-Smtp-Source: ABdhPJyDOXWrd1zFD7rssBS/4Qw+wRw9/SLU6ixB2dggOCpNtrcDKFkz4iRfM0xTBAxFWoFkKFIP+w==
X-Received: by 2002:a63:f606:: with SMTP id m6mr19994892pgh.193.1600287366809;
        Wed, 16 Sep 2020 13:16:06 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id a15sm17997279pfi.119.2020.09.16.13.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 13:16:06 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:16:04 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v1 01/12] fpga: fpga security manager class driver
Message-ID: <20200916201604.GA1076460@epycbox.lan>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904235305.6254-2-russell.h.weight@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

On Fri, Sep 04, 2020 at 04:52:54PM -0700, Russ Weight wrote:
> Create the Intel Security Manager class driver. The security
> manager provides interfaces to manage secure updates for the
> FPGA and BMC images that are stored in FLASH. The driver can
> also be used to update root entry hashes and to cancel code
> signing keys.
> 
> This patch creates the class driver and provides sysfs
> interfaces for displaying root entry hashes, canceled code
> signing keys and flash counts.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  75 ++++
>  MAINTAINERS                                   |   8 +
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/ifpga-sec-mgr.c                  | 339 ++++++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            | 145 ++++++++
>  6 files changed, 579 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> new file mode 100644
> index 000000000000..86f8992559bf
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> @@ -0,0 +1,75 @@
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/name
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Name of low level fpga security manager driver.
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/sr_root_entry_hash
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the static
> +		region if one is programmed, else it returns the
> +		string: "hash not programmed".  This file is only
> +		visible if the underlying device supports it.
> +		Format: "0x%x".
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/pr_root_entry_hash
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the partial
> +		reconfiguration region if one is programmed, else it
> +		returns the string: "hash not programmed".  This file
> +		is only visible if the underlying device supports it.
> +		Format: "0x%x".
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/bmc_root_entry_hash
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the BMC image
> +		if one is programmed, else it returns the string:
> +		"hash not programmed".  This file is only visible if the
> +		underlying device supports it.
> +		Format: "0x%x".
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/sr_canceled_csks
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the static region. The standard bitmap
> +		list format is used (e.g. "1,2-6,9").
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/pr_canceled_csks
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the partial reconfiguration region. The
> +		standard bitmap list format is used (e.g. "1,2-6,9").
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/bmc_canceled_csks
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the BMC.  The standard bitmap list format
> +		is used (e.g. "1,2-6,9").
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/user_flash_count
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns number of times the user image for the
> +		static region has been flashed.
> +		Format: "%d".
> +
> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/security/bmc_flash_count
> +Date:		Sep 2020
> +KernelVersion:  5.10
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns number of times the BMC image has been
> +		flashed.
> +		Format: "%d".
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..4a2ebe6b120d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6830,6 +6830,14 @@ F:	Documentation/fpga/
>  F:	drivers/fpga/
>  F:	include/linux/fpga/
>  
> +INTEL FPGA SECURITY MANAGER DRIVERS
> +M:	Russ Weight <russell.h.weight@intel.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
> +F:	drivers/fpga/ifpga-sec-mgr.c
> +F:	include/linux/fpga/ifpga-sec-mgr.h

Actually, ignore my previous comment, feel free to leave this in.
> +
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
>  S:	Maintained
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 88f64fbf55e3..97c0a6cc2ba7 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -235,4 +235,13 @@ config FPGA_MGR_ZYNQMP_FPGA
>  	  to configure the programmable logic(PL) through PS
>  	  on ZynqMP SoC.
>  
> +config IFPGA_SEC_MGR
> +	tristate "Intel Security Manager for FPGA"
> +        help
> +	  The Intel Security Manager class driver presents a common
> +	  user API for managing secure updates for Intel FPGA
> +	  devices, including flash images for the FPGA static
> +	  region and for the BMC. Select this option to enable
> +	  updates for secure FPGA devices.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index c69bfc931519..ec9fbacdedd8 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -21,6 +21,9 @@ obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>  
> +# Intel FPGA Security Manager Framework
> +obj-$(CONFIG_IFPGA_SEC_MGR)		+= ifpga-sec-mgr.o
> +
>  # FPGA Bridge Drivers
>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
> new file mode 100644
> index 000000000000..97bf80277ed2
> --- /dev/null
> +++ b/drivers/fpga/ifpga-sec-mgr.c
> @@ -0,0 +1,339 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Security Manager for FPGA
> + *
> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> + */
> +
> +#include <linux/fpga/ifpga-sec-mgr.h>
> +#include <linux/idr.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +
> +static DEFINE_IDA(ifpga_sec_mgr_ida);
> +static struct class *ifpga_sec_mgr_class;
> +
> +static ssize_t show_canceled_csk(struct ifpga_sec_mgr *imgr,
> +				 sysfs_csk_hndlr_t get_csk,
> +				 sysfs_csk_nbits_t get_csk_nbits,
> +				 char *buf)
> +{
> +	unsigned long *csk_map = NULL;
> +	unsigned int nbits;
> +	int cnt, ret;
> +
> +	ret = get_csk_nbits(imgr);
> +	if (ret < 0)
> +		return ret;
> +
> +	nbits = (unsigned int)ret;
> +	csk_map = vmalloc(sizeof(unsigned long) * BITS_TO_LONGS(nbits));
> +	if (!csk_map)
> +		return -ENOMEM;
> +
> +	ret = get_csk(imgr, csk_map, nbits);
> +	if (ret)
> +		goto vfree_exit;
> +
> +	cnt = bitmap_print_to_pagebuf(1, buf, csk_map, nbits);
> +
> +vfree_exit:
> +	vfree(csk_map);
> +	return ret ? : cnt;
> +}
> +
> +static ssize_t show_root_entry_hash(struct ifpga_sec_mgr *imgr,
> +				    sysfs_reh_hndlr_t get_reh,
> +				    sysfs_reh_size_t get_reh_size,
> +				    char *buf)
> +{
> +	unsigned int size, i;
> +	int ret, cnt = 0;
> +	u8 *hash;
> +
> +	ret = get_reh_size(imgr);
> +	if (ret < 0)
> +		return ret;
> +	else if (!ret)
> +		return sprintf(buf, "hash not programmed\n");
> +
> +	size = (unsigned int)ret;
> +	hash = vmalloc(size);
> +	if (!hash)
> +		return -ENOMEM;
> +
> +	ret = get_reh(imgr, hash, size);
> +	if (ret)
> +		goto vfree_exit;
> +
> +	cnt += sprintf(buf, "0x");
> +	for (i = 0; i < size; i++)
> +		cnt += sprintf(buf + cnt, "%02x", hash[i]);
> +	cnt += sprintf(buf + cnt, "\n");
> +
> +vfree_exit:
> +	vfree(hash);
> +	return ret ? : cnt;
> +}
> +
> +#define to_sec_mgr(d) container_of(d, struct ifpga_sec_mgr, dev)
> +
> +#define DEVICE_ATTR_SEC_CSK(_name) \
> +static ssize_t _name##_canceled_csks_show(struct device *dev, \
> +					  struct device_attribute *attr, \
> +					  char *buf) \
> +{ \
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev); \
> +	return show_canceled_csk(imgr, \
> +	       imgr->iops->_name##_canceled_csks, \
> +	       imgr->iops->_name##_canceled_csk_nbits, buf); \
> +} \
> +static DEVICE_ATTR_RO(_name##_canceled_csks)
> +
> +#define DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(_name) \
> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
> +				     struct device_attribute *attr, \
> +				     char *buf) \
> +{ \
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev); \
> +	return show_root_entry_hash(imgr, \
> +	       imgr->iops->_name##_root_entry_hash, \
> +	       imgr->iops->_name##_reh_size, buf); \
> +} \
> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
> +
> +#define DEVICE_ATTR_SEC_FLASH_CNT(_name) \
> +static ssize_t _name##_flash_count_show(struct device *dev, \
> +		    struct device_attribute *attr, char *buf) \
> +{ \
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev); \
> +	int cnt = imgr->iops->_name##_flash_count(imgr); \
> +	return cnt < 0 ? cnt : sprintf(buf, "%d\n", cnt); \
> +} \
> +static DEVICE_ATTR_RO(_name##_flash_count)
> +
> +DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(sr);
> +DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(pr);
> +DEVICE_ATTR_SEC_ROOT_ENTRY_HASH(bmc);
> +DEVICE_ATTR_SEC_FLASH_CNT(user);
> +DEVICE_ATTR_SEC_FLASH_CNT(bmc);
> +DEVICE_ATTR_SEC_CSK(sr);
> +DEVICE_ATTR_SEC_CSK(pr);
> +DEVICE_ATTR_SEC_CSK(bmc);
> +
> +static struct attribute *sec_mgr_security_attrs[] = {
> +	&dev_attr_user_flash_count.attr,
> +	&dev_attr_bmc_flash_count.attr,
> +	&dev_attr_bmc_root_entry_hash.attr,
> +	&dev_attr_sr_root_entry_hash.attr,
> +	&dev_attr_pr_root_entry_hash.attr,
> +	&dev_attr_sr_canceled_csks.attr,
> +	&dev_attr_pr_canceled_csks.attr,
> +	&dev_attr_bmc_canceled_csks.attr,
> +	NULL,
> +};
> +
> +#define check_attr(attribute, _name) \
> +	((attribute) == &dev_attr_##_name.attr && imgr->iops->_name)
> +
> +static umode_t sec_mgr_visible(struct kobject *kobj,
> +			       struct attribute *attr, int n)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(kobj_to_dev(kobj));
> +
> +	if (check_attr(attr, user_flash_count) ||
> +	    check_attr(attr, bmc_flash_count) ||
> +	    check_attr(attr, bmc_root_entry_hash) ||
> +	    check_attr(attr, sr_root_entry_hash) ||
> +	    check_attr(attr, pr_root_entry_hash) ||
> +	    check_attr(attr, sr_canceled_csks) ||
> +	    check_attr(attr, pr_canceled_csks) ||
> +	    check_attr(attr, bmc_canceled_csks))
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
> +static struct attribute_group sec_mgr_security_attr_group = {
> +	.name = "security",
> +	.attrs = sec_mgr_security_attrs,
> +	.is_visible = sec_mgr_visible,
> +};
> +
> +static ssize_t name_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
> +
> +	return sprintf(buf, "%s\n", imgr->name);
> +}
> +static DEVICE_ATTR_RO(name);
> +
> +static struct attribute *sec_mgr_attrs[] = {
> +	&dev_attr_name.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group sec_mgr_attr_group = {
> +	.attrs = sec_mgr_attrs,
> +};
> +
> +static const struct attribute_group *ifpga_sec_mgr_attr_groups[] = {
> +	&sec_mgr_attr_group,
> +	&sec_mgr_security_attr_group,
> +	NULL,
> +};
> +
> +static bool check_sysfs_handler(struct device *dev,
> +				void *sysfs_handler, void *size_handler,
> +				const char *sysfs_handler_name,
> +				const char *size_handler_name)
> +{
> +	if (sysfs_handler) {
> +		if (!size_handler) {
> +			dev_err(dev, "%s registered without %s\n",
> +				sysfs_handler_name, size_handler_name);
> +			return false;
> +		}
> +	} else if (size_handler) {
> +		dev_err(dev, "%s registered without %s\n",
> +			size_handler_name, sysfs_handler_name);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +#define check_reh_handler(_dev, _iops, _name) \
> +	check_sysfs_handler(_dev, (_iops)->_name##_root_entry_hash, \
> +			    (_iops)->_name##_reh_size, \
> +			    __stringify(_name##_root_entry_hash), \
> +			    __stringify(_name##_reh_size))
> +
> +#define check_csk_handler(_dev, _iops, _name) \
> +	check_sysfs_handler(_dev, (_iops)->_name##_canceled_csks, \
> +			    (_iops)->_name##_canceled_csk_nbits, \
> +			    __stringify(_name##_canceled_csks), \
> +			    __stringify(_name##_canceled_csk_nbits))
> +

> +/**
> + * ifpga_sec_mgr_register - register an IFPGA security manager struct
> + *
> + * @dev:  create ifpga security manager device from pdev
Create or register? Consider splitting this into a create and a
register function.

Also it might be nice to have a devm_ifpga_create_sec_mgr /
ifpga_register_sec_mgr set.

> + * @name: ifpga security manager name
> + * @iops: pointer to a structure of ifpga callback functions
> + * @priv: ifpga security manager private data
> + *
> + * Returns &struct ifpga_sec_mgr pointer on success, or ERR_PTR() on error.
> + */
> +struct ifpga_sec_mgr *
> +ifpga_sec_mgr_register(struct device *dev, const char *name,
> +		       const struct ifpga_sec_mgr_ops *iops, void *priv)
> +{
> +	struct ifpga_sec_mgr *imgr;
> +	int id, ret;
> +
> +	if (!check_reh_handler(dev, iops, bmc) ||
> +	    !check_reh_handler(dev, iops, sr) ||
> +	    !check_reh_handler(dev, iops, pr) ||
> +	    !check_csk_handler(dev, iops, bmc) ||
> +	    !check_csk_handler(dev, iops, sr) ||
> +	    !check_csk_handler(dev, iops, pr)) {
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!name || !strlen(name)) {
> +		dev_err(dev, "Attempt to register with no name!\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	imgr = kzalloc(sizeof(*imgr), GFP_KERNEL);
> +	if (!imgr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	imgr->name = name;
> +	imgr->priv = priv;
> +	imgr->iops = iops;
> +	mutex_init(&imgr->lock);
> +
> +	id = ida_simple_get(&ifpga_sec_mgr_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		ret = id;
> +		goto exit_free;
> +	}
> +
> +	imgr->dev.class = ifpga_sec_mgr_class;
> +	imgr->dev.parent = dev;
> +	imgr->dev.id = id;
> +
> +	ret = dev_set_name(&imgr->dev, "ifpga_sec%d", id);
> +	if (ret) {
> +		dev_err(dev, "Failed to set device name: ifpga_sec%d\n", id);
> +		ida_simple_remove(&ifpga_sec_mgr_ida, id);
> +		goto exit_free;
> +	}

Consider
   	ret = dev_set_name(&imgr->dev, "ifpga_sec%d", id);
   	if (ret) {
		goto exit_device;
   	}
and above exit_free:
exit_device:
   		ida_simple_remove(&ifpga_sec_mgr_ida, id);

> +
> +	ret = device_register(&imgr->dev);
> +	if (ret) {
> +		put_device(&imgr->dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return imgr;
> +
> +exit_free:
> +	kfree(dev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(ifpga_sec_mgr_register);
> +
> +/**
> + * ifpga_sec_mgr_unregister - unregister a IFPGA security manager
Nit: a or an IFPGA?
> + *
> + * @mgr: fpga manager struct
> + *
> + * This function is intended for use in a IFPGA security manager
Nit: a or an?
> + * driver's remove() function.
> + */
> +void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr)
> +{
> +	dev_info(&imgr->dev, "%s %s\n", __func__, imgr->name);
> +
> +	device_unregister(&imgr->dev);
> +}
> +EXPORT_SYMBOL_GPL(ifpga_sec_mgr_unregister);
> +
> +static void ifpga_sec_mgr_dev_release(struct device *dev)
> +{
> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
> +
> +	mutex_destroy(&imgr->lock);
> +	ida_simple_remove(&ifpga_sec_mgr_ida, imgr->dev.id);
> +	kfree(imgr);
> +}
> +
> +static int __init ifpga_sec_mgr_class_init(void)
> +{
> +	pr_info("Intel FPGA Security Manager\n");
> +
> +	ifpga_sec_mgr_class = class_create(THIS_MODULE, "ifpga_sec_mgr");
> +	if (IS_ERR(ifpga_sec_mgr_class))
> +		return PTR_ERR(ifpga_sec_mgr_class);
> +
> +	ifpga_sec_mgr_class->dev_groups = ifpga_sec_mgr_attr_groups;
> +	ifpga_sec_mgr_class->dev_release = ifpga_sec_mgr_dev_release;
> +
> +	return 0;
> +}
> +
> +static void __exit ifpga_sec_mgr_class_exit(void)
> +{
> +	class_destroy(ifpga_sec_mgr_class);
> +	ida_destroy(&ifpga_sec_mgr_ida);
> +}
> +
> +MODULE_DESCRIPTION("Intel FPGA Security Manager Driver");
> +MODULE_LICENSE("GPL v2");
> +
> +subsys_initcall(ifpga_sec_mgr_class_init);
> +module_exit(ifpga_sec_mgr_class_exit)
> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
> new file mode 100644
> index 000000000000..e391b0c8f448
> --- /dev/null
> +++ b/include/linux/fpga/ifpga-sec-mgr.h
> @@ -0,0 +1,145 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Intel FPGA Security Manager
> + *
> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> + */
> +#ifndef _LINUX_IFPGA_SEC_MGR_H
> +#define _LINUX_IFPGA_SEC_MGR_H
> +
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +struct ifpga_sec_mgr;
> +
> +/**
> + * typedef sysfs_reh_size_t - Function to return byte size of root entry hash
> + *
> + * @imgr:      pointer to security manager structure
> + *
> + * This datatype is used to define a function that returns the byte size of a
> + * root entry hash.
> + *
> + * Context: No locking requirements are imposed by the security manager.
> + * Return:  Byte count on success, negative errno on failure
> + */
> +typedef int (*sysfs_reh_size_t)(struct ifpga_sec_mgr *imgr);
> +
> +/**
> + * typedef sysfs_reh_hndlr_t - Function pointer to sysfs file handler
> + *			       for root entry hashes
> + * @imgr:      pointer to security manager structure
> + * @hash:      pointer to an array of bytes in which to store the hash
> + * @size:      byte size of root entry hash
> + *
> + * This datatype is used to define a sysfs file handler function to
> + * return root entry hash data to be displayed via sysfs.
> + *
> + * Context: No locking requirements are imposed by the security manager.
> + * Return:  0 on success, negative errno on failure
> + */
> +typedef int (*sysfs_reh_hndlr_t)(struct ifpga_sec_mgr *imgr, u8 *hash,
> +				 unsigned int size);
> +
> +/**
> + * typedef sysfs_cnt_hndlr_t - Function pointer to sysfs file handler
> + *			       for flash counts
> + * @imgr: pointer to security manager structure
> + *
> + * This datatype is used to define a sysfs file handler function to
> + * return a flash count to be displayed via sysfs.
> + *
> + * Context: No locking requirements are imposed by the security manager
> + * Return: flash count or negative errno
> + */
> +typedef int (*sysfs_cnt_hndlr_t)(struct ifpga_sec_mgr *imgr);
> +
> +/**
> + * typedef sysfs_csk_nbits_t - Function to return the number of bits in
> + *				      a Code Signing Key cancellation vector
> + *
> + * @imgr:      pointer to security manager structure
> + *
> + * This datatype is used to define a function that returns the number of bits
> + * in a Code Signing Key cancellation vector.
> + *
> + * Context: No locking requirements are imposed by the security manager.
> + * Return:  Number of bits on success, negative errno on failure
> + */
> +typedef int (*sysfs_csk_nbits_t)(struct ifpga_sec_mgr *imgr);
> +
> +/**
> + * typedef sysfs_csk_hndlr_t - Function pointer to sysfs file handler
> + *			       bit vector of canceled keys
> + *
> + * @imgr:    pointer to security manager structure
> + * @csk_map: pointer to a bitmap to contain cancellation key vector
> + * @nbits:   number of bits in CSK vector
> + *
> + * This datatype is used to define a sysfs file handler function to
> + * return a bitmap of canceled keys to be displayed via sysfs.
> + *
> + * Context: No locking requirements are imposed by the security manager.
> + * Return:  0 on success, negative errno on failure
> + */
> +typedef int (*sysfs_csk_hndlr_t)(struct ifpga_sec_mgr *imgr,
> +				 unsigned long *csk_map, unsigned int nbits);
> +
> +/**
> + * struct ifpga_sec_mgr_ops - device specific operations
> + * @user_flash_count:	    Optional: Return sysfs string output for FPGA
> + *			    image flash count
> + * @bmc_flash_count:	    Optional: Return sysfs string output for BMC
> + *			    image flash count
> + * @sr_root_entry_hash:	    Optional: Return sysfs string output for static
> + *			    region root entry hash
> + * @pr_root_entry_hash:	    Optional: Return sysfs string output for partial
> + *			    reconfiguration root entry hash
> + * @bmc_root_entry_hash:    Optional: Return sysfs string output for BMC
> + *			    root entry hash
> + * @sr_canceled_csks:	    Optional: Return sysfs string output for static
> + *			    region canceled keys
> + * @pr_canceled_csks:	    Optional: Return sysfs string output for partial
> + *			    reconfiguration canceled keys
> + * @bmc_canceled_csks:	    Optional: Return sysfs string output for bmc
> + *			    canceled keys
> + * @bmc_canceled_csk_nbits: Optional: Return BMC canceled csk vector bit count
> + * @sr_canceled_csk_nbits:  Optional: Return SR canceled csk vector bit count
> + * @pr_canceled_csk_nbits:  Optional: Return PR canceled csk vector bit count
> + * @bmc_reh_size:	    Optional: Return byte size for BMC root entry hash
> + * @sr_reh_size:	    Optional: Return byte size for SR root entry hash
> + * @pr_reh_size:	    Optional: Return byte size for PR root entry hash
> + */
> +struct ifpga_sec_mgr_ops {
> +	sysfs_cnt_hndlr_t user_flash_count;
> +	sysfs_cnt_hndlr_t bmc_flash_count;
> +	sysfs_cnt_hndlr_t smbus_flash_count;
> +	sysfs_reh_hndlr_t sr_root_entry_hash;
> +	sysfs_reh_hndlr_t pr_root_entry_hash;
> +	sysfs_reh_hndlr_t bmc_root_entry_hash;
> +	sysfs_csk_hndlr_t sr_canceled_csks;
> +	sysfs_csk_hndlr_t pr_canceled_csks;
> +	sysfs_csk_hndlr_t bmc_canceled_csks;
> +	sysfs_reh_size_t bmc_reh_size;
> +	sysfs_reh_size_t sr_reh_size;
> +	sysfs_reh_size_t pr_reh_size;
> +	sysfs_csk_nbits_t bmc_canceled_csk_nbits;
> +	sysfs_csk_nbits_t sr_canceled_csk_nbits;
> +	sysfs_csk_nbits_t pr_canceled_csk_nbits;
> +};

I agree with Tom's feedback, please don't use typedefs here.
> +
> +struct ifpga_sec_mgr {
> +	const char *name;
> +	struct device dev;
> +	const struct ifpga_sec_mgr_ops *iops;
> +	struct mutex lock;		/* protect data structure contents */
> +	void *priv;
> +};
> +
> +struct ifpga_sec_mgr *
> +ifpga_sec_mgr_register(struct device *dev, const char *name,
> +		       const struct ifpga_sec_mgr_ops *iops, void *priv);
> +void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr);
> +
> +#endif
> -- 
> 2.17.1
> 

Thanks,
Moritz
