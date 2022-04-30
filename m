Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07800515F60
	for <lists+linux-fpga@lfdr.de>; Sat, 30 Apr 2022 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbiD3RCw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 30 Apr 2022 13:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiD3RCv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 30 Apr 2022 13:02:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2697B11A3A;
        Sat, 30 Apr 2022 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651337968; x=1682873968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cm0GQfkM3uM5nE57Izb8BYXCb4I2YHxJTKiCYo47ub0=;
  b=hNmeyasqGzIPS+ZjbNG8A+HHgQ08bsumPsxMbbz6ZkTPDbkti+uhDg9W
   GyNS8WR8mRNN0rP1NbzK6aoN+WKm7NbnOvvHxa/ckgR8TIhedKSkazz5H
   PFailv4BsiTDB3ar7Jdq+HQDLf8aNFODRu7aqa5w/AwQTBLbhaPl5CziK
   esHLq5KKr80Zcyn5tlb+fuUfJgVn1yk27u/8Eq19IbzLSt6A4wvu5Ftvm
   /mR4Sgr+dw/TqM0vsk7/yaC/RlrkC59zIwTjHhQVIn/ybwuxZXcnD+vQp
   ZYhxpcMPI4GM1/HixPHefkAbx3pnwl7t3T3owdvaDgnou46tV3wXEnc7g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="254315965"
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="254315965"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 09:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="687111842"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga004.jf.intel.com with ESMTP; 30 Apr 2022 09:59:23 -0700
Date:   Sun, 1 May 2022 00:51:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v17 2/5] fpga: cardbmc-sec: create bmc secure update
 driver
Message-ID: <20220430165137.GC398931@yilunxu-OptiPlex-7050>
References: <20220428233732.189425-1-russell.h.weight@intel.com>
 <20220428233732.189425-3-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428233732.189425-3-russell.h.weight@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 28, 2022 at 04:37:29PM -0700, Russ Weight wrote:
> Create a sub driver for the FPGA Card BMC in order to support secure
> updates.  This sub-driver uses the Firmware Upload support of the
> Firmware Loader subsystem to transfer the image data to the device.
> 
> This patch creates the FPGA Card BMC Secure Update driver and provides
> sysfs files for displaying the current root entry hashes for the FPGA
> static region, the FPGA PR region, and the card BMC.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v17:
>   - Update the Date and KernelVersion for the ABI documentation to Jul 2022
>     and 5.19 respectively.
>   - Updated the copyright end-date to 2022 for the secure update driver.
>   - Change m10bmc to cardbmc to reflect the fact that the future devices
>     will not necessarily use the MAX10. This affects filenames, configs, and
>     symbol names.
>   - Removed references to the FPGA Image Load class driver and replaced
>     them with the new firmware-upload service from the firmware loader.
>   - Firmware upload requires a unique name for the firmware device. Use
>     xarray_alloc to generate a unique number to append to the name.
>   - Changed the license from GPL to GPLv2 per commit bf7fbeeae6db: 'module:
>     Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity'
> v16:
>   - No Change
> v15:
>   - Updated the Dates and KernelVersions in the ABI documentation
>   - Change driver name from "n3000bmc-secure" to "n3000bmc-sec-update".
>   - Change CONFIG_FPGA_M10_BMC_SECURE to CONFIG_FPGA_M10_BMC_SEC_UPDATE.
>   - Change instances of *bmc-secure to *bmc-sec-update in file name
>     and symbol names.
>   - Change instances of *m10bmc_secure* to *m10bmc-sec_update* in symbol
>     names.
>   - Change instances of *lops* to *ops* in symbol names.
> v14:
>   - Changed symbol and text references to reflect the renaming of the
>     Security Manager Class driver to FPGA Image Load.
> v13:
>   - Updated copyright to 2021
>   - Updated ABI documentation date and kernel version
>   - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
>     functions instead of devm_fpga_sec_mgr_create() and
>     devm_fpga_sec_mgr_register().
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
> v11:
>   - Added Reviewed-by tag
> v10:
>   - Changed the path expressions in the sysfs documentation to
>     replace the n3000 reference with something more generic to
>     accomodate other devices that use the same driver.
> v9:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - Previously patch 2/6, otherwise no change
> v7:
>   - Updated Date and KernelVersion in ABI documentation
> v6:
>   - Added WARN_ON() call for (sha_num_bytes / stride) to assert
>     that the proper count is passed to regmap_bulk_read().
> v5:
>   - No change
> v4:
>   - Moved sysfs files for displaying the root entry hashes (REH)
>     from the FPGA Security Manager class driver to here. The
>     m10bmc_reh() and m10bmc_reh_size() functions are removed and
>     the functionality from these functions is moved into a
>     show_root_entry_hash() function for displaying the REHs.
>   - Added ABI documentation for the new sysfs entries:
>     sysfs-driver-intel-m10-bmc-secure
>   - Updated the MAINTAINERS file to add the new ABI documentation
>     file: sysfs-driver-intel-m10-bmc-secure
>   - Removed unnecessary ret variable from m10bmc_secure_probe()
>   - Incorporated new devm_fpga_sec_mgr_register() function into
>     m10bmc_secure_probe() and removed the m10bmc_secure_remove()
>     function.
> v3:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>     Update driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions are now called directly.
>   - Changed "_root_entry_hash" to "_reh", with a comment explaining
>     what reh is.
> v2:
>   - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
>   - Switched to GENMASK(31, 16) for a couple of mask definitions.
>   - Moved MAX10 BMC address and function definitions to a separate
>     patch.
>   - Replaced small function-creation macros with explicit function
>     declarations.
>   - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
>   - Adapted to changes in the Intel FPGA Security Manager by splitting
>     the single call to ifpga_sec_mgr_register() into two function
>     calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
> ---
>  .../sysfs-driver-intel-cardbmc-sec-update     |  29 +++
>  MAINTAINERS                                   |   7 +
>  drivers/fpga/Kconfig                          |  12 ++
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/intel-cardbmc-sec-update.c       | 167 ++++++++++++++++++
>  5 files changed, 218 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
>  create mode 100644 drivers/fpga/intel-cardbmc-sec-update.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
> new file mode 100644
> index 000000000000..c032fbe59614
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
> @@ -0,0 +1,29 @@
> +What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/sr_root_entry_hash
> +Date:		Jul 2022
> +KernelVersion:	5.19
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the static
> +		region if one is programmed, else it returns the
> +		string: "hash not programmed".  This file is only
> +		visible if the underlying device supports it.
> +		Format: "0x%x".

Should the format be "string'? I always see the hash value is a hexadecimal
string without "0x" prefix. So why you want to output it like a large
hex number?

> +
> +What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/pr_root_entry_hash
> +Date:		Jul 2022
> +KernelVersion:	5.19
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the partial
> +		reconfiguration region if one is programmed, else it
> +		returns the string: "hash not programmed".  This file
> +		is only visible if the underlying device supports it.
> +		Format: "0x%x".

Same concern.

> +
> +What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/bmc_root_entry_hash
> +Date:		Jul 2022
> +KernelVersion:	5.19
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns the root entry hash for the BMC image
> +		if one is programmed, else it returns the string:
> +		"hash not programmed".  This file is only visible if the
> +		underlying device supports it.
> +		Format: "0x%x".

Same.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61d9f114c37f..43feaaa25352 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7725,6 +7725,13 @@ F:	Documentation/fpga/
>  F:	drivers/fpga/
>  F:	include/linux/fpga/
>  
> +FPGA BMC INTEL SECURE UPDATES
> +M:	Russ Weight <russell.h.weight@intel.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
> +F:	drivers/fpga/intel-cardbmc-sec-update.c
> +
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
>  S:	Maintained
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 991b3f361ec9..346889e3096a 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -243,4 +243,16 @@ config FPGA_MGR_VERSAL_FPGA
>  	  configure the programmable logic(PL).
>  
>  	  To compile this as a module, choose M here.
> +
> +config FPGA_CARDBMC_SEC_UPDATE

INTEL_FPGA_CARDBMC_SEC_UPDATE ?

> +	tristate "Intel FPGA Card BMC Secure Update driver"
> +	depends on MFD_INTEL_M10_BMC && FW_UPLOAD

You mentioned that the driver supports devices which may not use max10,
so is it possible to remove the depends on MFD_INTEL_M10_BMC?

Some more stuff related to max10 in this patch.

> +	help
> +	  Secure update support for the Intel FPGA board management
> +	  controller.
> +
> +	  This is a subdriver of the Intel MAX10 board management controller

And the same concern here.

> +	  (BMC) and provides support for secure updates for the BMC image,
> +	  the FPGA image, the Root Entry Hashes, etc.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 0bff783d1b61..daf427393ba9 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -22,6 +22,9 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>  
> +# FPGA Secure Update Drivers
> +obj-$(CONFIG_FPGA_CARDBMC_SEC_UPDATE)	+= intel-cardbmc-sec-update.o

CONFIG_INTEL_FPGA_CARDBMC_SEC_UPDATE ?

> +
>  # FPGA Bridge Drivers
>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
> diff --git a/drivers/fpga/intel-cardbmc-sec-update.c b/drivers/fpga/intel-cardbmc-sec-update.c
> new file mode 100644
> index 000000000000..ba3559f3335d
> --- /dev/null
> +++ b/drivers/fpga/intel-cardbmc-sec-update.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Max10 Board Management Controller Secure Update Driver

Maybe replace Max10 with other description?

> + *
> + * Copyright (C) 2019-2022 Intel Corporation. All rights reserved.
> + *
> + */
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/firmware.h>
> +#include <linux/mfd/intel-m10-bmc.h>

Try to remove this head file if you want to support devices not on max10

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +struct bmc_sec {
> +	struct device *dev;
> +	struct intel_m10bmc *m10bmc;

The same concern.

> +	struct fw_upload *fwl;
> +	char *fw_name;
> +	u32 fw_name_id;
> +};
> +
> +static DEFINE_XARRAY_ALLOC(fw_upload_xa);
> +
> +/* Root Entry Hash (REH) support */
> +#define REH_SHA256_SIZE		32
> +#define REH_SHA384_SIZE		48
> +#define REH_MAGIC		GENMASK(15, 0)
> +#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
> +
> +static ssize_t
> +show_root_entry_hash(struct device *dev, u32 exp_magic,
> +		     u32 prog_addr, u32 reh_addr, char *buf)
> +{
> +	struct bmc_sec *sec = dev_get_drvdata(dev);
> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	int sha_num_bytes, i, cnt, ret;
> +	u8 hash[REH_SHA384_SIZE];
> +	u32 magic;
> +
> +	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(dev, "%s magic 0x%08x\n", __func__, magic);

Remove the dev_dbg.

> +
> +	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
> +		return sysfs_emit(buf, "hash not programmed\n");
> +
> +	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
> +	if (sha_num_bytes != REH_SHA256_SIZE &&
> +	    sha_num_bytes != REH_SHA384_SIZE)   {
> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
> +			sha_num_bytes);
> +		return -EINVAL;
> +	}
> +
> +	WARN_ON(sha_num_bytes % stride);

Why warn on this condition? I assume with this warning user cannot get
enough sha data, so is the output still useful?

> +	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
> +			       hash, sha_num_bytes / stride);
> +	if (ret) {
> +		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
> +			reh_addr, sha_num_bytes / stride, ret);
> +		return ret;
> +	}
> +
> +	cnt = sprintf(buf, "0x");

Why add the 0x prefix on hash value output?

> +	for (i = 0; i < sha_num_bytes; i++)
> +		cnt += sprintf(buf + cnt, "%02x", hash[i]);
> +	cnt += sprintf(buf + cnt, "\n");
> +
> +	return cnt;
> +}
> +
> +#define DEVICE_ATTR_SEC_REH_RO(_name, _magic, _prog_addr, _reh_addr) \
> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
> +					    struct device_attribute *attr, \
> +					    char *buf) \
> +{ return show_root_entry_hash(dev, _magic, _prog_addr, _reh_addr, buf); } \
> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
> +
> +DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
> +DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
> +DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
> +
> +static struct attribute *bmc_security_attrs[] = {
> +	&dev_attr_bmc_root_entry_hash.attr,
> +	&dev_attr_sr_root_entry_hash.attr,
> +	&dev_attr_pr_root_entry_hash.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group bmc_security_attr_group = {
> +	.name = "security",
> +	.attrs = bmc_security_attrs,
> +};
> +
> +static const struct attribute_group *bmc_sec_attr_groups[] = {
> +	&bmc_security_attr_group,
> +	NULL,
> +};
> +
> +static const struct fw_upload_ops cardbmc_ops = { };

I think if you are not ready to introduce fw upload functionality in
this patch, don't add any related stuff here.

> +
> +#define SEC_UPDATE_LEN_MAX 32
> +static int bmc_sec_probe(struct platform_device *pdev)
> +{
> +	char buf[SEC_UPDATE_LEN_MAX];
> +	struct bmc_sec *sec;
> +	struct fw_upload *fwl;
> +	unsigned int len, ret;
> +
> +	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
> +	if (!sec)
> +		return -ENOMEM;
> +
> +	sec->dev = &pdev->dev;
> +	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
> +	dev_set_drvdata(&pdev->dev, sec);
> +
> +	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
> +		       xa_limit_32b, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
> +			sec->fw_name_id);
> +	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
> +
> +	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
> +				       &cardbmc_ops, sec);
> +	if (IS_ERR(fwl)) {
> +		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
> +		kfree(sec->fw_name);
> +		xa_erase(&fw_upload_xa, sec->fw_name_id);
> +		return PTR_ERR(fwl);
> +	}
> +
> +	sec->fwl = fwl;
> +	return 0;
> +}
> +
> +static int bmc_sec_remove(struct platform_device *pdev)
> +{
> +	struct bmc_sec *sec = dev_get_drvdata(&pdev->dev);
> +
> +	firmware_upload_unregister(sec->fwl);
> +	kfree(sec->fw_name);
> +	xa_erase(&fw_upload_xa, sec->fw_name_id);
> +	return 0;
> +}
> +
> +static struct platform_driver intel_cardbmc_sec_driver = {
> +	.probe = bmc_sec_probe,
> +	.remove = bmc_sec_remove,
> +	.driver = {
> +		.name = "n3000bmc-sec-update",

If you expect the driver to support devices not just on n3000 max10 bmc,
using .id_table is better.

> +		.dev_groups = bmc_sec_attr_groups,
> +	},
> +};
> +module_platform_driver(intel_cardbmc_sec_driver);
> +
> +MODULE_ALIAS("platform:n3000bmc-sec-update");

using MODULE_DEVICE_TABLE is better?

> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");

Please keep the naming consistent.

Thanks,
Yilun

> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
