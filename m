Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5259EC61
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Aug 2022 21:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiHWTbK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Aug 2022 15:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiHWTaX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Aug 2022 15:30:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFD413677F
        for <linux-fpga@vger.kernel.org>; Tue, 23 Aug 2022 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661278789; x=1692814789;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bAqsBLSTaWdqQ+GPNkkQk+cuKSiP6dTippHCsNCrTgE=;
  b=nNQ/UySxk0mvrr8BSRh1V9rp+LrjbcFa6vxJ6nTSlHMQ1q8S1k+bS78h
   dsZZQfL2+paZwsxK01Cq7n+SUu6XxXN9eoPb2oYRneu4TeSiC7ScJ2uSf
   G63DIac3ypVABuKl5PIc52c26kJoM2pla/tg8oG1Btzp6oY2J2yZoF4+Q
   1jjC+aWGHgEY8H5Sj/KZ2S8uinf3aOd3YMEgzxzflOxxrWNHR/nLM3mZC
   z+lhh9ydhyAIsBCuaN6sc1JT/KcykWC+t/LLOJnf6wFtQX0nOoxO64yI2
   t2SOt1BOSXrD64hL1tV+KuJFwfdy0NyPl1YCKcnZ/jQsNJhGM3UCB9lPM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="357739087"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="357739087"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 11:19:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="560271732"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 11:19:46 -0700
Date:   Tue, 23 Aug 2022 11:19:52 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tianfei Zhang <tianfei.zhang@intel.com>
cc:     mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        lee.jones@linaro.org, russell.h.weight@intel.com, hao.wu@intel.com,
        trix@redhat.com
Subject: Re: [PATCH v4 1/2] fpga: m10bmc-sec: add sysfs to trigger FPGA/BMC
 images reload
In-Reply-To: <20220815060715.37712-2-tianfei.zhang@intel.com>
Message-ID: <alpine.DEB.2.22.394.2208231119100.6273@rhweight-WRK1>
References: <20220815060715.37712-1-tianfei.zhang@intel.com> <20220815060715.37712-2-tianfei.zhang@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Mon, 15 Aug 2022, Tianfei Zhang wrote:

> From: Russ Weight <russell.h.weight@intel.com>
>
> Add the available_images and image_load sysfs files. The available_images
> file returns a space separated list of key words that may be written
> into the image_load file. These keywords describe an FPGA, BMC, or
> firmware image in FLASH or EEPROM storage that may be loaded.
>
> The image_load sysfs file may be written with a key word to trigger a
> reload of an FPGA, BMC, or firmware image from FLASH or EEPROM.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Looks good to me.

Thanks.
> ---
> v4:
> From Yilun and Matthew's comments, provide more detail about how
> to trigger the FPGA/BMC image reload.
> v3:
> uses regmap_update_bits() API instead of m10bmc_sys_update_bits().
> v2:
> adds the steps for how to use the "image_load" sysfs file.
> ---
> .../sysfs-driver-intel-m10-bmc-sec-update     |  41 +++++++
> drivers/fpga/intel-m10-bmc-sec-update.c       | 105 ++++++++++++++++++
> 2 files changed, 146 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> index 0a41afe0ab4c..0db2f1e73a82 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> @@ -59,3 +59,44 @@ Contact:	Russ Weight <russell.h.weight@intel.com>
> Description:	Read only. Returns number of times the secure update
> 		staging area has been flashed.
> 		Format: "%u".
> +
> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../control/available_images
> +Date:		Aug 2022
> +KernelVersion:  6.0
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. This file returns a space separated list of
> +		key words that may be written into the image_load file
> +		described below. These keywords decribe an FPGA, BMC,
> +		or firmware image in FLASH or EEPROM storage that may
> +		be loaded.
> +
> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../control/image_load
> +Date:		Aug 2022
> +KernelVersion:  6.0
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Write-only. A key word may be written to this file to
> +		trigger a reload of an FPGA, BMC, or firmware image from
> +		FLASH or EEPROM. Refer to the available_images file for a
> +		list of supported key words for the underlying device.
> +		Writing an unsupported string to this file will result in
> +		EINVAL being returned.
> +		It should remove all of resources related to the old FPGA/BMC
> +		image before trigger the image reload otherwise the functionality
> +		of FPGA/BMC will fail. We recommended that follow the below steps
> +		or directly use the OPAE RSU script to perform the reload for FPGA/BMC
> +		image.
> +		Here is the steps to trigger the reload for FPGA/BMC image:
> +		1. Unbind driver from all VFs to be affected by the trigger.
> +		2. Disable all VFs via "/sys/bus/pic/device/xxxx/sriov_numvfs"
> +		sysfs file.
> +		3. Unbind driver from all PFs affectected by the trigger except the
> +		management PF.
> +		4. Disable AER on all PFs and upstream pci root port.
> +		5. Trigger image reload of FPGA and/or other programmable devices.
> +	        6. Hot-remove the PCI devices of the FPGA card via
> +		"/sys/bus/pci/devices/xxxx/remove" sysfs file.
> +		7. Wait for reconfiguration of FPGA an/or other programmable parts
> +		(e.g. 10 seconds)
> +		8. Re-scan PCI bus.
> +		9. Renable the AER on all PFs and upstream root port.
> +		10. Bring up VFs as desired.
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 72c677c910de..3a082911cf67 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -14,6 +14,8 @@
> #include <linux/platform_device.h>
> #include <linux/slab.h>
>
> +struct image_load;
> +
> struct m10bmc_sec {
> 	struct device *dev;
> 	struct intel_m10bmc *m10bmc;
> @@ -21,6 +23,12 @@ struct m10bmc_sec {
> 	char *fw_name;
> 	u32 fw_name_id;
> 	bool cancel_request;
> +	struct image_load *image_load;	/* terminated with { } member */
> +};
> +
> +struct image_load {
> +	const char *name;
> +	int (*load_image)(struct m10bmc_sec *sec);
> };
>
> static DEFINE_XARRAY_ALLOC(fw_upload_xa);
> @@ -137,6 +145,54 @@ DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR + CSK_VEC_OFFSET);
>
> #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
>
> +static ssize_t available_images_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> +	const struct image_load *hndlr;
> +	ssize_t count = 0;
> +
> +	for (hndlr = sec->image_load; hndlr->name; hndlr++) {
> +		count += scnprintf(buf + count, PAGE_SIZE - count,
> +				   "%s ", hndlr->name);
> +	}
> +
> +	buf[count - 1] = '\n';
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RO(available_images);
> +
> +static ssize_t image_load_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> +	const struct image_load *hndlr;
> +	int ret = -EINVAL;
> +
> +	for (hndlr = sec->image_load; hndlr->name; hndlr++) {
> +		if (sysfs_streq(buf, hndlr->name)) {
> +			ret = hndlr->load_image(sec);
> +			break;
> +		}
> +	}
> +
> +	return ret ? : count;
> +}
> +static DEVICE_ATTR_WO(image_load);
> +
> +static struct attribute *m10bmc_control_attrs[] = {
> +	&dev_attr_available_images.attr,
> +	&dev_attr_image_load.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group m10bmc_control_attr_group = {
> +	.name = "control",
> +	.attrs = m10bmc_control_attrs,
> +};
> +
> static ssize_t flash_count_show(struct device *dev,
> 				struct device_attribute *attr, char *buf)
> {
> @@ -195,6 +251,7 @@ static struct attribute_group m10bmc_security_attr_group = {
>
> static const struct attribute_group *m10bmc_sec_attr_groups[] = {
> 	&m10bmc_security_attr_group,
> +	&m10bmc_control_attr_group,
> 	NULL,
> };
>
> @@ -208,6 +265,53 @@ static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
> 		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
> }
>
> +static int m10bmc_sec_bmc_image_load(struct m10bmc_sec *sec,
> +				     unsigned int val)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	if (val > 1) {
> +		dev_err(sec->dev, "invalid reload val = %d\n", val);
> +		return -EINVAL;
> +	}
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return ret;
> +
> +	if (doorbell & DRBL_REBOOT_DISABLED)
> +		return -EBUSY;
> +
> +	return regmap_update_bits(sec->m10bmc->regmap,
> +				  M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				  DRBL_CONFIG_SEL | DRBL_REBOOT_REQ,
> +				  FIELD_PREP(DRBL_CONFIG_SEL, val) |
> +				  DRBL_REBOOT_REQ);
> +}
> +
> +static int m10bmc_sec_bmc_image_load_0(struct m10bmc_sec *sec)
> +{
> +	return m10bmc_sec_bmc_image_load(sec, 0);
> +}
> +
> +static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec)
> +{
> +	return m10bmc_sec_bmc_image_load(sec, 1);
> +}
> +
> +static struct image_load m10bmc_image_load_hndlrs[] = {
> +	{
> +		.name = "bmc_factory",
> +		.load_image = m10bmc_sec_bmc_image_load_1,
> +	},
> +	{
> +		.name = "bmc_user",
> +		.load_image = m10bmc_sec_bmc_image_load_0,
> +	},
> +	{}
> +};
> +
> static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
> {
> 	u32 doorbell;
> @@ -565,6 +669,7 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
> 	sec->dev = &pdev->dev;
> 	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
> 	dev_set_drvdata(&pdev->dev, sec);
> +	sec->image_load = m10bmc_image_load_hndlrs;
>
> 	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
> 		       xa_limit_32b, GFP_KERNEL);
> -- 
> 2.26.2
>
>
