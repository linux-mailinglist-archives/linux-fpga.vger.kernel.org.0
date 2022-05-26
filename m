Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D377A534B09
	for <lists+linux-fpga@lfdr.de>; Thu, 26 May 2022 09:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiEZH4o (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 May 2022 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiEZH4n (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 26 May 2022 03:56:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B3C18E;
        Thu, 26 May 2022 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653551801; x=1685087801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tz/xiAuBzQIT1TMP8yd2Oz9Kuys0FLE2iks2UyVQJr0=;
  b=O07wN5hb5PBUY89tqTUXfXaD4ecbNq3ywE8pdu8KjNLGU71kCSb9cMYD
   g96WmwwVp6uLTIg3n2r+qnVtq//MjVev0fd6N1wfPY7YKwzMraXYphJrf
   phpY9QGmzpWJ4nGiVijFOxuyHBdLRUWIY83ov64zkH5T10j5Rqrsq4kP9
   ZffhdpTVyAj7lZhe3E3ZISuwUFP6Q4uXRXgQ0l/YT8p/4dj+KVYIbJgEK
   siRfe5zEUyGrsU5N8iIIjE6NodHswc2D6daMvNEd8nsMNpLX3GEBGN1UW
   ZmGoJ+Y8kx/kevrdat+vsNgrcN5WgSDqsCnXCBihD1kmPXox6grf/KInr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="299410457"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="299410457"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 00:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="602883944"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 26 May 2022 00:56:38 -0700
Date:   Thu, 26 May 2022 15:48:56 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v21 5/5] fpga: m10bmc-sec: add max10 secure update
 functions
Message-ID: <20220526074856.GA148394@yilunxu-OptiPlex-7050>
References: <20220521003607.737734-1-russell.h.weight@intel.com>
 <20220521003607.737734-6-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521003607.737734-6-russell.h.weight@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 20, 2022 at 05:36:07PM -0700, Russ Weight wrote:
> Create firmware upload ops and call the Firmware Upload support of the
> Firmware Loader subsystem to enable FPGA image uploads for secure
> updates of BMC images, FPGA images, etc.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v21:
>   - Update m10bmc_sec_prepare() to ensure that the base address for an
>     update image is aligned with stride.
>   - Update m10bmc_sec_write() to handle a block size that is not aligned
>     with stride by allocating a zero-filled block that is aligned, and
>     copying the data before calling regmap_bulk_write().
> v20:
>   - No change.
> v19:
>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>     with the parent driver.
> v18:
>   - Moved the firmware_upload_register() function here from an earlier
>     patch since this is where the required ops are provided.
>   - Moved the bmc_sec_remove() function here from an earlier patch to
>     unregister the firmware driver and do cleanup.
> v17:
>   - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
>     future devices will not necessarily use the MAX10.
>   - Change from image_load class driver to the new firmware_upload 
>     functionality of the firmware_loader.
>   - fw_upload_ops functions will return "enum fw_upload_err" data types
>     instead of integer values.
> v16:
>   - Use 0 instead of FPGA_IMAGE_ERR_NONE to indicate success.
>   - The size alignment check was moved from the FPGA Image Load framework
>     to the prepare() op.
>   - Added cancel_request boolean flag to struct m10bmc_sec.
>   - Moved the RSU cancellation logic from m10bmc_sec_cancel() to a new
>     rsu_cancel() function.
>   - The m10bmc_sec_cancel() function ONLY sets the cancel_request flag.
>     The cancel_request flag is checked at the beginning of the
>     m10bmc_sec_write() and m10bmc_sec_poll_complete() functions.
>   - Adapt to changed prototypes for the prepare() and write() ops. The
>     m10bmc_sec_write_blk() function has been renamed to
>     m10bmc_sec_write().
>   - Created a cleanup() op, m10bmc_sec_cleanup(), to attempt to cancel an
>     ongoing op during when exiting the update process.
> v15:
>   - Adapted to changes in the FPGA Image Load framework:
>     (1) All enum types (progress and errors) are now type u32
>     (2) m10bmc_sec_write_blk() adds *blk_size and max_size parameters
>         and uses *blk_size as provided by the caller.
>     (3) m10bmc_sec_poll_complete() no long checks the driver_unload
>         flag.
> v14:
>   - Changed symbol names to reflect the renaming of the Security Manager
>     Class driver to FPGA Image Load.
> v13:
>   - No change
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
>   - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
>     no longer has a size parameter, and the block size is determined
>     in this (the lower-level) driver.
> v11:
>   - No change
> v10:
>   - No change
> v9:
>   - No change
> v8:
>   - Previously patch 5/6, otherwise no change
> v7:
>   - No change
> v6:
>   - Changed (size / stride) calculation to ((size + stride - 1) / stride)
>     to ensure that the proper count is passed to regmap_bulk_write().
>   - Removed unnecessary call to rsu_check_complete() in
>     m10bmc_sec_poll_complete() and changed while loop to
>     do/while loop.
> v5:
>   - No change
> v4:
>   - No change
> v3:
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>     driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions are now called directly.
>   - Changed calling functions of functions that return "enum fpga_sec_err"
>     to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
> v2:
>   - Reworked the rsu_start_done() function to make it more readable
>   - Reworked while-loop condition/content in rsu_prog_ready()
>   - Minor code cleanup per review comments
>   - Added a comment to the m10bmc_sec_poll_complete() function to
>     explain the context (could take 30+ minutes to complete).
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>   - Moved MAX10 BMC address and function definitions to a separate
>     patch.
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 409 ++++++++++++++++++++++++
>  1 file changed, 409 insertions(+)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 65fec2a70901..7c48c47a74a6 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -17,8 +17,14 @@
>  struct m10bmc_sec {
>  	struct device *dev;
>  	struct intel_m10bmc *m10bmc;
> +	struct fw_upload *fwl;
> +	char *fw_name;
> +	u32 fw_name_id;
> +	bool cancel_request;
>  };
>  
> +static DEFINE_XARRAY_ALLOC(fw_upload_xa);
> +
>  /* Root Entry Hash (REH) support */
>  #define REH_SHA256_SIZE		32
>  #define REH_SHA384_SIZE		48
> @@ -192,10 +198,380 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>  	NULL,
>  };
>  
> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
> +{
> +	u32 auth_result;
> +
> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
> +
> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
> +}
> +
> +static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
> +		log_error_regs(sec, doorbell);
> +		return FW_UPLOAD_ERR_BUSY;
> +	}
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static inline bool rsu_start_done(u32 doorbell)
> +{
> +	u32 status, progress;
> +
> +	if (doorbell & DRBL_RSU_REQUEST)
> +		return false;
> +
> +	status = rsu_stat(doorbell);
> +	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
> +		return true;
> +
> +	progress = rsu_prog(doorbell);
> +	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
> +		return true;
> +
> +	return false;
> +}
> +
> +static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell, status;
> +	int ret;
> +
> +	ret = regmap_update_bits(sec->m10bmc->regmap,
> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
> +				 DRBL_RSU_REQUEST |
> +				 FIELD_PREP(DRBL_HOST_STATUS,
> +					    HOST_STATUS_IDLE));
> +	if (ret)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				       doorbell,
> +				       rsu_start_done(doorbell),
> +				       NIOS_HANDSHAKE_INTERVAL_US,
> +				       NIOS_HANDSHAKE_TIMEOUT_US);
> +
> +	if (ret == -ETIMEDOUT) {
> +		log_error_regs(sec, doorbell);
> +		return FW_UPLOAD_ERR_TIMEOUT;
> +	} else if (ret) {
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	}
> +
> +	status = rsu_stat(doorbell);
> +	if (status == RSU_STAT_WEAROUT) {
> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
> +		return FW_UPLOAD_ERR_WEAROUT;
> +	} else if (status == RSU_STAT_ERASE_FAIL) {
> +		log_error_regs(sec, doorbell);
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +	}
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
> +{
> +	unsigned long poll_timeout;
> +	u32 doorbell, progress;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
> +		msleep(RSU_PREP_INTERVAL_MS);
> +		if (time_after(jiffies, poll_timeout))
> +			break;
> +
> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +		if (ret)
> +			return FW_UPLOAD_ERR_RW_ERROR;
> +	}
> +
> +	progress = rsu_prog(doorbell);
> +	if (progress == RSU_PROG_PREPARE) {
> +		log_error_regs(sec, doorbell);
> +		return FW_UPLOAD_ERR_TIMEOUT;
> +	} else if (progress != RSU_PROG_READY) {
> +		log_error_regs(sec, doorbell);
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +	}
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = regmap_update_bits(sec->m10bmc->regmap,
> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				 DRBL_HOST_STATUS,
> +				 FIELD_PREP(DRBL_HOST_STATUS,
> +					    HOST_STATUS_WRITE_DONE));
> +	if (ret)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				       doorbell,
> +				       rsu_prog(doorbell) != RSU_PROG_READY,
> +				       NIOS_HANDSHAKE_INTERVAL_US,
> +				       NIOS_HANDSHAKE_TIMEOUT_US);
> +
> +	if (ret == -ETIMEDOUT) {
> +		log_error_regs(sec, doorbell);
> +		return FW_UPLOAD_ERR_TIMEOUT;
> +	} else if (ret) {
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	}
> +
> +	switch (rsu_stat(doorbell)) {
> +	case RSU_STAT_NORMAL:
> +	case RSU_STAT_NIOS_OK:
> +	case RSU_STAT_USER_OK:
> +	case RSU_STAT_FACTORY_OK:
> +		break;
> +	default:
> +		log_error_regs(sec, doorbell);
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +	}
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
> +{
> +	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
> +		return -EIO;
> +
> +	switch (rsu_stat(*doorbell)) {
> +	case RSU_STAT_NORMAL:
> +	case RSU_STAT_NIOS_OK:
> +	case RSU_STAT_USER_OK:
> +	case RSU_STAT_FACTORY_OK:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (rsu_prog(*doorbell)) {
> +	case RSU_PROG_IDLE:
> +	case RSU_PROG_RSU_DONE:
> +		return 0;
> +	case RSU_PROG_AUTHENTICATING:
> +	case RSU_PROG_COPYING:
> +	case RSU_PROG_UPDATE_CANCEL:
> +	case RSU_PROG_PROGRAM_KEY_HASH:
> +		return -EAGAIN;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
> +		return FW_UPLOAD_ERR_BUSY;
> +
> +	ret = regmap_update_bits(sec->m10bmc->regmap,
> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				 DRBL_HOST_STATUS,
> +				 FIELD_PREP(DRBL_HOST_STATUS,
> +					    HOST_STATUS_ABORT_RSU));
> +	if (ret)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	return FW_UPLOAD_ERR_CANCELED;
> +}
> +
> +static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
> +					     const u8 *data, u32 size)
> +{
> +	struct m10bmc_sec *sec = fwl->dd_handle;
> +	unsigned int stride;
> +	u32 ret;
> +
> +	sec->cancel_request = false;
> +
> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	if (!IS_ALIGNED((unsigned long)data, stride)) {
> +		dev_err(sec->dev,
> +			"%s address (0x%p) not aligned to stride (0x%x)\n",
> +			__func__, data, stride);
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	}

Why the base of the source data should be stride aligned? What prevents
the driver from reading out the unaligned data?

And this may be a too strict rule. I'm not sure who should ensure the
alignment of the firmware data? The firmware upload framework? Or a user
has no idea about the stride and cannot do the right thing.

> +
> +	if (!size || size > M10BMC_STAGING_SIZE)
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +
> +	ret = rsu_check_idle(sec);
> +	if (ret != FW_UPLOAD_ERR_NONE)
> +		return ret;
> +
> +	ret = rsu_update_init(sec);
> +	if (ret != FW_UPLOAD_ERR_NONE)
> +		return ret;
> +
> +	ret = rsu_prog_ready(sec);
> +	if (ret != FW_UPLOAD_ERR_NONE)
> +		return ret;
> +
> +	if (sec->cancel_request)
> +		return rsu_cancel(sec);
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +#define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
> +
> +static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data,
> +					   u32 offset, u32 size, u32 *written)
> +{
> +	struct m10bmc_sec *sec = fwl->dd_handle;
> +	u32 blk_size, doorbell;
> +	unsigned int stride;
> +	u8 *blk_addr;
> +	int ret;
> +
> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	if (sec->cancel_request)
> +		return rsu_cancel(sec);
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret) {
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
> +		log_error_regs(sec, doorbell);
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +	}
> +
> +	WARN_ON_ONCE(WRITE_BLOCK_SIZE % stride);
> +	blk_size = min_t(u32, WRITE_BLOCK_SIZE, size);
> +
> +	/*
> +	 * If the source data size does not align to stride, then create
> +	 * a temporary buffer that is aligned, copy the data, and use the
> +	 * temporary buffer as the source for the write.
> +	 */
> +	if (blk_size % stride) {
> +		blk_addr = kzalloc(blk_size + blk_size % stride, GFP_KERNEL);
> +		if (!blk_addr)
> +			return FW_UPLOAD_ERR_RW_ERROR;
> +		memcpy(blk_addr, data + offset, blk_size);

You don't have to alloc and copy the whole block, just copy the last unaligned
bytes to a local variable and regmap_write().

Others are good to me.

Thanks,
Yilun

> +	} else {
> +		blk_addr = (u8 *)data + offset;
> +	}
> +
> +	ret = regmap_bulk_write(sec->m10bmc->regmap,
> +				M10BMC_STAGING_BASE + offset, blk_addr,
> +				(blk_size + stride - 1) / stride);
> +
> +	if (blk_size % stride)
> +		kfree(blk_addr);
> +
> +	if (ret)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	*written = blk_size;
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static enum fw_upload_err m10bmc_sec_poll_complete(struct fw_upload *fwl)
> +{
> +	struct m10bmc_sec *sec = fwl->dd_handle;
> +	unsigned long poll_timeout;
> +	u32 doorbell, result;
> +	int ret;
> +
> +	if (sec->cancel_request)
> +		return rsu_cancel(sec);
> +
> +	result = rsu_send_data(sec);
> +	if (result != FW_UPLOAD_ERR_NONE)
> +		return result;
> +
> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
> +	do {
> +		msleep(RSU_COMPLETE_INTERVAL_MS);
> +		ret = rsu_check_complete(sec, &doorbell);
> +	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
> +
> +	if (ret == -EAGAIN) {
> +		log_error_regs(sec, doorbell);
> +		return FW_UPLOAD_ERR_TIMEOUT;
> +	} else if (ret == -EIO) {
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	} else if (ret) {
> +		log_error_regs(sec, doorbell);
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +	}
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +/*
> + * m10bmc_sec_cancel() may be called asynchronously with an on-going update.
> + * All other functions are called sequentially in a single thread. To avoid
> + * contention on register accesses, m10bmc_sec_cancel() must only update
> + * the cancel_request flag. Other functions will check this flag and handle
> + * the cancel request synchronously.
> + */
> +static void m10bmc_sec_cancel(struct fw_upload *fwl)
> +{
> +	struct m10bmc_sec *sec = fwl->dd_handle;
> +
> +	sec->cancel_request = true;
> +}
> +
> +static void m10bmc_sec_cleanup(struct fw_upload *fwl)
> +{
> +	struct m10bmc_sec *sec = fwl->dd_handle;
> +
> +	(void)rsu_cancel(sec);
> +}
> +
> +static const struct fw_upload_ops m10bmc_ops = {
> +	.prepare = m10bmc_sec_prepare,
> +	.write = m10bmc_sec_write,
> +	.poll_complete = m10bmc_sec_poll_complete,
> +	.cancel = m10bmc_sec_cancel,
> +	.cleanup = m10bmc_sec_cleanup,
> +};
> +
>  #define SEC_UPDATE_LEN_MAX 32
>  static int m10bmc_sec_probe(struct platform_device *pdev)
>  {
> +	char buf[SEC_UPDATE_LEN_MAX];
>  	struct m10bmc_sec *sec;
> +	struct fw_upload *fwl;
> +	unsigned int len;
> +	int  ret;
>  
>  	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>  	if (!sec)
> @@ -205,6 +581,38 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
>  	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>  	dev_set_drvdata(&pdev->dev, sec);
>  
> +	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
> +		       xa_limit_32b, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
> +			sec->fw_name_id);
> +	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
> +	if (!sec->fw_name)
> +		return -ENOMEM;
> +
> +	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
> +				       &m10bmc_ops, sec);
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
> +static int m10bmc_sec_remove(struct platform_device *pdev)
> +{
> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
> +
> +	firmware_upload_unregister(sec->fwl);
> +	kfree(sec->fw_name);
> +	xa_erase(&fw_upload_xa, sec->fw_name_id);
> +
>  	return 0;
>  }
>  
> @@ -218,6 +626,7 @@ MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
>  
>  static struct platform_driver intel_m10bmc_sec_driver = {
>  	.probe = m10bmc_sec_probe,
> +	.remove = m10bmc_sec_remove,
>  	.driver = {
>  		.name = "intel-m10bmc-sec-update",
>  		.dev_groups = m10bmc_sec_attr_groups,
> -- 
> 2.25.1
