Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D513A2737DA
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Sep 2020 03:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgIVBPs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Sep 2020 21:15:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:6699 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgIVBPs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Sep 2020 21:15:48 -0400
IronPort-SDR: /CSt2PCVWEZ6OsEkC+qvUo0EqamAaSUr2AhHJkzvpk3NV9/ye8kMMzXsFMcKXMfQ1fxu2RtLvB
 iQB92x6eKGHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222102649"
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="222102649"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 18:15:47 -0700
IronPort-SDR: oeGSoEk9imfIIEmCYRiUlBSVBR3Ee6bqBV8HO5QEWqR+7fT6hTP1sxHfc0FcWFAdhx/yDH7Kmu
 MvgVBSYHxSvg==
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="510957515"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.209.104.43])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 18:15:47 -0700
Subject: Re: [PATCH v1 06/12] fpga: add max10 secure update functions
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-7-russell.h.weight@intel.com>
 <3c371972-2331-a191-0acf-b880f11f2ef1@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <24c886c0-bd7f-fdf9-f046-2ec7cf10f81b@intel.com>
Date:   Mon, 21 Sep 2020 18:15:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3c371972-2331-a191-0acf-b880f11f2ef1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/6/20 9:10 AM, Tom Rix wrote:
> With the v4 max10 change, this patch did not apply to linux-next.
>
> So it will need at least another review when max10 lands in linux-next.
Thanks. I'll build on top of the other patchset and include a reference to the
dependency on my next submission.
>
> On 9/4/20 4:52 PM, Russ Weight wrote:
>> Extend the MAX10 BMC Security Engine driver to include
>> the functions that enable secure updates of BMC images,
>> FPGA images, etc.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Wu Hao <hao.wu@intel.com>
>> ---
>>  drivers/fpga/intel-m10-bmc-secure.c | 272 +++++++++++++++++++++++++++-
>>  include/linux/mfd/intel-m10-bmc.h   | 101 +++++++++++
>>  2 files changed, 372 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>> index 46cd49a08be0..4a66c2d448eb 100644
>> --- a/drivers/fpga/intel-m10-bmc-secure.c
>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>> @@ -5,6 +5,7 @@
>>   * Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
>>   *
>>   */
>> +#include <linux/bitfield.h>
>>  #include <linux/device.h>
>>  #include <linux/fpga/ifpga-sec-mgr.h>
>>  #include <linux/mfd/intel-m10-bmc.h>
>> @@ -184,6 +185,271 @@ SYSFS_GET_CSK_VEC(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET)
>>  SYSFS_GET_CSK_VEC(sr, SR_PROG_ADDR + CSK_VEC_OFFSET)
>>  SYSFS_GET_CSK_VEC(pr, PR_PROG_ADDR + CSK_VEC_OFFSET)
>>  
>> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>> +{
>> +	u32 auth_result;
>> +
>> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
>> +
>> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
>> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
> If the read fails, auth_result will have garbage in it.
The if condition prevents dev_err() from being called on a failure, and
auth_result is not otherwise used, so I think this is OK?
>
>> +}
>> +
>> +static enum ifpga_sec_err rsu_check_idle(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return IFPGA_SEC_ERR_RW_ERROR;
>> +
>> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
>> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
>> +		log_error_regs(sec, doorbell);
>> +		return IFPGA_SEC_ERR_BUSY;
>> +	}
>> +
>> +	return IFPGA_SEC_ERR_NONE;
> Why do you need custom error codes here and below ?
The custom error codes are used specifically in the secure update flow which
executes in the context of a kernel worker thread. Any errors that occur in
this context are to be reported as an error string using the sysfs error file
(which is implemented in a later patch). Each of the custom error codes will
have a corresponding error string assigned to it.

I initially considered using standard error numbers, but it felt like I was
overloading the meaning of some of the error numbers. For example, there is
no clear mapping between any of the existing error numbers to "flash-wearout".

>
> Should return int and use -EIO, -EBUSY, 0
>
>> +}
>> +
>> +static inline bool rsu_start_done(u32 doorbell)
>> +{
>> +	return (!(doorbell & RSU_REQUEST) &&
>> +		(rsu_stat(doorbell) == RSU_STAT_ERASE_FAIL ||
>> +		rsu_stat(doorbell) == RSU_STAT_WEAROUT ||
>> +		(rsu_prog(doorbell) != RSU_PROG_IDLE &&
>> +		 rsu_prog(doorbell) != RSU_PROG_RSU_DONE)));
> This is complicated, try simplifying or adding a comment.
>
> The rsu_stat & rsu_prog only need to be called once.
>
> stat = rsu_stat(doorbell)
>
> .. and then something like ..
>
> if (stat & (RSU_STAT_ERASE_FAIL | RSU_STAT_WEAROUT))
Sure - I'll clean this up.
>
>> +}
>> +
>> +static enum ifpga_sec_err rsu_update_init(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL,
>> +				     RSU_REQUEST | HOST_STATUS, RSU_REQUEST |
>> +				     FIELD_PREP(HOST_STATUS, HOST_STATUS_IDLE));
>> +	if (ret)
>> +		return IFPGA_SEC_ERR_RW_ERROR;
>> +
>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				       doorbell,
>> +				       rsu_start_done(doorbell),
> doorbell needs to be initialized to 0
regmap_read_poll_timeout() is a macro, and doorbell corresponds to the third parameter:

  @val: Unsigned integer variable to read the value into

"rsu_start_done(doorbell)" corresponds to the fourth parameter:

  @cond: Break condition (usually involving @val)

Initialization isn't required in this context, as rsu_start_done() will not be called 
until after doorbell is read.

>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>> +
>> +	if (ret == -ETIMEDOUT) {
>> +		log_error_regs(sec, doorbell);
>> +		return IFPGA_SEC_ERR_TIMEOUT;
>> +	} else if (ret) {
>> +		return IFPGA_SEC_ERR_RW_ERROR;
>> +	}
>> +
>> +	if (rsu_stat(doorbell) == RSU_STAT_WEAROUT) {
> call rsu_stat once
Sure, I'll remove the redundant macro calls.
>> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
>> +		return IFPGA_SEC_ERR_WEAROUT;
>> +	} else if (rsu_stat(doorbell) == RSU_STAT_ERASE_FAIL) {
>> +		log_error_regs(sec, doorbell);
>> +		return IFPGA_SEC_ERR_HW_ERROR;
>> +	}
>> +
>> +	return IFPGA_SEC_ERR_NONE;
>> +}
>> +
>> +static enum ifpga_sec_err rsu_prog_ready(struct m10bmc_sec *sec)
>> +{
>> +	unsigned long poll_timeout;
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> return here on error.
Ok. Current code falls through to the if condition at the bottom of the function, but
I can just return  IFPGA_SEC_ERR_RW_ERROR here.
>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
>> +	while (!ret && !time_after(jiffies, poll_timeout)) {
>> +		if (rsu_prog(doorbell) != RSU_PROG_PREPARE)
> This seems to be the main condition, consider exchanging
>
> it for the time_after in your while() condition
OK
>
>> +			break;
>> +		msleep(RSU_PREP_INTERVAL_MS);
>> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> return here on error
OK
>> +	}
>> +
>> +	if (ret) {
>> +		return IFPGA_SEC_ERR_RW_ERROR;
>> +	} else if (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
I'll remove the duplicate rsu_prog() macro calls as well
>> +		log_error_regs(sec, doorbell);
>> +		return IFPGA_SEC_ERR_TIMEOUT;
>> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
>> +		log_error_regs(sec, doorbell);
>> +		return IFPGA_SEC_ERR_HW_ERROR;
>> +	}
>> +
>> +	return IFPGA_SEC_ERR_NONE;
>> +}
>> +
>> +static enum ifpga_sec_err rsu_send_data(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL, HOST_STATUS,
>> +				     FIELD_PREP(HOST_STATUS,
>> +						HOST_STATUS_WRITE_DONE));
>> +	if (ret)
>> +		return IFPGA_SEC_ERR_RW_ERROR;
>> +
>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				       doorbell,
>> +				       rsu_prog(doorbell) != RSU_PROG_READY,
> similar to above doorbell must be initialized to 0
>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>> +
>> +	if (ret == -ETIMEDOUT) {
>> +		log_error_regs(sec, doorbell);
>> +		return IFPGA_SEC_ERR_TIMEOUT;
>> +	} else if (ret) {
>> +		return IFPGA_SEC_ERR_RW_ERROR;
>> +	}
>> +
>> +	switch (rsu_stat(doorbell)) {
>> +	case RSU_STAT_NORMAL:
>> +	case RSU_STAT_NIOS_OK:
>> +	case RSU_STAT_USER_OK:
>> +	case RSU_STAT_FACTORY_OK:
>> +		break;
>> +	default:
>> +		log_error_regs(sec, doorbell);
>> +		return IFPGA_SEC_ERR_HW_ERROR;
>> +	}
>> +
>> +	return IFPGA_SEC_ERR_NONE;
>> +}
>> +
>> +static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
>> +{
>> +	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
>> +		return -EIO;
>> +
>> +	switch (rsu_stat(*doorbell)) {
>> +	case RSU_STAT_NORMAL:
>> +	case RSU_STAT_NIOS_OK:
>> +	case RSU_STAT_USER_OK:
>> +	case RSU_STAT_FACTORY_OK:
>> +	case RSU_STAT_WEAROUT:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (rsu_prog(*doorbell)) {
>> +	case RSU_PROG_IDLE:
>> +	case RSU_PROG_RSU_DONE:
>> +		return 0;
>> +	case RSU_PROG_AUTHENTICATING:
>> +	case RSU_PROG_COPYING:
>> +	case RSU_PROG_UPDATE_CANCEL:
>> +	case RSU_PROG_PROGRAM_KEY_HASH:
>> +		return -EAGAIN;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static enum ifpga_sec_err m10bmc_sec_prepare(struct ifpga_sec_mgr *imgr)
>> +{
>> +	struct m10bmc_sec *sec = imgr->priv;
>> +	enum ifpga_sec_err ret;
>> +
>> +	if (imgr->remaining_size > M10BMC_STAGING_SIZE)
>> +		return IFPGA_SEC_ERR_INVALID_SIZE;
> Could this check be moved closer to when the fw is opened ?
m10bmc_sec_prepare() is the first device driver function that is invoked by the
class driver during an update, so this is actually the earliest possible place
that this check can be done, given that the staging size is device specific.
>> +
>> +	ret = rsu_check_idle(sec);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = rsu_update_init(sec);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return rsu_prog_ready(sec);
>> +}
>> +
>> +static enum ifpga_sec_err
>> +m10bmc_sec_write_blk(struct ifpga_sec_mgr *imgr, u32 offset, u32 size)
> Function name should be consistent with existing
>
> m10bmc_raw_bulk_write, likely m10bmc_sec_bulk_write.
>
> Why should not this call go in to intel-m10-bmc.c ?
>
> the imgr parameter is only used to get to the m10bmc.
This function is really in a different class than m10bmc_raw_bulk_write()
and company, which are generic read/write primitives for accessing the MAX10
address space.

This function specifically belongs to the MAX10 Secure Engine (this driver) and is
one of the call-back operations provided to the Security Manager Class driver for
doing secure updates. This is the function that transfers the image data to the
staging area in the flash. It uses the m10bmc_raw_bulk_write() function to write to
the flash.

Is the name confusing? I think it is somewhat consistent with the other Security
Manager callback functions:

    .prepare = m10bmc_sec_prepare,
    .write_blk = m10bmc_sec_write_blk,
    .poll_complete = m10bmc_sec_poll_complete,
    .cancel = m10bmc_sec_cancel



>
>> +{
>> +	struct m10bmc_sec *sec = imgr->priv;
>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret) {
>> +		return IFPGA_SEC_ERR_RW_ERROR;
>> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
>> +		log_error_regs(sec, doorbell);
>> +		return IFPGA_SEC_ERR_HW_ERROR;
>> +	}
>> +
>> +	ret = m10bmc_raw_bulk_write(sec->m10bmc, M10BMC_STAGING_BASE + offset,
>> +				    (void *)imgr->data + offset, size / stride);
>> +
>> +	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
>> +}
>> +
>> +static enum ifpga_sec_err m10bmc_sec_poll_complete(struct ifpga_sec_mgr *imgr)
>> +{
>> +	struct m10bmc_sec *sec = imgr->priv;
>> +	unsigned long poll_timeout;
>> +	enum ifpga_sec_err result;
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	result = rsu_send_data(sec);
>> +	if (result)
>> +		return result;
>> +
>> +	ret = rsu_check_complete(sec, &doorbell);
>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
> Maybe a whitespace issue here.
OK
>> +	while (ret == -EAGAIN && !time_after(jiffies, poll_timeout)) {
>> +		msleep(RSU_COMPLETE_INTERVAL_MS);
>> +		ret = rsu_check_complete(sec, &doorbell);
>> +		if (imgr->driver_unload)
>> +			return IFPGA_SEC_ERR_CANCELED;
> unload was not checked in other polling, why not ?
imgr->driver_unload is set in ifpga_sec_mgr_unregister() if someone tries
to unload the driver. In a later patch, the imgr->cancel_request is also
set in ifpga_sec_mgr_unregister(). The imgr->cancel_request flag will be
checked between the calls to m10bmc_sec_write_blk() and allows for a clean
abort of the update.

This case is special because at this point the secure update operation is
100% in the hands of the BMC firmware and there is nothing that the host
driver can do to stop it. It could take another 30+ minutes
to complete. Under these circumstances, we are not allowing this
function to be aborted with a cancel request. However, if the user uses
root privileges to force-unload the driver, then we abort.

Note that even though we are allowing the abort of the driver, the BMC
will continue doing the update in the absence of monitoring from the
host driver.

Do you think comments are required here?
>> +	}
>> +
>> +	if (ret == -EAGAIN) {
>> +		log_error_regs(sec, doorbell);
>> +		return IFPGA_SEC_ERR_TIMEOUT;
>> +	} else if (ret == -EIO) {
>> +		return IFPGA_SEC_ERR_RW_ERROR;
>> +	} else if (ret) {
>> +		log_error_regs(sec, doorbell);
>> +		return IFPGA_SEC_ERR_HW_ERROR;
>> +	}
>> +
>> +	return IFPGA_SEC_ERR_NONE;
>> +}
>> +
>> +static enum ifpga_sec_err m10bmc_sec_cancel(struct ifpga_sec_mgr *imgr)
>> +{
>> +	struct m10bmc_sec *sec = imgr->priv;
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return IFPGA_SEC_ERR_RW_ERROR;
>> +
>> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
>> +		return IFPGA_SEC_ERR_BUSY;
>> +
>> +	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL, HOST_STATUS,
>> +				     FIELD_PREP(HOST_STATUS,
>> +						HOST_STATUS_ABORT_RSU));
>> +
>> +	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
>> +}
>> +
>>  static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>>  	.user_flash_count = get_qspi_flash_count,
>>  	.bmc_root_entry_hash = get_bmc_root_entry_hash,
>> @@ -197,7 +463,11 @@ static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>>  	.pr_reh_size = get_pr_reh_size,
>>  	.bmc_canceled_csk_nbits = get_bmc_csk_cancel_nbits,
>>  	.sr_canceled_csk_nbits = get_sr_csk_cancel_nbits,
>> -	.pr_canceled_csk_nbits = get_pr_csk_cancel_nbits
>> +	.pr_canceled_csk_nbits = get_pr_csk_cancel_nbits,
>> +	.prepare = m10bmc_sec_prepare,
>> +	.write_blk = m10bmc_sec_write_blk,
>> +	.poll_complete = m10bmc_sec_poll_complete,
>> +	.cancel = m10bmc_sec_cancel
>>  };
>>  
>>  static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)
>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> This likely needs to be split out into it's own patch
>
> since it is another subsystem. Deferring to Lee.
>
>> index 7fe465c320c2..5d2860d8a0cf 100644
>> --- a/include/linux/mfd/intel-m10-bmc.h
>> +++ b/include/linux/mfd/intel-m10-bmc.h
>> @@ -13,6 +13,9 @@
>>  #define M10BMC_SYS_BASE			0x300800
>>  #define M10BMC_MEM_END			0x200000fc
>>  
>> +#define M10BMC_STAGING_BASE		0x18000000
>> +#define M10BMC_STAGING_SIZE		0x3800000
>> +
>>  /* Register offset of system registers */
>>  #define NIOS2_FW_VERSION		0x0
>>  #define M10BMC_MACADDR1			0x10
>> @@ -36,6 +39,70 @@
>>  #define SERDES_VERSION			GENMASK(15, 0)
>>  #define SBUS_VERSION			GENMASK(31, 16)
>>  
>> +/* Secure update doorbell register, in system register region */
>> +#define M10BMC_DOORBELL			0x400
>> +#define RSU_REQUEST			BIT(0)
>> +#define RSU_PROGRESS			GENMASK(7, 4)
>> +#define HOST_STATUS			GENMASK(11, 8)
>> +#define RSU_STATUS			GENMASK(23, 16)
>> +#define PKVL_EEPROM_LOAD_SEC		BIT(24)
>> +#define PKVL1_POLL_EN			BIT(25)
>> +#define PKVL2_POLL_EN			BIT(26)
>> +#define CONFIG_SEL			BIT(28)
>> +#define REBOOT_REQ			BIT(29)
>> +#define REBOOT_DISABLED			BIT(30)
> These are similar should have a prefix, likely M10BMC_SEC_
These are all fields associated with the doorbell. Perhaps a DOORBELL_ prefix?
>> +
>> +/* Progress states */
>> +#define RSU_PROG_IDLE			0x0
>> +#define RSU_PROG_PREPARE		0x1
>> +#define RSU_PROG_READY			0x3
>> +#define RSU_PROG_AUTHENTICATING		0x4
>> +#define RSU_PROG_COPYING		0x5
>> +#define RSU_PROG_UPDATE_CANCEL		0x6
>> +#define RSU_PROG_PROGRAM_KEY_HASH	0x7
>> +#define RSU_PROG_RSU_DONE		0x8
>> +#define RSU_PROG_PKVL_PROM_DONE		0x9
>> +
>> +/* Device and error states */
>> +#define RSU_STAT_NORMAL			0x0
>> +#define RSU_STAT_TIMEOUT		0x1
>> +#define RSU_STAT_AUTH_FAIL		0x2
>> +#define RSU_STAT_COPY_FAIL		0x3
>> +#define RSU_STAT_FATAL			0x4
>> +#define RSU_STAT_PKVL_REJECT		0x5
>> +#define RSU_STAT_NON_INC		0x6
>> +#define RSU_STAT_ERASE_FAIL		0x7
>> +#define RSU_STAT_WEAROUT		0x8
>> +#define RSU_STAT_NIOS_OK		0x80
>> +#define RSU_STAT_USER_OK		0x81
>> +#define RSU_STAT_FACTORY_OK		0x82
>> +#define RSU_STAT_USER_FAIL		0x83
>> +#define RSU_STAT_FACTORY_FAIL		0x84
>> +#define RSU_STAT_NIOS_FLASH_ERR		0x85
>> +#define RSU_STAT_FPGA_FLASH_ERR		0x86
>> +
>> +#define HOST_STATUS_IDLE		0x0
>> +#define HOST_STATUS_WRITE_DONE		0x1
>> +#define HOST_STATUS_ABORT_RSU		0x2
>> +
>> +#define rsu_prog(doorbell)		FIELD_GET(RSU_PROGRESS, doorbell)
>> +#define rsu_stat(doorbell)		FIELD_GET(RSU_STATUS, doorbell)
>> +
>> +/* interval 100ms and timeout 5s */
>> +#define NIOS_HANDSHAKE_INTERVAL_US	(100 * 1000)
>> +#define NIOS_HANDSHAKE_TIMEOUT_US	(5 * 1000 * 1000)
>> +
>> +/* RSU PREP Timeout (2 minutes) to erase flash staging area */
>> +#define RSU_PREP_INTERVAL_MS		100
>> +#define RSU_PREP_TIMEOUT_MS		(2 * 60 * 1000)
>> +
>> +/* RSU Complete Timeout (40 minutes) for full flash update */
>> +#define RSU_COMPLETE_INTERVAL_MS	1000
>> +#define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
>> +
>> +/* Authorization Result register, in system register region */
>> +#define M10BMC_AUTH_RESULT		0x404
> Needs to move to where the other registers are
>
> defined.
OK
>
>> +
>>  /**
>>   * struct intel_m10bmc_retimer_pdata - subdev retimer platform data
>>   *
>> @@ -64,7 +131,10 @@ struct intel_m10bmc {
>>   *
>>   * m10bmc_raw_read - read m10bmc register per addr
>>   * m10bmc_raw_bulk_read - bulk_read max10 registers per addr
>> + * m10bmc_raw_bulk_write - bulk_write max10 registers per addr
>> + * m10bmc_raw_update_bits - update max10 register per addr
>>   * m10bmc_sys_read - read m10bmc system register per offset
>> + * m10bmc_sys_update_bits - update max10 system register per offset
>>   */
>>  static inline int
>>  m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>> @@ -94,7 +164,38 @@ m10bmc_raw_bulk_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>>  	return ret;
>>  }
>>  
>> +static inline int
>> +m10bmc_raw_bulk_write(struct intel_m10bmc *m10bmc, unsigned int addr,
>> +		      void *val, size_t cnt)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_bulk_write(m10bmc->regmap, addr, val, cnt);
>> +	if (ret)
>> +		dev_err(m10bmc->dev, "fail to write raw reg %x cnt %zx: %d\n",
>> +			addr, cnt, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static inline int
>> +m10bmc_raw_update_bits(struct intel_m10bmc *m10bmc, unsigned int addr,
>> +		       unsigned int msk, unsigned int val)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(m10bmc->regmap, addr, msk, val);
>> +	if (ret)
>> +		dev_err(m10bmc->dev, "fail to update raw reg %x: %d\n",
>> +			addr, ret);
>> +
>> +	return ret;
>> +}
>> +
>>  #define m10bmc_sys_read(m10bmc, offset, val) \
>>  	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
>>  
>> +#define m10bmc_sys_update_bits(m10bmc, offset, msk, val) \
>> +	m10bmc_raw_update_bits(m10bmc, M10BMC_SYS_BASE + (offset), msk, val)
>> +
> There is discussion on m10bmc patch around the
>
> #define m10bmc_sys_read.
>
> It would be better if m10bmc_sys_update_bits was a real function.
Yes - I'll pick up Yilun's latest patches and follow his convention, make sure
it all compiles together.

Thanks for the comments!
>
> Tom
>
>>  #endif /* __MFD_INTEL_M10_BMC_H */

