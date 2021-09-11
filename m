Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A8C407A2F
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Sep 2021 21:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhIKTF2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Sep 2021 15:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233683AbhIKTF1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 11 Sep 2021 15:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631387052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EF+2EMTndqJvhB4Juza5gpKf2vT31429ETh4wCmufDg=;
        b=JYZAOy7QZxxAyqsLIjp5E5i1b3GFGJWegAnfYxGje2F7g0ePEE5TkYfN3tj7VZuGSdVJjI
        7kCGG4zPYXSFS6Xxs0Tfv0/bzODHQRprMQy7rzgPk10xyCXX3AL3ab65BvJ4+hksTovZTo
        ar4ZZ+aKFbH3Rk1Fq8/pSfKHOA6lsZY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-qmpef5bkNHurnpPkbPhckw-1; Sat, 11 Sep 2021 15:04:11 -0400
X-MC-Unique: qmpef5bkNHurnpPkbPhckw-1
Received: by mail-qt1-f198.google.com with SMTP id o22-20020ac872d60000b029029817302575so51719045qtp.10
        for <linux-fpga@vger.kernel.org>; Sat, 11 Sep 2021 12:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EF+2EMTndqJvhB4Juza5gpKf2vT31429ETh4wCmufDg=;
        b=ZS+Ogu/5kTVD5UTFAHFEQnvGDXrvTmTfrQfw4X1EKeV33bB6joku/sheoBFflgQIvE
         vCF8hwuUQ5t19o89m+iW6UzxDLLI0W0sDdx/A+wUCEq2gNJEpSPo5l25Un6XDoQIFd5S
         oeeuHKQoupeB5ugNkrJu6LrYDv5BVsTOar7UNy0XMSJ9u/++pTyB8fCSFzegforzDcpP
         2+s4Ux9gw/rsiPdFCvsZKvH63+rHgwj4QfZlzvJfLAQOVNw/0LmfqD1y3wjSADKL1ogU
         RrUDa6sbcB+8dRYYbEA4PQoHJ5qlRuI4HSciVl2EJfHK3cLRipBRhguFuCLTeUnKJDwW
         PNAQ==
X-Gm-Message-State: AOAM530Eyh/YIh22K4vAsKZ81j8jXyH1NQ00yyE0lIu5bfgpwdOwHRm4
        8YTdEj87OaTScItQtLYeRyr1WlAlwjhSWSb9WzsgRNZoX1iWq0IjH1Em8WvTR9dwlN6A4AwFLWm
        6M7OYYpXiSvR2+w2OaurDXA==
X-Received: by 2002:a05:620a:2012:: with SMTP id c18mr3158728qka.312.1631387050514;
        Sat, 11 Sep 2021 12:04:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfRegfBTe4+O7RDNAbITI216itlAQaZdscV1BUgNAL38zATH/BlWJ5onnOxEXG/aaPdfzoSA==
X-Received: by 2002:a05:620a:2012:: with SMTP id c18mr3158704qka.312.1631387050219;
        Sat, 11 Sep 2021 12:04:10 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f6sm1709559qko.85.2021.09.11.12.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 12:04:09 -0700 (PDT)
Subject: Re: [PATCH v14 1/4] fpga: m10bmc-sec: create max10 bmc secure update
 driver
To:     Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20210909233304.5650-1-russell.h.weight@intel.com>
 <20210909233304.5650-2-russell.h.weight@intel.com>
 <20210910151335.GB757507@yilunxu-OptiPlex-7050>
 <1e4a9cc9-4390-1c9d-5ec0-7e9295158dfa@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ce3039c5-d18a-87d5-229d-5ff571c2aaa9@redhat.com>
Date:   Sat, 11 Sep 2021 12:04:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1e4a9cc9-4390-1c9d-5ec0-7e9295158dfa@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/10/21 1:27 PM, Russ Weight wrote:
>
> On 9/10/21 8:13 AM, Xu Yilun wrote:
>> On Thu, Sep 09, 2021 at 04:33:01PM -0700, Russ Weight wrote:
>>> Create a sub driver for the FPGA Card BMC in order to support secure
>>> updates.  This sub-driver will invoke an instance of the FPGA Image Load
>>> class driver for the image load portion of the update.
>>>
>>> This patch creates the MAX10 BMC Secure Update driver and provides sysfs
>>> files for displaying the current root entry hashes for the FPGA static
>>> region, the FPGA PR region, and the MAX10 BMC.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> Reviewed-by: Tom Rix <trix@redhat.com>
>>> ---
>>> v14:
>>>    - Changed symbol and text references to reflect the renaming of the
>>>      Security Manager Class driver to FPGA Image Load.
>>> v13:
>>>    - Updated copyright to 2021
>>>    - Updated ABI documentation date and kernel version
>>>    - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
>>>      functions instead of devm_fpga_sec_mgr_create() and
>>>      devm_fpga_sec_mgr_register().
>>> v12:
>>>    - Updated Date and KernelVersion fields in ABI documentation
>>> v11:
>>>    - Added Reviewed-by tag
>>> v10:
>>>    - Changed the path expressions in the sysfs documentation to
>>>      replace the n3000 reference with something more generic to
>>>      accomodate other devices that use the same driver.
>>> v9:
>>>    - Rebased to 5.12-rc2 next
>>>    - Updated Date and KernelVersion in ABI documentation
>>> v8:
>>>    - Previously patch 2/6, otherwise no change
>>> v7:
>>>    - Updated Date and KernelVersion in ABI documentation
>>> v6:
>>>    - Added WARN_ON() call for (sha_num_bytes / stride) to assert
>>>      that the proper count is passed to regmap_bulk_read().
>>> v5:
>>>    - No change
>>> v4:
>>>    - Moved sysfs files for displaying the root entry hashes (REH)
>>>      from the FPGA Security Manager class driver to here. The
>>>      m10bmc_reh() and m10bmc_reh_size() functions are removed and
>>>      the functionality from these functions is moved into a
>>>      show_root_entry_hash() function for displaying the REHs.
>>>    - Added ABI documentation for the new sysfs entries:
>>>      sysfs-driver-intel-m10-bmc-secure
>>>    - Updated the MAINTAINERS file to add the new ABI documentation
>>>      file: sysfs-driver-intel-m10-bmc-secure
>>>    - Removed unnecessary ret variable from m10bmc_secure_probe()
>>>    - Incorporated new devm_fpga_sec_mgr_register() function into
>>>      m10bmc_secure_probe() and removed the m10bmc_secure_remove()
>>>      function.
>>> v3:
>>>    - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>>    - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>>    - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>>>      Update driver"
>>>    - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>>      underlying functions are now called directly.
>>>    - Changed "_root_entry_hash" to "_reh", with a comment explaining
>>>      what reh is.
>>> v2:
>>>    - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
>>>    - Switched to GENMASK(31, 16) for a couple of mask definitions.
>>>    - Moved MAX10 BMC address and function definitions to a separate
>>>      patch.
>>>    - Replaced small function-creation macros with explicit function
>>>      declarations.
>>>    - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
>>>    - Adapted to changes in the Intel FPGA Security Manager by splitting
>>>      the single call to ifpga_sec_mgr_register() into two function
>>>      calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
>>> ---
>>>   .../testing/sysfs-driver-intel-m10-bmc-secure |  29 ++++
>>>   MAINTAINERS                                   |   2 +
>>>   drivers/fpga/Kconfig                          |  11 ++
>>>   drivers/fpga/Makefile                         |   3 +
>>>   drivers/fpga/intel-m10-bmc-secure.c           | 145 ++++++++++++++++++
>>>   5 files changed, 190 insertions(+)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>>>   create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>>> new file mode 100644
>>> index 000000000000..363403ce992d
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>>> @@ -0,0 +1,29 @@
>>> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/sr_root_entry_hash
>>> +Date:		Aug 2021
>>> +KernelVersion:	5.15
>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>> +Description:	Read only. Returns the root entry hash for the static
>>> +		region if one is programmed, else it returns the
>>> +		string: "hash not programmed".  This file is only
>>> +		visible if the underlying device supports it.
>>> +		Format: "0x%x".
>>> +
>>> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/pr_root_entry_hash
>>> +Date:		Aug 2021
>>> +KernelVersion:	5.15
>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>> +Description:	Read only. Returns the root entry hash for the partial
>>> +		reconfiguration region if one is programmed, else it
>>> +		returns the string: "hash not programmed".  This file
>>> +		is only visible if the underlying device supports it.
>>> +		Format: "0x%x".
>>> +
>>> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/bmc_root_entry_hash
>>> +Date:		Aug 2021
>>> +KernelVersion:	5.15
>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>> +Description:	Read only. Returns the root entry hash for the BMC image
>>> +		if one is programmed, else it returns the string:
>>> +		"hash not programmed".  This file is only visible if the
>>> +		underlying device supports it.
>>> +		Format: "0x%x".
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index e3fbc1bde9bc..cf93835b4775 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -7363,8 +7363,10 @@ M:	Russ Weight <russell.h.weight@intel.com>
>>>   L:	linux-fpga@vger.kernel.org
>>>   S:	Maintained
>>>   F:	Documentation/ABI/testing/sysfs-class-fpga-image-load
>>> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>> Should we change the name of the driver? Some keywords like "image load"
>> or "firmware update" should be in the name.
> I considered that. The image-upload functionality is a subset of  this
> driver. It also exposes security collateral via sysfs, and the image-load
> triggers and power-on-image sysfs files will probably end up in this
> driver too.
>
> The current driver name is intel-m10-bmc-secure. Do we need to keep
> "intel-m10-bmc" in the name?
>
> intel-m10-bmc-sec-fw-update?
> intel-m10-bmc-sec-update?
>
> What do you think? Any other suggestions?

The prefix intel-m10-bmc-sec is clunky and confuses me because I think 
of mfd/intel-m10-bmc.c

How about

dfl-image-load ?

Tom

>
> - Russ
>> Thanks,
>> Yilun
>>
>>>   F:	Documentation/fpga/fpga-image-load.rst
>>>   F:	drivers/fpga/fpga-image-load.c
>>> +F:	drivers/fpga/intel-m10-bmc-secure.c
>>>   F:	include/linux/fpga/fpga-image-load.h
>>>   F:	include/uapi/linux/fpga-image-load.h
>>>   
>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>>> index c12a14e62fff..9d25b1ec03cd 100644
>>> --- a/drivers/fpga/Kconfig
>>> +++ b/drivers/fpga/Kconfig
>>> @@ -253,4 +253,15 @@ config FPGA_IMAGE_LOAD
>>>   	  and/or the device itself to authenticate and disposition the
>>>   	  image data.
>>>   
>>> +config FPGA_M10_BMC_SECURE
>>> +	tristate "Intel MAX10 BMC Secure Update driver"
>>> +	depends on MFD_INTEL_M10_BMC && FPGA_IMAGE_LOAD
>>> +	help
>>> +	  Secure update support for the Intel MAX10 board management
>>> +	  controller.
>>> +
>>> +	  This is a subdriver of the Intel MAX10 board management controller
>>> +	  (BMC) and provides support for secure updates for the BMC image,
>>> +	  the FPGA image, the Root Entry Hashes, etc.
>>> +
>>>   endif # FPGA
>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>>> index adf228ee4f5e..8d4c1869ac4c 100644
>>> --- a/drivers/fpga/Makefile
>>> +++ b/drivers/fpga/Makefile
>>> @@ -25,6 +25,9 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>>   # FPGA Image Load Framework
>>>   obj-$(CONFIG_FPGA_IMAGE_LOAD)		+= fpga-image-load.o
>>>   
>>> +# FPGA Secure Update Drivers
>>> +obj-$(CONFIG_FPGA_M10_BMC_SECURE)	+= intel-m10-bmc-secure.o
>>> +
>>>   # FPGA Bridge Drivers
>>>   obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>>>   obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>>> new file mode 100644
>>> index 000000000000..03fc571f40f2
>>> --- /dev/null
>>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>>> @@ -0,0 +1,145 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Intel Max10 Board Management Controller Secure Update Driver
>>> + *
>>> + * Copyright (C) 2019-2021 Intel Corporation. All rights reserved.
>>> + *
>>> + */
>>> +#include <linux/bitfield.h>
>>> +#include <linux/device.h>
>>> +#include <linux/fpga/fpga-image-load.h>
>>> +#include <linux/mfd/intel-m10-bmc.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +struct m10bmc_sec {
>>> +	struct device *dev;
>>> +	struct intel_m10bmc *m10bmc;
>>> +	struct fpga_image_load *imgld;
>>> +};
>>> +
>>> +/* Root Entry Hash (REH) support */
>>> +#define REH_SHA256_SIZE		32
>>> +#define REH_SHA384_SIZE		48
>>> +#define REH_MAGIC		GENMASK(15, 0)
>>> +#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
>>> +
>>> +static ssize_t
>>> +show_root_entry_hash(struct device *dev, u32 exp_magic,
>>> +		     u32 prog_addr, u32 reh_addr, char *buf)
>>> +{
>>> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>> +	int sha_num_bytes, i, cnt, ret;
>>> +	u8 hash[REH_SHA384_SIZE];
>>> +	u32 magic;
>>> +
>>> +	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	dev_dbg(dev, "%s magic 0x%08x\n", __func__, magic);
>>> +
>>> +	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
>>> +		return sysfs_emit(buf, "hash not programmed\n");
>>> +
>>> +	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
>>> +	if (sha_num_bytes != REH_SHA256_SIZE &&
>>> +	    sha_num_bytes != REH_SHA384_SIZE)   {
>>> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
>>> +			sha_num_bytes);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	WARN_ON(sha_num_bytes % stride);
>>> +	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
>>> +			       hash, sha_num_bytes / stride);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
>>> +			reh_addr, sha_num_bytes / stride, ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	cnt = sprintf(buf, "0x");
>>> +	for (i = 0; i < sha_num_bytes; i++)
>>> +		cnt += sprintf(buf + cnt, "%02x", hash[i]);
>>> +	cnt += sprintf(buf + cnt, "\n");
>>> +
>>> +	return cnt;
>>> +}
>>> +
>>> +#define DEVICE_ATTR_SEC_REH_RO(_name, _magic, _prog_addr, _reh_addr) \
>>> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
>>> +					    struct device_attribute *attr, \
>>> +					    char *buf) \
>>> +{ return show_root_entry_hash(dev, _magic, _prog_addr, _reh_addr, buf); } \
>>> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
>>> +
>>> +DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>>> +DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>>> +DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>>> +
>>> +static struct attribute *m10bmc_security_attrs[] = {
>>> +	&dev_attr_bmc_root_entry_hash.attr,
>>> +	&dev_attr_sr_root_entry_hash.attr,
>>> +	&dev_attr_pr_root_entry_hash.attr,
>>> +	NULL,
>>> +};
>>> +
>>> +static struct attribute_group m10bmc_security_attr_group = {
>>> +	.name = "security",
>>> +	.attrs = m10bmc_security_attrs,
>>> +};
>>> +
>>> +static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>>> +	&m10bmc_security_attr_group,
>>> +	NULL,
>>> +};
>>> +
>>> +static const struct fpga_image_load_ops m10bmc_lops = { };
>>> +
>>> +static int m10bmc_secure_probe(struct platform_device *pdev)
>>> +{
>>> +	struct fpga_image_load *imgld;
>>> +	struct m10bmc_sec *sec;
>>> +
>>> +	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>>> +	if (!sec)
>>> +		return -ENOMEM;
>>> +
>>> +	sec->dev = &pdev->dev;
>>> +	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>>> +	dev_set_drvdata(&pdev->dev, sec);
>>> +
>>> +	imgld = fpga_image_load_register(sec->dev, &m10bmc_lops, sec);
>>> +	if (IS_ERR(imgld)) {
>>> +		dev_err(sec->dev, "FPGA Image Load driver failed to start\n");
>>> +		return PTR_ERR(imgld);
>>> +	}
>>> +
>>> +	sec->imgld = imgld;
>>> +	return 0;
>>> +}
>>> +
>>> +static int m10bmc_secure_remove(struct platform_device *pdev)
>>> +{
>>> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
>>> +
>>> +	fpga_image_load_unregister(sec->imgld);
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver intel_m10bmc_secure_driver = {
>>> +	.probe = m10bmc_secure_probe,
>>> +	.remove = m10bmc_secure_remove,
>>> +	.driver = {
>>> +		.name = "n3000bmc-secure",
>>> +		.dev_groups = m10bmc_sec_attr_groups,
>>> +	},
>>> +};
>>> +module_platform_driver(intel_m10bmc_secure_driver);
>>> +
>>> +MODULE_ALIAS("platform:n3000bmc-secure");
>>> +MODULE_AUTHOR("Intel Corporation");
>>> +MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
>>> +MODULE_LICENSE("GPL v2");
>>> -- 
>>> 2.25.1

