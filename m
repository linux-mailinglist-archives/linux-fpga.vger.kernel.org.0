Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6845697CA
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jul 2022 04:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiGGCIi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Jul 2022 22:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiGGCIi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Jul 2022 22:08:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B31CFF3
        for <linux-fpga@vger.kernel.org>; Wed,  6 Jul 2022 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657159716; x=1688695716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LmTC6m+ZS02O4qsSWoQ1e1lz4KXgb0KOAt4f1BLIUDw=;
  b=SUxjpsvMFO68u/3x68ORUroynOC9MBO9+bsh9KypOix/KlVi18cTcxcA
   i9s8SJlj0fMY1PSy6cO1DwivcXU/RHD4hbEiJnF95dTVNFzYonBHAcInb
   P9EXGlT5ik3rFF3ori0d/+rVe5tih1JNjkX3YkRbUfKqmjr4V6kGm/GL6
   4stBD9ZGl32+ScZzRocKiT5Cc7X9MlPtdfK4yY/TLWLi1NT1H95ni83XM
   6X/18nFhQ0r2wBXL+YMDeEx/HpSzQpzbFIoxX+VtBchA75knhyAJD6yhf
   FKLRkcJFi201i3yfb75fCfQFVN3Y79wDDZHCxXOp2CvIHFzkl1Hp/JDO8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="370228506"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="370228506"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 19:08:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="620581691"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2022 19:08:33 -0700
Date:   Thu, 7 Jul 2022 10:00:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     mdf@kernel.org, lee.jones@linaro.org, russell.h.weight@intel.com,
        hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v1 2/3] fpga: m10bmc-sec: add sysfs to load bmc images
Message-ID: <20220707020009.GA3654919@yilunxu-OptiPlex-7050>
References: <20220705080058.92532-1-tianfei.zhang@intel.com>
 <20220705080058.92532-3-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705080058.92532-3-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 05, 2022 at 04:00:57AM -0400, Tianfei Zhang wrote:
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
> ---
>  .../sysfs-driver-intel-m10-bmc-sec-update     |  21 ++++
>  drivers/fpga/intel-m10-bmc-sec-update.c       | 104 ++++++++++++++++++
>  2 files changed, 125 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> index 0a41afe0ab4c..8ded1a59d4db 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> @@ -59,3 +59,24 @@ Contact:	Russ Weight <russell.h.weight@intel.com>
>  Description:	Read only. Returns number of times the secure update
>  		staging area has been flashed.
>  		Format: "%u".
> +
> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../control/available_images
> +Date:		July 2022
> +KernelVersion:  5.20
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. This file returns a space separated list of
> +		key words that may be written into the image_load file
> +		described below. These keywords decribe an FPGA, BMC,
> +		or firmware image in FLASH or EEPROM storage that may
> +		be loaded.
> +
> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../control/image_load
> +Date:		July 2022
> +KernelVersion:  5.20
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Write-only. A key word may be written to this file to
> +		trigger a reload of an FPGA, BMC, or firmware image from

A FPGA reprogramming could be handled by FPGA manager, so we may not
introduce a new API for the same purpose.

Thanks,
Yilun

> +		FLASH or EEPROM. Refer to the available_images file for a
> +		list of supported key words for the underlying device.
> +		Writing an unsupported string to this file will result in
> +		EINVAL being returned.
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 72c677c910de..640690e6c131 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -14,6 +14,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> +struct image_load;
> +
>  struct m10bmc_sec {
>  	struct device *dev;
>  	struct intel_m10bmc *m10bmc;
> @@ -21,6 +23,12 @@ struct m10bmc_sec {
>  	char *fw_name;
>  	u32 fw_name_id;
>  	bool cancel_request;
> +	struct image_load *image_load;	/* terminated with { } member */
> +};
> +
> +struct image_load {
> +	const char *name;
> +	int (*load_image)(struct m10bmc_sec *sec);
>  };
>  
>  static DEFINE_XARRAY_ALLOC(fw_upload_xa);
> @@ -137,6 +145,54 @@ DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR + CSK_VEC_OFFSET);
>  
>  #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
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
>  static ssize_t flash_count_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -195,6 +251,7 @@ static struct attribute_group m10bmc_security_attr_group = {
>  
>  static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>  	&m10bmc_security_attr_group,
> +	&m10bmc_control_attr_group,
>  	NULL,
>  };
>  
> @@ -208,6 +265,52 @@ static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>  		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
>  }
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
> +	return m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL,
> +				      DRBL_CONFIG_SEL | DRBL_REBOOT_REQ,
> +				      FIELD_PREP(DRBL_CONFIG_SEL, val) |
> +				      DRBL_REBOOT_REQ);
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
>  static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
>  {
>  	u32 doorbell;
> @@ -565,6 +668,7 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
>  	sec->dev = &pdev->dev;
>  	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>  	dev_set_drvdata(&pdev->dev, sec);
> +	sec->image_load = m10bmc_image_load_hndlrs;
>  
>  	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
>  		       xa_limit_32b, GFP_KERNEL);
> -- 
> 2.26.2
