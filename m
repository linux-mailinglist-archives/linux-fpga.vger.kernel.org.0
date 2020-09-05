Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147E825E9D0
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 21:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgIETJz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 5 Sep 2020 15:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728589AbgIETJy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 5 Sep 2020 15:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599332989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w19xuhGemvwQfGWLrW/HYGmQkSgkUS2B39Covsdhqm8=;
        b=BBTIG8cqZ7ssydiZPor5nnYEtuTebMIV9PSJ6ukr5YpmlQCuUQqOgNDyVtToDyKXgoeHcy
        x3Vd9mKcP1BffTyFcU61XOgH8/irlZYgFGXsgRNXLbNs7AbViTWvYLgxWG767RQ0JBTDht
        NjiuGH/SLRfNxi/ZGJqg0ORFKELmtzg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-Kl5lwc6KM76AHQ1J-wWYFA-1; Sat, 05 Sep 2020 15:09:38 -0400
X-MC-Unique: Kl5lwc6KM76AHQ1J-wWYFA-1
Received: by mail-qt1-f199.google.com with SMTP id e14so6514612qtm.5
        for <linux-fpga@vger.kernel.org>; Sat, 05 Sep 2020 12:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w19xuhGemvwQfGWLrW/HYGmQkSgkUS2B39Covsdhqm8=;
        b=S3dm3mH/3j26VXo0umYjXMH9UWB4PkUJOYL0IoVGUVo9G2nfSacnusRWWlFTZkqZrF
         mI6p2SMkai1eCDaxwR9GDrojNBCfpLWuOuhGZDEXs/rP4FW7lp2CQ3VOzpYA3A0HTI3b
         nWU1bcG6zqfLV+2NDwStEBkv5LLEIgk+vWmHMVOfrH0nMWFghsFbxmFQjq2GJoKskA6Y
         GM7IvpFAtviV4nP6EVi8QpkLn9ivHjVlwibmAB8sh4bZZ9scNBag+57sv81lEBtJFvw3
         +x6QmRNd3S4FwFtGkVEdJTjcuYjaWDa3hXSQYQUq8ESrUcMtAuRxCnNC3GZeQOwtN3LZ
         5Erg==
X-Gm-Message-State: AOAM533Wk0vPY/aHzVVNcO8wzgfHtjBimTO2yj0o//uiJSK/7InclUQW
        yfZPMEop+pIX40abuu0HusxuBR486poAHWFiGE/Pa7jiVxpSZcHT+HLq+pDxIrpLtfsUGGiTdWk
        NnWjMzqFKf6P50CWUDK8QKw==
X-Received: by 2002:a37:a992:: with SMTP id s140mr13013571qke.485.1599332977537;
        Sat, 05 Sep 2020 12:09:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqJ3Ng+vdPlxe9kmHyrbS/Pqt8xkSWEPtKabZgjZakT2XSy5mG2rx9vHO8td68nC77soc7eA==
X-Received: by 2002:a37:a992:: with SMTP id s140mr13013534qke.485.1599332976930;
        Sat, 05 Sep 2020 12:09:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j11sm1388648qko.111.2020.09.05.12.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 12:09:36 -0700 (PDT)
Subject: Re: [PATCH v1 01/12] fpga: fpga security manager class driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-2-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ebb5b52d-c296-478a-c970-a1845edb4de0@redhat.com>
Date:   Sat, 5 Sep 2020 12:09:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-2-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 4:52 PM, Russ Weight wrote:
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
could this be %u ?
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

Param 2&3 can be accessed by imgr->iops so the signature

of this and similar functions should be reduced.

> +				 char *buf)
> +{
> +	unsigned long *csk_map = NULL;
> +	unsigned int nbits;
> +	int cnt, ret;
> +
> +	ret = get_csk_nbits(imgr);

Any access to a function pointer must check if the

the pointer is valid.

> +	if (ret < 0)
> +		return ret;
> +
> +	nbits = (unsigned int)ret;
> +	csk_map = vmalloc(sizeof(unsigned long) * BITS_TO_LONGS(nbits));
> +	if (!csk_map)
> +		return -ENOMEM;
> +
> +	ret = get_csk(imgr, csk_map, nbits);

The type of returned by get_csk_nbits and its use should

be consistent. likely this is 'int'

> +	if (ret)
> +		goto vfree_exit;
> +
> +	cnt = bitmap_print_to_pagebuf(1, buf, csk_map, nbits);

simplify to

ret = ..


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
does size and i need to unsigned?
> +	hash = vmalloc(size);
> +	if (!hash)
> +		return -ENOMEM;
> +
> +	ret = get_reh(imgr, hash, size);
> +	if (ret)
> +		goto vfree_exit;

ret is 0 here

so simplify replacing cnt with ret.

> +
> +	cnt += sprintf(buf, "0x");
or change += to =, this is the first time sprintf is done.
> +	for (i = 0; i < size; i++)
> +		cnt += sprintf(buf + cnt, "%02x", hash[i]);
> +	cnt += sprintf(buf + cnt, "\n");
> +
> +vfree_exit:
> +	vfree(hash);
> +	return ret ? : cnt;

with simplification this should be

return ret;

> +}
> +
> +#define to_sec_mgr(d) container_of(d, struct ifpga_sec_mgr, dev)
Since this is used widely move closer to top of file.
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

This is all or nothing, shouldn't the interface

allow for null iop ?

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

These two checks can be simplified to

if (!sysfs_handler || !size_handler)

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
should name be dup-ed?
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
> + *
> + * @mgr: fpga manager struct
> + *
> + * This function is intended for use in a IFPGA security manager
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

These typedef's hide the function signatures and are

not consistent with how the other headers in include/linux/fpga

specify ops.

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
> +
> +struct ifpga_sec_mgr {
> +	const char *name;
> +	struct device dev;
> +	const struct ifpga_sec_mgr_ops *iops;
> +	struct mutex lock;		/* protect data structure contents */

comment is redundant for a lock.

Tom

> +	void *priv;
> +};
> +
> +struct ifpga_sec_mgr *
> +ifpga_sec_mgr_register(struct device *dev, const char *name,
> +		       const struct ifpga_sec_mgr_ops *iops, void *priv);
> +void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr);
> +
> +#endif

