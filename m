Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E435298D5
	for <lists+linux-fpga@lfdr.de>; Tue, 17 May 2022 06:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiEQEcS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 May 2022 00:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiEQEcR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 May 2022 00:32:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF651C906;
        Mon, 16 May 2022 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652761935; x=1684297935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9vTNLR8rUQVmKegW4ri8IriB8Pt13olfhNyI0TM3Jqg=;
  b=kh/jISYCS8y+ke4zcAwV3ySH6aA/H+Y7f4MYr8ktE23y5wrq9H/kJD76
   uy9XahrEEVGzeo9bdokrvYi+bClomDutVreHz5ue79dt0DaRyD2goZFZR
   CdsJHBvErg81oPDIn439EGHQsfbLKkbIVQy1/zIjSBjI+EAarbkinSYMK
   OeGo0oxnWNUh6O2aHyqKUQ7X1zQTGH6b2p6pIyIeulZqhp4E+AZXgT+kq
   i+hPhB8Mqnyt+LvoDbakWzwb6wQmPQRLstb1di26+NoP1JB4UCwou3wVb
   kXjs1W4wXt46mDzseu3atjAry2OWW04Ud1b9hqzsYifRviUuBhSirmXW/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270998493"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="270998493"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 21:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="568681022"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 16 May 2022 21:32:11 -0700
Date:   Tue, 17 May 2022 12:24:40 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v20 4/5] fpga: m10bmc-sec: expose max10 canceled keys in
 sysfs
Message-ID: <20220517042440.GB40711@yilunxu-OptiPlex-7050>
References: <20220516234941.592886-1-russell.h.weight@intel.com>
 <20220516234941.592886-5-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516234941.592886-5-russell.h.weight@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 16, 2022 at 04:49:40PM -0700, Russ Weight wrote:
> Extend the MAX10 BMC Secure Update driver to provide sysfs files to
> expose the 128 bit code signing key (CSK) cancellation vectors. These use
> the standard bitmap list format (e.g. 1,2-6,9).
> 
> Each CSK is assigned an ID, a number between 0-127, during the signing
> process. CSK ID cancellation information is stored in 128-bit fields in
> write-once locations in flash.  The cancellation of a CSK can be used
> to prevent the card from being rolled back to older images that were
> signed with a CSK that is now cancelled.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v20:
>   - Added text to the commit message to further describe the cancellation of
>     code signing keys.
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
>   - No changes
> v13:
>   - Updated ABI documentation date and kernel version
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
> v11:
>   - No change
> v10:
>   - Changed the path expressions in the sysfs documentation to
>     replace the n3000 reference with something more generic to
>     accomodate other devices that use the same driver.
> v9:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - Previously patch 4/6, otherwise no change
> v7:
>   - Updated Date and KernelVersion in ABI documentation
> v6:
>   - Added WARN_ON() call for (size / stride) to ensure
>     that the proper count is passed to regmap_bulk_read().
> v5:
>   - No change
> v4:
>   - Moved sysfs files for displaying the code-signing-key (CSK)
>     cancellation vectors from the FPGA Security Manger class driver
>     to here. The m10bmc_csk_vector() and m10bmc_csk_cancel_nbits()
>     functions are removed and the functionality from these functions
>     is moved into a show_canceled_csk() function for for displaying
>     the CSK vectors.
>   - Added ABI documentation for new sysfs entries
> v3:
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>     driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions are now called directly.
>   - Renamed get_csk_vector() to m10bmc_csk_vector()
> v2:
>   - Replaced small function-creation macros for explicit function
>     declarations.
>   - Fixed get_csk_vector() function to properly apply the stride
>     variable in calls to m10bmc_raw_bulk_read()
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
> ---
>  .../sysfs-driver-intel-m10-bmc-sec-update     | 24 ++++++++++
>  drivers/fpga/intel-m10-bmc-sec-update.c       | 48 +++++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> index 1132e39b2125..ca5a34c1c31f 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> @@ -28,6 +28,30 @@ Description:	Read only. Returns the root entry hash for the BMC image
>  		underlying device supports it.
>  		Format: string.
>  
> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_canceled_csks
> +Date:		Jul 2022
> +KernelVersion:	5.19
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the static region. The standard bitmap
> +		list format is used (e.g. "1,2-6,9").
> +
> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_canceled_csks
> +Date:		Jul 2022
> +KernelVersion:	5.19
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the partial reconfiguration region. The
> +		standard bitmap list format is used (e.g. "1,2-6,9").
> +
> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_canceled_csks
> +Date:		Jul 2022
> +KernelVersion:	5.19
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns a list of indices for canceled code
> +		signing keys for the BMC.  The standard bitmap list format
> +		is used (e.g. "1,2-6,9").
> +
>  What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
>  Date:		Jul 2022
>  KernelVersion:	5.19
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 3f183202de3b..6c39adc6492d 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -78,6 +78,51 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>  DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>  DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>  
> +#define CSK_BIT_LEN		128U
> +#define CSK_32ARRAY_SIZE	DIV_ROUND_UP(CSK_BIT_LEN, 32)
> +
> +static ssize_t
> +show_canceled_csk(struct device *dev, u32 addr, char *buf)
> +{
> +	unsigned int i, stride, size = CSK_32ARRAY_SIZE * sizeof(u32);
> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> +	DECLARE_BITMAP(csk_map, CSK_BIT_LEN);
> +	__le32 csk_le32[CSK_32ARRAY_SIZE];
> +	u32 csk32[CSK_32ARRAY_SIZE];
> +	int ret;
> +
> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +
> +	WARN_ON(size % stride);

Same concern.

> +	ret = regmap_bulk_read(sec->m10bmc->regmap, addr, csk_le32,
> +			       size / stride);
> +	if (ret) {
> +		dev_err(sec->dev, "failed to read CSK vector: %x cnt %x: %d\n",
> +			addr, size / stride, ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < CSK_32ARRAY_SIZE; i++)
> +		csk32[i] = le32_to_cpu(((csk_le32[i])));
> +
> +	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
> +	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
> +	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
> +}
> +
> +#define DEVICE_ATTR_SEC_CSK_RO(_name, _addr) \
> +static ssize_t _name##_canceled_csks_show(struct device *dev, \
> +					  struct device_attribute *attr, \
> +					  char *buf) \
> +{ return show_canceled_csk(dev, _addr, buf); } \
> +static DEVICE_ATTR_RO(_name##_canceled_csks)
> +
> +#define CSK_VEC_OFFSET 0x34
> +
> +DEVICE_ATTR_SEC_CSK_RO(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET);
> +DEVICE_ATTR_SEC_CSK_RO(sr, SR_PROG_ADDR + CSK_VEC_OFFSET);
> +DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR + CSK_VEC_OFFSET);
> +
>  #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
>  
>  static ssize_t flash_count_show(struct device *dev,
> @@ -118,6 +163,9 @@ static struct attribute *m10bmc_security_attrs[] = {
>  	&dev_attr_bmc_root_entry_hash.attr,
>  	&dev_attr_sr_root_entry_hash.attr,
>  	&dev_attr_pr_root_entry_hash.attr,
> +	&dev_attr_sr_canceled_csks.attr,
> +	&dev_attr_pr_canceled_csks.attr,
> +	&dev_attr_bmc_canceled_csks.attr,
>  	NULL,
>  };
>  
> -- 
> 2.25.1
