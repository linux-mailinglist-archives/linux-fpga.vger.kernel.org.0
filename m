Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D05F407A34
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Sep 2021 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhIKTKH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Sep 2021 15:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233539AbhIKTKG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 11 Sep 2021 15:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631387333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EjhexfgwdvzSPrJhVv2ceyZds8AfTQDcf2jh+ib5d8I=;
        b=A13EdvlViPY2FkQhk8CbcX0PCfj8ME0sJnXWUM7Lt3vVH+PXUfchvFcQKxfaFyCM64AQN5
        XKQ1pNtbUgRbm8LQOvy631CDxbT7T7Trcf0npdodfWeqW0j1EdAiTHIMXETBw533adVvUz
        MK/RcT45Lrdsm/SXkGKFMo3deT2N6r8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-L0IqfvdTNSa5oIEumeNZPg-1; Sat, 11 Sep 2021 15:08:51 -0400
X-MC-Unique: L0IqfvdTNSa5oIEumeNZPg-1
Received: by mail-qt1-f199.google.com with SMTP id q19-20020ac87353000000b0029a09eca2afso51716994qtp.21
        for <linux-fpga@vger.kernel.org>; Sat, 11 Sep 2021 12:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EjhexfgwdvzSPrJhVv2ceyZds8AfTQDcf2jh+ib5d8I=;
        b=EJWyNJZZEGfgu3GZs4J2iYkj0AqQ77kljOtu0TK4OnL1e7/435bBbMut4sNqGHvSaf
         Hmnlcbd7rskgFJS4lFTenLdxGfS3A/UWnwJOg1O9XSb8UJvxoBSBavFk5RkMDA/Vbbbp
         1pcPfluTFMJU3L2TiXlSfz8e9gnQHAUKW1mLgS9tmOl0XKvqlmKZoSja89o5WtFb/DMx
         jXReq4/QJdZLu9IXXNmHzEkZJee3aKggjTpNZrubKcwJ/TWKqWC9KZYISiR6YKtLA4bZ
         xhZI6hhrN0DMuC5KRttSRgCuHhnA6vxNyU/yEAWdL0Z11mZcA0opI7cZx8OCEiU/2YZ6
         ogBw==
X-Gm-Message-State: AOAM530Qywq/GqqGOFds5cM01WiM86FxRp5W+a0HrIjWodHEAtylK39L
        4TVR2CgNfGjncSyyWcptyPDZRk31j+fRCpdwELjQaBQt2JXPsBUVsNjXFSXnkMbb4XyHLOLWMno
        7svZ2D/HDsjgYTYh8pB9uBg==
X-Received: by 2002:a0c:f047:: with SMTP id b7mr3283699qvl.15.1631387331217;
        Sat, 11 Sep 2021 12:08:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOHV/dHNqB1NsKWOhnbJ+sFaXJMjAvR4+tdoAt+onUBUDfRvzYUvsZZDvuR9dpc6Btx0tuyw==
X-Received: by 2002:a0c:f047:: with SMTP id b7mr3283688qvl.15.1631387331013;
        Sat, 11 Sep 2021 12:08:51 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n18sm1761646qkn.63.2021.09.11.12.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 12:08:50 -0700 (PDT)
Subject: Re: [PATCH v14 4/4] fpga: m10bmc-sec: add max10 secure update
 functions
To:     Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20210909233304.5650-1-russell.h.weight@intel.com>
 <20210909233304.5650-5-russell.h.weight@intel.com>
 <20210910153347.GC757507@yilunxu-OptiPlex-7050>
 <c5bc9aae-63f7-7fc2-1e41-6945e11c3f53@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0633f0a3-2df3-d02f-a8ed-cf85bdcfa2a6@redhat.com>
Date:   Sat, 11 Sep 2021 12:08:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c5bc9aae-63f7-7fc2-1e41-6945e11c3f53@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/10/21 1:40 PM, Russ Weight wrote:
>
> On 9/10/21 8:33 AM, Xu Yilun wrote:
>> On Thu, Sep 09, 2021 at 04:33:04PM -0700, Russ Weight wrote:
>>> Invoke an instance of the FPGA Image Load driver and extend the MAX10
>>> BMC Secure Update driver to include the functions that enable secure
>>> updates of BMC images, FPGA images, etc.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> ---
>>> v14:
>>>    - Changed symbol names to reflect the renaming of the Security Manager
>>>      Class driver to FPGA Image Load.
>>> v13:
>>>    - No change
>>> v12:
>>>    - Updated Date and KernelVersion fields in ABI documentation
>>>    - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
>>>      no longer has a size parameter, and the block size is determined
>>>      in this (the lower-level) driver.
>>> v11:
>>>    - No change
>>> v10:
>>>    - No change
>>> v9:
>>>    - No change
>>> v8:
>>>    - Previously patch 5/6, otherwise no change
>>> v7:
>>>    - No change
>>> v6:
>>>    - Changed (size / stride) calculation to ((size + stride - 1) / stride)
>>>      to ensure that the proper count is passed to regmap_bulk_write().
>>>    - Removed unnecessary call to rsu_check_complete() in
>>>      m10bmc_sec_poll_complete() and changed while loop to
>>>      do/while loop.
>>> v5:
>>>    - No change
>>> v4:
>>>    - No change
>>> v3:
>>>    - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>>    - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>>      driver"
>>>    - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>>      underlying functions are now called directly.
>>>    - Changed calling functions of functions that return "enum fpga_sec_err"
>>>      to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
>>> v2:
>>>    - Reworked the rsu_start_done() function to make it more readable
>>>    - Reworked while-loop condition/content in rsu_prog_ready()
>>>    - Minor code cleanup per review comments
>>>    - Added a comment to the m10bmc_sec_poll_complete() function to
>>>      explain the context (could take 30+ minutes to complete).
>>>    - Added m10bmc_ prefix to functions in m10bmc_iops structure
>>>    - Moved MAX10 BMC address and function definitions to a separate
>>>      patch.
>>> ---
>>>   drivers/fpga/intel-m10-bmc-secure.c | 310 +++++++++++++++++++++++++++-
>>>   1 file changed, 309 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>>> index ae1383d13bfc..025655684d00 100644
>>> --- a/drivers/fpga/intel-m10-bmc-secure.c
>>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>>> @@ -181,7 +181,315 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>>>   	NULL,
>>>   };
>>>   
>>> -static const struct fpga_image_load_ops m10bmc_lops = { };
>>> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>>> +{
>>> +	u32 auth_result;
>>> +
>>> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
>>> +
>>> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
>>> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
>>> +}
>>> +
>>> +static enum fpga_image_err rsu_check_idle(struct m10bmc_sec *sec)
>>> +{
>>> +	u32 doorbell;
>>> +	int ret;
>>> +
>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>> +	if (ret)
>>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>>> +
>>> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
>>> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
>>> +		log_error_regs(sec, doorbell);
>>> +		return FPGA_IMAGE_ERR_BUSY;
>>> +	}
>>> +
>>> +	return FPGA_IMAGE_ERR_NONE;
>>> +}
>>> +
>>> +static inline bool rsu_start_done(u32 doorbell)
>>> +{
>>> +	u32 status, progress;
>>> +
>>> +	if (doorbell & DRBL_RSU_REQUEST)
>>> +		return false;
>>> +
>>> +	status = rsu_stat(doorbell);
>>> +	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
>>> +		return true;
>>> +
>>> +	progress = rsu_prog(doorbell);
>>> +	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +static enum fpga_image_err rsu_update_init(struct m10bmc_sec *sec)
>>> +{
>>> +	u32 doorbell, status;
>>> +	int ret;
>>> +
>>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>> +				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
>>> +				 DRBL_RSU_REQUEST |
>>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>>> +					    HOST_STATUS_IDLE));
>>> +	if (ret)
>>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>>> +
>>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>> +				       doorbell,
>>> +				       rsu_start_done(doorbell),
>>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>>> +
>>> +	if (ret == -ETIMEDOUT) {
>>> +		log_error_regs(sec, doorbell);
>>> +		return FPGA_IMAGE_ERR_TIMEOUT;
>>> +	} else if (ret) {
>>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>>> +	}
>>> +
>>> +	status = rsu_stat(doorbell);
>>> +	if (status == RSU_STAT_WEAROUT) {
>>> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
>>> +		return FPGA_IMAGE_ERR_WEAROUT;
>>> +	} else if (status == RSU_STAT_ERASE_FAIL) {
>>> +		log_error_regs(sec, doorbell);
>>> +		return FPGA_IMAGE_ERR_HW_ERROR;
>>> +	}
>>> +
>>> +	return FPGA_IMAGE_ERR_NONE;
>>> +}
>>> +
>>> +static enum fpga_image_err rsu_prog_ready(struct m10bmc_sec *sec)
>>> +{
>>> +	unsigned long poll_timeout;
>>> +	u32 doorbell, progress;
>>> +	int ret;
>>> +
>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>> +	if (ret)
>>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>>> +
>>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
>>> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
>>> +		msleep(RSU_PREP_INTERVAL_MS);
>>> +		if (time_after(jiffies, poll_timeout))
>>> +			break;
>>> +
>>> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>> +		if (ret)
>>> +			return FPGA_IMAGE_ERR_RW_ERROR;
>>> +	}
>>> +
>>> +	progress = rsu_prog(doorbell);
>>> +	if (progress == RSU_PROG_PREPARE) {
>>> +		log_error_regs(sec, doorbell);
>>> +		return FPGA_IMAGE_ERR_TIMEOUT;
>>> +	} else if (progress != RSU_PROG_READY) {
>>> +		log_error_regs(sec, doorbell);
>>> +		return FPGA_IMAGE_ERR_HW_ERROR;
>>> +	}
>>> +
>>> +	return FPGA_IMAGE_ERR_NONE;
>>> +}
>>> +
>>> +static enum fpga_image_err rsu_send_data(struct m10bmc_sec *sec)
>>> +{
>>> +	u32 doorbell;
>>> +	int ret;
>>> +
>>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>> +				 DRBL_HOST_STATUS,
>>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>>> +					    HOST_STATUS_WRITE_DONE));
>>> +	if (ret)
>>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>>> +
>>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>> +				       doorbell,
>>> +				       rsu_prog(doorbell) != RSU_PROG_READY,
>>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>>> +
>>> +	if (ret == -ETIMEDOUT) {
>>> +		log_error_regs(sec, doorbell);
>>> +		return FPGA_IMAGE_ERR_TIMEOUT;
>>> +	} else if (ret) {
>>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>>> +	}
>>> +
>>> +	switch (rsu_stat(doorbell)) {
>>> +	case RSU_STAT_NORMAL:
>>> +	case RSU_STAT_NIOS_OK:
>>> +	case RSU_STAT_USER_OK:
>>> +	case RSU_STAT_FACTORY_OK:
>>> +		break;
>>> +	default:
>>> +		log_error_regs(sec, doorbell);
>>> +		return FPGA_IMAGE_ERR_HW_ERROR;
>>> +	}
>>> +
>>> +	return FPGA_IMAGE_ERR_NONE;
>>> +}
>>> +
>>> +static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
>>> +{
>>> +	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
>>> +		return -EIO;
>>> +
>>> +	switch (rsu_stat(*doorbell)) {
>>> +	case RSU_STAT_NORMAL:
>>> +	case RSU_STAT_NIOS_OK:
>>> +	case RSU_STAT_USER_OK:
>>> +	case RSU_STAT_FACTORY_OK:
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	switch (rsu_prog(*doorbell)) {
>>> +	case RSU_PROG_IDLE:
>>> +	case RSU_PROG_RSU_DONE:
>>> +		return 0;
>>> +	case RSU_PROG_AUTHENTICATING:
>>> +	case RSU_PROG_COPYING:
>>> +	case RSU_PROG_UPDATE_CANCEL:
>>> +	case RSU_PROG_PROGRAM_KEY_HASH:
>>> +		return -EAGAIN;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +}
>>> +
>>> +static enum fpga_image_err m10bmc_sec_prepare(struct fpga_image_load *imgld)
>>> +{
>>> +	struct m10bmc_sec *sec = imgld->priv;
>>> +	enum fpga_image_err ret;
>>> +
>>> +	if (imgld->remaining_size > M10BMC_STAGING_SIZE)
>>> +		return FPGA_IMAGE_ERR_INVALID_SIZE;
>>> +
>>> +	ret = rsu_check_idle(sec);
>>> +	if (ret != FPGA_IMAGE_ERR_NONE)
>>> +		return ret;
>>> +
>>> +	ret = rsu_update_init(sec);
>>> +	if (ret != FPGA_IMAGE_ERR_NONE)
>>> +		return ret;
>>> +
>>> +	return rsu_prog_ready(sec);
>>> +}
>>> +
>>> +#define WRITE_BLOCK_SIZE 0x4000 /* Update remaining_size every 0x4000 bytes */
>>> +
>>> +static enum fpga_image_err
>>> +m10bmc_sec_write_blk(struct fpga_image_load *imgld, u32 offset)
>>> +{
>>> +	struct m10bmc_sec *sec = imgld->priv;
>>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>>> +	u32 doorbell, blk_size;
>>> +	int ret;
>>> +
>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>> +	if (ret) {
>>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>>> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
>>> +		log_error_regs(sec, doorbell);
>>> +		return FPGA_IMAGE_ERR_HW_ERROR;
>>> +	}
>>> +
>>> +	blk_size = min_t(u32, imgld->remaining_size, WRITE_BLOCK_SIZE);
>>> +	ret = regmap_bulk_write(sec->m10bmc->regmap,
>>> +				M10BMC_STAGING_BASE + offset,
>>> +				(void *)imgld->data + offset,
>>> +				(blk_size + stride - 1) / stride);
>>> +
>>> +	if (ret)
>>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>>> +
>>> +	imgld->remaining_size -= blk_size;
>>> +	return FPGA_IMAGE_ERR_NONE;
>>> +}
>>> +
>>> +/*
>>> + * m10bmc_sec_poll_complete() is called after handing things off to
>>> + * the BMC firmware. Depending on the type of update, it could be
>>> + * 30+ minutes before the BMC firmware completes the update. The
>>> + * imgld->driver_unload check allows the driver to be unloaded,
>>> + * but the BMC firmware will continue the update and no further
>>> + * secure updates can be started for this device until the update
>>> + * is complete.
>>> + */
>>> +static enum fpga_image_err m10bmc_sec_poll_complete(struct fpga_image_load *imgld)
>>> +{
>>> +	struct m10bmc_sec *sec = imgld->priv;
>>> +	unsigned long poll_timeout;
>>> +	enum fpga_image_err result;
>>> +	u32 doorbell;
>>> +	int ret;
>>> +
>>> +	result = rsu_send_data(sec);
>>> +	if (result != FPGA_IMAGE_ERR_NONE)
>>> +		return result;
>>> +
>>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
>>> +	do {
>>> +		msleep(RSU_COMPLETE_INTERVAL_MS);
>>> +		ret = rsu_check_complete(sec, &doorbell);
>>> +		if (imgld->driver_unload)
>>> +			return FPGA_IMAGE_ERR_CANCELED;
>> Why we return CANCELED error code to user when driver unload is
>> requested?
>>
>> Users may think the update is failed and the old image is kept,
>> but in fact, the update continues and finally the old image is
>> replaced by the new one.
> I could return FPGA_IMAGE_ERR_NONE, and then userspace code would
> think that the update completed without error, even though the
> update is still in progress.
>
> Or I could create a new FPGA_IMAGE_ERR_EXIT code to indicate that
> the driver has exited while the update is still progressing.
>
> I like the FPGA_IMAGE_ERR_EXIT option best of those two options.
> Any other suggestions?

No device so, -ENODEV

Tom

>
> Thanks,
> - Russ
>
>
>> Thanks,
>> Yilun
>>
>>> +	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
>>> +
>>> +	if (ret == -EAGAIN) {
>>> +		log_error_regs(sec, doorbell);
>>> +		return FPGA_IMAGE_ERR_TIMEOUT;
>>> +	} else if (ret == -EIO) {
>>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>>> +	} else if (ret) {
>>> +		log_error_regs(sec, doorbell);
>>> +		return FPGA_IMAGE_ERR_HW_ERROR;
>>> +	}
>>> +
>>> +	return FPGA_IMAGE_ERR_NONE;
>>> +}
>>> +
>>> +static enum fpga_image_err m10bmc_sec_cancel(struct fpga_image_load *imgld)
>>> +{
>>> +	struct m10bmc_sec *sec = imgld->priv;
>>> +	u32 doorbell;
>>> +	int ret;
>>> +
>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>> +	if (ret)
>>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>>> +
>>> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
>>> +		return FPGA_IMAGE_ERR_BUSY;
>>> +
>>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>> +				 DRBL_HOST_STATUS,
>>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>>> +					    HOST_STATUS_ABORT_RSU));
>>> +
>>> +	return ret ? FPGA_IMAGE_ERR_RW_ERROR : FPGA_IMAGE_ERR_NONE;
>>> +}
>>> +
>>> +static const struct fpga_image_load_ops m10bmc_lops = {
>>> +	.prepare = m10bmc_sec_prepare,
>>> +	.write_blk = m10bmc_sec_write_blk,
>>> +	.poll_complete = m10bmc_sec_poll_complete,
>>> +	.cancel = m10bmc_sec_cancel,
>>> +};
>>>   
>>>   static int m10bmc_secure_probe(struct platform_device *pdev)
>>>   {
>>> -- 
>>> 2.25.1

