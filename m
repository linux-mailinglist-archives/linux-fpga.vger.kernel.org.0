Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7BC2B72E3
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 01:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgKRAKz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 19:10:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:2096 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgKRAKz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 19:10:55 -0500
IronPort-SDR: XNw8CIrItomAM5uGcNWMG2lxA8Uz3Hy/0QYoSgIbWaz/kUWWW3m+rDBFQffOUFViobHd8mPLmD
 yqTiD0Eg44ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158069336"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158069336"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 16:10:52 -0800
IronPort-SDR: qiucrWu+mmXQbo4l5npsay5VrHQhCSvfskL2ACq9Udp/g0Yo6okST5Ta/Lquccs9J1s4R4XcV2
 ps8k81RKfH1g==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544266906"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.81.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 16:10:51 -0800
Subject: Re: [PATCH v5 5/6] fpga: m10bmc-sec: add max10 secure update
 functions
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201114005559.90860-1-russell.h.weight@intel.com>
 <20201114005559.90860-6-russell.h.weight@intel.com>
 <3c531b5d-0620-5239-06a7-02a01381c436@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <4819688e-4967-360d-6ba7-36b93735b42d@intel.com>
Date:   Tue, 17 Nov 2020 16:10:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3c531b5d-0620-5239-06a7-02a01381c436@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 11/15/20 6:17 AM, Tom Rix wrote:
> On 11/13/20 4:55 PM, Russ Weight wrote:
>> Extend the MAX10 BMC Secure Update driver to include
>> the functions that enable secure updates of BMC images,
>> FPGA images, etc.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v5:
>>   - No change
>> v4:
>>   - No change
>> v3:
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>     driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>>   - Changed calling functions of functions that return "enum fpga_sec_err"
>>     to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
>> v2:
>>   - Reworked the rsu_start_done() function to make it more readable
>>   - Reworked while-loop condition/content in rsu_prog_ready()
>>   - Minor code cleanup per review comments
>>   - Added a comment to the m10bmc_sec_poll_complete() function to
>>     explain the context (could take 30+ minutes to complete).
>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>>   - Moved MAX10 BMC address and function definitions to a separate
>>     patch.
>> ---
>>  drivers/fpga/intel-m10-bmc-secure.c | 305 +++++++++++++++++++++++++++-
>>  1 file changed, 304 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>> index 689da5bc6461..4fa8a2256088 100644
>> --- a/drivers/fpga/intel-m10-bmc-secure.c
>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>> @@ -174,7 +174,310 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>>  	NULL,
>>  };
>>  
>> -static const struct fpga_sec_mgr_ops m10bmc_sops = { };
>> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>> +{
>> +	u32 auth_result;
>> +
>> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
>> +
>> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
>> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
>> +}
>> +
>> +static enum fpga_sec_err rsu_check_idle(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FPGA_SEC_ERR_RW_ERROR;
>> +
>> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
>> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_SEC_ERR_BUSY;
>> +	}
>> +
>> +	return FPGA_SEC_ERR_NONE;
>> +}
>> +
>> +static inline bool rsu_start_done(u32 doorbell)
>> +{
>> +	u32 status, progress;
>> +
>> +	if (doorbell & DRBL_RSU_REQUEST)
>> +		return false;
>> +
>> +	status = rsu_stat(doorbell);
>> +	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
>> +		return true;
>> +
>> +	progress = rsu_prog(doorbell);
>> +	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static enum fpga_sec_err rsu_update_init(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell, status;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
>> +				 DRBL_RSU_REQUEST |
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_IDLE));
>> +	if (ret)
>> +		return FPGA_SEC_ERR_RW_ERROR;
>> +
>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				       doorbell,
>> +				       rsu_start_done(doorbell),
>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>> +
>> +	if (ret == -ETIMEDOUT) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_SEC_ERR_TIMEOUT;
>> +	} else if (ret) {
>> +		return FPGA_SEC_ERR_RW_ERROR;
>> +	}
>> +
>> +	status = rsu_stat(doorbell);
>> +	if (status == RSU_STAT_WEAROUT) {
>> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
> If wear out is going to flood logs, move this to a warn once.
There is no danger of flooding. The WEAROUT error will only be seen after 1000
flash updates have occurred - an unlikely condition. It will also only occur
once on an update, and only if they attempt to flash within 60 seconds of
power-on or within 60 seconds of a previous flash.
>
> Maybe make rsu_stat a function.
Is there a reason to prefer a function in this case? Or should I change
rsu_stat() to RSU_STAT() to make it more clear that it is a macro?

>
>> +		return FPGA_SEC_ERR_WEAROUT;
>> +	} else if (status == RSU_STAT_ERASE_FAIL) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_SEC_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FPGA_SEC_ERR_NONE;
>> +}
>> +
>> +static enum fpga_sec_err rsu_prog_ready(struct m10bmc_sec *sec)
>> +{
>> +	unsigned long poll_timeout;
>> +	u32 doorbell, progress;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FPGA_SEC_ERR_RW_ERROR;
>> +
>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
>> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
>> +		msleep(RSU_PREP_INTERVAL_MS);
>> +		if (time_after(jiffies, poll_timeout))
>> +			break;
>> +
>> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +		if (ret)
>> +			return FPGA_SEC_ERR_RW_ERROR;
>> +	}
>> +
>> +	progress = rsu_prog(doorbell);
>> +	if (progress == RSU_PROG_PREPARE) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_SEC_ERR_TIMEOUT;
>> +	} else if (progress != RSU_PROG_READY) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_SEC_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FPGA_SEC_ERR_NONE;
>> +}
>> +
>> +static enum fpga_sec_err rsu_send_data(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_HOST_STATUS,
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_WRITE_DONE));
>> +	if (ret)
>> +		return FPGA_SEC_ERR_RW_ERROR;
>> +
>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				       doorbell,
>> +				       rsu_prog(doorbell) != RSU_PROG_READY,
>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>> +
>> +	if (ret == -ETIMEDOUT) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_SEC_ERR_TIMEOUT;
>> +	} else if (ret) {
>> +		return FPGA_SEC_ERR_RW_ERROR;
>> +	}
>> +
>> +	switch (rsu_stat(doorbell)) {
>> +	case RSU_STAT_NORMAL:
>> +	case RSU_STAT_NIOS_OK:
>> +	case RSU_STAT_USER_OK:
>> +	case RSU_STAT_FACTORY_OK:
> wear out is ok below but not here. why ?
Actually, wearout should not be seen while waiting for completion
either. I'll remove it from the code below. Good catch!

>> +		break;
>> +	default:
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_SEC_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FPGA_SEC_ERR_NONE;
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
>> +static enum fpga_sec_err m10bmc_sec_prepare(struct fpga_sec_mgr *smgr)
>> +{
>> +	struct m10bmc_sec *sec = smgr->priv;
>> +	enum fpga_sec_err ret;
>> +
>> +	if (smgr->remaining_size > M10BMC_STAGING_SIZE)
>> +		return FPGA_SEC_ERR_INVALID_SIZE;
>> +
>> +	ret = rsu_check_idle(sec);
>> +	if (ret != FPGA_SEC_ERR_NONE)
>> +		return ret;
>> +
>> +	ret = rsu_update_init(sec);
>> +	if (ret != FPGA_SEC_ERR_NONE)
>> +		return ret;
>> +
>> +	return rsu_prog_ready(sec);
>> +}
>> +
>> +static enum fpga_sec_err
>> +m10bmc_sec_write_blk(struct fpga_sec_mgr *smgr, u32 offset, u32 size)
>> +{
>> +	struct m10bmc_sec *sec = smgr->priv;
>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret) {
>> +		return FPGA_SEC_ERR_RW_ERROR;
>> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_SEC_ERR_HW_ERROR;
>> +	}
>> +
>> +	ret = regmap_bulk_write(sec->m10bmc->regmap,
>> +				M10BMC_STAGING_BASE + offset,
>> +				(void *)smgr->data + offset, size / stride);
> Lose trailing bytes if (size % stride)
>
> maybe change to (size + stride - 1) / stride

Yes - I'll make this change.
>
>> +
>> +	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
>> +}
>> +
>> +/*
>> + * m10bmc_sec_poll_complete() is called after handing things off to
>> + * the BMC firmware. Depending on the type of update, it could be
>> + * 30+ minutes before the BMC firmware completes the update. The
>> + * smgr->driver_unload check allows the driver to be unloaded,
>> + * but the BMC firmware will continue the update and no further
>> + * secure updates can be started for this device until the update
>> + * is complete.
>> + */
>> +static enum fpga_sec_err m10bmc_sec_poll_complete(struct fpga_sec_mgr *smgr)
>> +{
>> +	struct m10bmc_sec *sec = smgr->priv;
>> +	unsigned long poll_timeout;
>> +	enum fpga_sec_err result;
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	result = rsu_send_data(sec);
>> +	if (result != FPGA_SEC_ERR_NONE)
>> +		return result;
>> +
>> +	ret = rsu_check_complete(sec, &doorbell);
> If the first iteration will never be successful, just replace call with
>
> ret = -EAGAIN;
It is unlikely that it would ever be successful on the first iteration.
I'll make this change, or perhaps change it to a do-while loop.

Thanks!
- Russ
>
> Tom
>
>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
>> +
>> +	while (ret == -EAGAIN && !time_after(jiffies, poll_timeout)) {
>> +		msleep(RSU_COMPLETE_INTERVAL_MS);
>> +		ret = rsu_check_complete(sec, &doorbell);
>> +		if (smgr->driver_unload)
>> +			return FPGA_SEC_ERR_CANCELED;
>> +	}
>> +
>> +	if (ret == -EAGAIN) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_SEC_ERR_TIMEOUT;
>> +	} else if (ret == -EIO) {
>> +		return FPGA_SEC_ERR_RW_ERROR;
>> +	} else if (ret) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_SEC_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FPGA_SEC_ERR_NONE;
>> +}
>> +
>> +static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
>> +{
>> +	struct m10bmc_sec *sec = smgr->priv;
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FPGA_SEC_ERR_RW_ERROR;
>> +
>> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
>> +		return FPGA_SEC_ERR_BUSY;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_HOST_STATUS,
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_ABORT_RSU));
>> +
>> +	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
>> +}
>> +
>> +static const struct fpga_sec_mgr_ops m10bmc_sops = {
>> +	.prepare = m10bmc_sec_prepare,
>> +	.write_blk = m10bmc_sec_write_blk,
>> +	.poll_complete = m10bmc_sec_poll_complete,
>> +	.cancel = m10bmc_sec_cancel,
>> +};
>>  
>>  static int m10bmc_secure_probe(struct platform_device *pdev)
>>  {

