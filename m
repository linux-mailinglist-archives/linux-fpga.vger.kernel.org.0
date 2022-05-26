Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2EA534B26
	for <lists+linux-fpga@lfdr.de>; Thu, 26 May 2022 10:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346547AbiEZIEF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 May 2022 04:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346594AbiEZID4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 26 May 2022 04:03:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B7ABF45;
        Thu, 26 May 2022 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653552218; x=1685088218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wuonvF7K73altdluTYgGXsyAnS+bF96NzqeUGFARRBM=;
  b=Xz2w5kVmZFHOKVTyl2DnY7kob4Kj1qs0nAue8i2cpAH8zx6kPOfnBjT+
   sssL+/TBTJm2zlF9fHyvjjsgGkIwFr8iM1rSDCQrmrnAYbXa6KrE55Tci
   CPLgmrsUTlG4wvodiNdZR4FilcRGc+2CHDKZPWZo7oQSdek62l9FvvQyc
   ThKaH4ukJw0wGBuSjXOIh2PHSn1kpJ7yUtGqMp7BcXj5sR7OptjXr/7dT
   GGvCT2GMyYYlge1oZ5bp3/YPRPHvnEahNP1MsuCBYEXg2190lxPPJPRFM
   PV1kKpe9Myv+rJM8KvTFu9biPGtVP3YDYwT36o5Rga29HDvSKnsZZ34uT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="271648678"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="271648678"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 01:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="718149360"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 01:03:34 -0700
Date:   Thu, 26 May 2022 15:55:53 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v21 3/5] fpga: m10bmc-sec: expose max10 flash update count
Message-ID: <20220526075553.GD148394@yilunxu-OptiPlex-7050>
References: <20220521003607.737734-1-russell.h.weight@intel.com>
 <20220521003607.737734-4-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521003607.737734-4-russell.h.weight@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 20, 2022 at 05:36:05PM -0700, Russ Weight wrote:
> Extend the MAX10 BMC Secure Update driver to provide a sysfs file to
> expose the flash update count.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
> v21:
>   - Replace WARN_ON(FLASH_COUNT_SIZE % stride) with a more elaborate test.
>     Return -EINVAL and write a message to the kernel log. Call WARN_ON_ONCE().
> v20:
>   - No change
> v19:
>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>     with the parent driver.
> v18:
>   - No change
> v17:
>   - Update the Date and KernelVersion for the ABI documentation to Jul 2022
>     and 5.19 respectively.
>   - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
>     future devices will not necessarily use the MAX10.
> v16:
>   - No Change
> v15:
>   - Updated the Dates and KernelVersions in the ABI documentation
> v14:
>   - No change
> v13:
>   - Updated ABI documentation date and kernel version
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
> v11:
>   - No change
> v10:
>   - Changed the path expression in the sysfs documentation to
>     replace the n3000 reference with something more generic to
>     accomodate other devices that use the same driver.
> v9:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - Previously patch 3/6, otherwise no change
> v7:
>   - Updated Date and KernelVersion in ABI documentation
> v6:
>   - Changed flash_count_show() parameter list to achieve
>     reverse-christmas tree format.
>   - Added WARN_ON() call for (FLASH_COUNT_SIZE / stride) to ensure
>     that the proper count is passed to regmap_bulk_read().
> v5:
>   - Renamed sysfs node user_flash_count to flash_count and updated the
>     sysfs documentation accordingly.
> v4:
>   - Moved the sysfs file for displaying the flash count from the
>     FPGA Security Manager class driver to here. The
>     m10bmc_user_flash_count() function is removed and the
>     functionality is moved into a user_flash_count_show()
>     function.
>   - Added ABI documentation for the new sysfs entry
> v3:
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>     driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions are now called directly.
> v2:
>   - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
>   - Minor code cleanup per review comments
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
> ---
>  .../sysfs-driver-intel-m10-bmc-sec-update     |  8 ++++
>  drivers/fpga/intel-m10-bmc-sec-update.c       | 43 +++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> index 2bb271695e14..1132e39b2125 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> @@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
>  		"hash not programmed".  This file is only visible if the
>  		underlying device supports it.
>  		Format: string.
> +
> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
> +Date:		Jul 2022
> +KernelVersion:	5.19
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns number of times the secure update
> +		staging area has been flashed.
> +		Format: "%u".
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index f9f39d2cfe5b..25b21f116976 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -78,7 +78,50 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>  DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>  DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>  
> +#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
> +
> +static ssize_t flash_count_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> +	unsigned int stride, num_bits;
> +	u8 *flash_buf;
> +	int cnt, ret;
> +
> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	num_bits = FLASH_COUNT_SIZE * 8;
> +
> +	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
> +	if (!flash_buf)
> +		return -ENOMEM;
> +
> +	if (FLASH_COUNT_SIZE % stride) {
> +		dev_err(sec->dev,
> +			"FLASH_COUNT_SIZE (0x%x) not aligned to stride (0x%x)\n",
> +			FLASH_COUNT_SIZE, stride);
> +		WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
> +			       flash_buf, FLASH_COUNT_SIZE / stride);
> +	if (ret) {
> +		dev_err(sec->dev,
> +			"failed to read flash count: %x cnt %x: %d\n",
> +			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
> +		goto exit_free;
> +	}
> +	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
> +
> +exit_free:
> +	kfree(flash_buf);
> +
> +	return ret ? : sysfs_emit(buf, "%u\n", cnt);
> +}
> +static DEVICE_ATTR_RO(flash_count);
> +
>  static struct attribute *m10bmc_security_attrs[] = {
> +	&dev_attr_flash_count.attr,
>  	&dev_attr_bmc_root_entry_hash.attr,
>  	&dev_attr_sr_root_entry_hash.attr,
>  	&dev_attr_pr_root_entry_hash.attr,
> -- 
> 2.25.1
