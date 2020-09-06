Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C01C25EF02
	for <lists+linux-fpga@lfdr.de>; Sun,  6 Sep 2020 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgIFQKv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 6 Sep 2020 12:10:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42215 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726931AbgIFQKv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 6 Sep 2020 12:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599408647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evanJmvS8Oxv4e53W/nFLNAVlGlq7hvo4eyIZqMPcNQ=;
        b=IrrYDkjj9I9CLKuWXWEmKPllgRXa2rCGxfcSHiV3DmaKqPI+JwRHzALglqXELZFc1VJ2SP
        sRImCtKTmFQhw4qj0UgZFAUfZHN431LJnbB1zDFYNNmlxu4glwrgy8CTcoOyAv4syrllLA
        g656TXoQEeuSuj2GoZC2TqS9SVFFrIc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-7Vc5jUS_NYmFslNFw7Cciw-1; Sun, 06 Sep 2020 12:10:45 -0400
X-MC-Unique: 7Vc5jUS_NYmFslNFw7Cciw-1
Received: by mail-qt1-f200.google.com with SMTP id t11so7593028qtn.8
        for <linux-fpga@vger.kernel.org>; Sun, 06 Sep 2020 09:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=evanJmvS8Oxv4e53W/nFLNAVlGlq7hvo4eyIZqMPcNQ=;
        b=fc/hVatHFcYUe2mvC7m0CDCyG+3NmAXWDcE6OKJS8vQQlWM/wSd2ajbDEKdOhsbTgN
         daP0YZeHtEkocuJW48wUZMFuUN+w+OW6+X4TmeE2JdxXHe0ZkYoib4PV8mFyHCtaEvg1
         wqnXcaV8MiiS8LWb4eIR06sdVYFEaNxIjLqd3sExX6x/w+IhbA30zvXo5S4FSWrxIVKJ
         1sRfzcdEwvRwA5I3ETEgukbMDf5eXVrh7qpibh0+L/QtwfpbMTd6/zaCB0AdSMxamMxe
         2ibi4/7ZtcydQ7TeY/TaPrGZIFcXht7THbVP9iDQ2xFtfIZ1sMf7MjjrU7f4j8/j4Nim
         IRwQ==
X-Gm-Message-State: AOAM5319zke/QK1LkuVApZcRMXO/pFkGdwJVWxac2oo0JozzVWs2QaWE
        v1Zw39FQSyxoKNIJzjG2Jv6s7aQXG7A7FpUa1eAT0sC+ZHAeTqnwDE99zDoGTXwonjzhmlkCPdD
        WJKnNeXZUTby4VqvycUU9iQ==
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr16198245qkk.28.1599408644655;
        Sun, 06 Sep 2020 09:10:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb3Ml78VijBbwEbMLyNWAjtu6JS1ALgALYFs3hEmszdS1294eGuCvnByjUe6FCsIwIYFMwNg==
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr16198209qkk.28.1599408644189;
        Sun, 06 Sep 2020 09:10:44 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j88sm7249336qte.96.2020.09.06.09.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 09:10:43 -0700 (PDT)
Subject: Re: [PATCH v1 06/12] fpga: add max10 secure update functions
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-7-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3c371972-2331-a191-0acf-b880f11f2ef1@redhat.com>
Date:   Sun, 6 Sep 2020 09:10:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-7-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

With the v4 max10 change, this patch did not apply to linux-next.

So it will need at least another review when max10 lands in linux-next.

On 9/4/20 4:52 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to include
> the functions that enable secure updates of BMC images,
> FPGA images, etc.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-secure.c | 272 +++++++++++++++++++++++++++-
>  include/linux/mfd/intel-m10-bmc.h   | 101 +++++++++++
>  2 files changed, 372 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 46cd49a08be0..4a66c2d448eb 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
>   *
>   */
> +#include <linux/bitfield.h>
>  #include <linux/device.h>
>  #include <linux/fpga/ifpga-sec-mgr.h>
>  #include <linux/mfd/intel-m10-bmc.h>
> @@ -184,6 +185,271 @@ SYSFS_GET_CSK_VEC(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET)
>  SYSFS_GET_CSK_VEC(sr, SR_PROG_ADDR + CSK_VEC_OFFSET)
>  SYSFS_GET_CSK_VEC(pr, PR_PROG_ADDR + CSK_VEC_OFFSET)
>  
> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
> +{
> +	u32 auth_result;
> +
> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
> +
> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);

If the read fails, auth_result will have garbage in it.

> +}
> +
> +static enum ifpga_sec_err rsu_check_idle(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return IFPGA_SEC_ERR_RW_ERROR;
> +
> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_BUSY;
> +	}
> +
> +	return IFPGA_SEC_ERR_NONE;

Why do you need custom error codes here and below ?

Should return int and use -EIO, -EBUSY, 0

> +}
> +
> +static inline bool rsu_start_done(u32 doorbell)
> +{
> +	return (!(doorbell & RSU_REQUEST) &&
> +		(rsu_stat(doorbell) == RSU_STAT_ERASE_FAIL ||
> +		rsu_stat(doorbell) == RSU_STAT_WEAROUT ||
> +		(rsu_prog(doorbell) != RSU_PROG_IDLE &&
> +		 rsu_prog(doorbell) != RSU_PROG_RSU_DONE)));

This is complicated, try simplifying or adding a comment.

The rsu_stat & rsu_prog only need to be called once.

stat = rsu_stat(doorbell)

.. and then something like ..

if (stat & (RSU_STAT_ERASE_FAIL | RSU_STAT_WEAROUT))

> +}
> +
> +static enum ifpga_sec_err rsu_update_init(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL,
> +				     RSU_REQUEST | HOST_STATUS, RSU_REQUEST |
> +				     FIELD_PREP(HOST_STATUS, HOST_STATUS_IDLE));
> +	if (ret)
> +		return IFPGA_SEC_ERR_RW_ERROR;
> +
> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				       doorbell,
> +				       rsu_start_done(doorbell),
doorbell needs to be initialized to 0
> +				       NIOS_HANDSHAKE_INTERVAL_US,
> +				       NIOS_HANDSHAKE_TIMEOUT_US);
> +
> +	if (ret == -ETIMEDOUT) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_TIMEOUT;
> +	} else if (ret) {
> +		return IFPGA_SEC_ERR_RW_ERROR;
> +	}
> +
> +	if (rsu_stat(doorbell) == RSU_STAT_WEAROUT) {
call rsu_stat once
> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
> +		return IFPGA_SEC_ERR_WEAROUT;
> +	} else if (rsu_stat(doorbell) == RSU_STAT_ERASE_FAIL) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return IFPGA_SEC_ERR_NONE;
> +}
> +
> +static enum ifpga_sec_err rsu_prog_ready(struct m10bmc_sec *sec)
> +{
> +	unsigned long poll_timeout;
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
return here on error.
> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
> +	while (!ret && !time_after(jiffies, poll_timeout)) {
> +		if (rsu_prog(doorbell) != RSU_PROG_PREPARE)

This seems to be the main condition, consider exchanging

it for the time_after in your while() condition

> +			break;
> +		msleep(RSU_PREP_INTERVAL_MS);
> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
return here on error
> +	}
> +
> +	if (ret) {
> +		return IFPGA_SEC_ERR_RW_ERROR;
> +	} else if (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_TIMEOUT;
> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return IFPGA_SEC_ERR_NONE;
> +}
> +
> +static enum ifpga_sec_err rsu_send_data(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL, HOST_STATUS,
> +				     FIELD_PREP(HOST_STATUS,
> +						HOST_STATUS_WRITE_DONE));
> +	if (ret)
> +		return IFPGA_SEC_ERR_RW_ERROR;
> +
> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				       doorbell,
> +				       rsu_prog(doorbell) != RSU_PROG_READY,
similar to above doorbell must be initialized to 0
> +				       NIOS_HANDSHAKE_INTERVAL_US,
> +				       NIOS_HANDSHAKE_TIMEOUT_US);
> +
> +	if (ret == -ETIMEDOUT) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_TIMEOUT;
> +	} else if (ret) {
> +		return IFPGA_SEC_ERR_RW_ERROR;
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
> +		return IFPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return IFPGA_SEC_ERR_NONE;
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
> +	case RSU_STAT_WEAROUT:
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
> +static enum ifpga_sec_err m10bmc_sec_prepare(struct ifpga_sec_mgr *imgr)
> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	enum ifpga_sec_err ret;
> +
> +	if (imgr->remaining_size > M10BMC_STAGING_SIZE)
> +		return IFPGA_SEC_ERR_INVALID_SIZE;
Could this check be moved closer to when the fw is opened ?
> +
> +	ret = rsu_check_idle(sec);
> +	if (ret)
> +		return ret;
> +
> +	ret = rsu_update_init(sec);
> +	if (ret)
> +		return ret;
> +
> +	return rsu_prog_ready(sec);
> +}
> +
> +static enum ifpga_sec_err
> +m10bmc_sec_write_blk(struct ifpga_sec_mgr *imgr, u32 offset, u32 size)

Function name should be consistent with existing

m10bmc_raw_bulk_write, likely m10bmc_sec_bulk_write.

Why should not this call go in to intel-m10-bmc.c ?

the imgr parameter is only used to get to the m10bmc.

> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret) {
> +		return IFPGA_SEC_ERR_RW_ERROR;
> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	ret = m10bmc_raw_bulk_write(sec->m10bmc, M10BMC_STAGING_BASE + offset,
> +				    (void *)imgr->data + offset, size / stride);
> +
> +	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
> +}
> +
> +static enum ifpga_sec_err m10bmc_sec_poll_complete(struct ifpga_sec_mgr *imgr)
> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	unsigned long poll_timeout;
> +	enum ifpga_sec_err result;
> +	u32 doorbell;
> +	int ret;
> +
> +	result = rsu_send_data(sec);
> +	if (result)
> +		return result;
> +
> +	ret = rsu_check_complete(sec, &doorbell);
> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
Maybe a whitespace issue here.
> +	while (ret == -EAGAIN && !time_after(jiffies, poll_timeout)) {
> +		msleep(RSU_COMPLETE_INTERVAL_MS);
> +		ret = rsu_check_complete(sec, &doorbell);
> +		if (imgr->driver_unload)
> +			return IFPGA_SEC_ERR_CANCELED;
unload was not checked in other polling, why not ?
> +	}
> +
> +	if (ret == -EAGAIN) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_TIMEOUT;
> +	} else if (ret == -EIO) {
> +		return IFPGA_SEC_ERR_RW_ERROR;
> +	} else if (ret) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return IFPGA_SEC_ERR_NONE;
> +}
> +
> +static enum ifpga_sec_err m10bmc_sec_cancel(struct ifpga_sec_mgr *imgr)
> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return IFPGA_SEC_ERR_RW_ERROR;
> +
> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
> +		return IFPGA_SEC_ERR_BUSY;
> +
> +	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL, HOST_STATUS,
> +				     FIELD_PREP(HOST_STATUS,
> +						HOST_STATUS_ABORT_RSU));
> +
> +	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
> +}
> +
>  static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>  	.user_flash_count = get_qspi_flash_count,
>  	.bmc_root_entry_hash = get_bmc_root_entry_hash,
> @@ -197,7 +463,11 @@ static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>  	.pr_reh_size = get_pr_reh_size,
>  	.bmc_canceled_csk_nbits = get_bmc_csk_cancel_nbits,
>  	.sr_canceled_csk_nbits = get_sr_csk_cancel_nbits,
> -	.pr_canceled_csk_nbits = get_pr_csk_cancel_nbits
> +	.pr_canceled_csk_nbits = get_pr_csk_cancel_nbits,
> +	.prepare = m10bmc_sec_prepare,
> +	.write_blk = m10bmc_sec_write_blk,
> +	.poll_complete = m10bmc_sec_poll_complete,
> +	.cancel = m10bmc_sec_cancel
>  };
>  
>  static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h

This likely needs to be split out into it's own patch

since it is another subsystem. Deferring to Lee.

> index 7fe465c320c2..5d2860d8a0cf 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -13,6 +13,9 @@
>  #define M10BMC_SYS_BASE			0x300800
>  #define M10BMC_MEM_END			0x200000fc
>  
> +#define M10BMC_STAGING_BASE		0x18000000
> +#define M10BMC_STAGING_SIZE		0x3800000
> +
>  /* Register offset of system registers */
>  #define NIOS2_FW_VERSION		0x0
>  #define M10BMC_MACADDR1			0x10
> @@ -36,6 +39,70 @@
>  #define SERDES_VERSION			GENMASK(15, 0)
>  #define SBUS_VERSION			GENMASK(31, 16)
>  
> +/* Secure update doorbell register, in system register region */
> +#define M10BMC_DOORBELL			0x400
> +#define RSU_REQUEST			BIT(0)
> +#define RSU_PROGRESS			GENMASK(7, 4)
> +#define HOST_STATUS			GENMASK(11, 8)
> +#define RSU_STATUS			GENMASK(23, 16)
> +#define PKVL_EEPROM_LOAD_SEC		BIT(24)
> +#define PKVL1_POLL_EN			BIT(25)
> +#define PKVL2_POLL_EN			BIT(26)
> +#define CONFIG_SEL			BIT(28)
> +#define REBOOT_REQ			BIT(29)
> +#define REBOOT_DISABLED			BIT(30)
These are similar should have a prefix, likely M10BMC_SEC_
> +
> +/* Progress states */
> +#define RSU_PROG_IDLE			0x0
> +#define RSU_PROG_PREPARE		0x1
> +#define RSU_PROG_READY			0x3
> +#define RSU_PROG_AUTHENTICATING		0x4
> +#define RSU_PROG_COPYING		0x5
> +#define RSU_PROG_UPDATE_CANCEL		0x6
> +#define RSU_PROG_PROGRAM_KEY_HASH	0x7
> +#define RSU_PROG_RSU_DONE		0x8
> +#define RSU_PROG_PKVL_PROM_DONE		0x9
> +
> +/* Device and error states */
> +#define RSU_STAT_NORMAL			0x0
> +#define RSU_STAT_TIMEOUT		0x1
> +#define RSU_STAT_AUTH_FAIL		0x2
> +#define RSU_STAT_COPY_FAIL		0x3
> +#define RSU_STAT_FATAL			0x4
> +#define RSU_STAT_PKVL_REJECT		0x5
> +#define RSU_STAT_NON_INC		0x6
> +#define RSU_STAT_ERASE_FAIL		0x7
> +#define RSU_STAT_WEAROUT		0x8
> +#define RSU_STAT_NIOS_OK		0x80
> +#define RSU_STAT_USER_OK		0x81
> +#define RSU_STAT_FACTORY_OK		0x82
> +#define RSU_STAT_USER_FAIL		0x83
> +#define RSU_STAT_FACTORY_FAIL		0x84
> +#define RSU_STAT_NIOS_FLASH_ERR		0x85
> +#define RSU_STAT_FPGA_FLASH_ERR		0x86
> +
> +#define HOST_STATUS_IDLE		0x0
> +#define HOST_STATUS_WRITE_DONE		0x1
> +#define HOST_STATUS_ABORT_RSU		0x2
> +
> +#define rsu_prog(doorbell)		FIELD_GET(RSU_PROGRESS, doorbell)
> +#define rsu_stat(doorbell)		FIELD_GET(RSU_STATUS, doorbell)
> +
> +/* interval 100ms and timeout 5s */
> +#define NIOS_HANDSHAKE_INTERVAL_US	(100 * 1000)
> +#define NIOS_HANDSHAKE_TIMEOUT_US	(5 * 1000 * 1000)
> +
> +/* RSU PREP Timeout (2 minutes) to erase flash staging area */
> +#define RSU_PREP_INTERVAL_MS		100
> +#define RSU_PREP_TIMEOUT_MS		(2 * 60 * 1000)
> +
> +/* RSU Complete Timeout (40 minutes) for full flash update */
> +#define RSU_COMPLETE_INTERVAL_MS	1000
> +#define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
> +
> +/* Authorization Result register, in system register region */
> +#define M10BMC_AUTH_RESULT		0x404

Needs to move to where the other registers are

defined.

> +
>  /**
>   * struct intel_m10bmc_retimer_pdata - subdev retimer platform data
>   *
> @@ -64,7 +131,10 @@ struct intel_m10bmc {
>   *
>   * m10bmc_raw_read - read m10bmc register per addr
>   * m10bmc_raw_bulk_read - bulk_read max10 registers per addr
> + * m10bmc_raw_bulk_write - bulk_write max10 registers per addr
> + * m10bmc_raw_update_bits - update max10 register per addr
>   * m10bmc_sys_read - read m10bmc system register per offset
> + * m10bmc_sys_update_bits - update max10 system register per offset
>   */
>  static inline int
>  m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> @@ -94,7 +164,38 @@ m10bmc_raw_bulk_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>  	return ret;
>  }
>  
> +static inline int
> +m10bmc_raw_bulk_write(struct intel_m10bmc *m10bmc, unsigned int addr,
> +		      void *val, size_t cnt)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_write(m10bmc->regmap, addr, val, cnt);
> +	if (ret)
> +		dev_err(m10bmc->dev, "fail to write raw reg %x cnt %zx: %d\n",
> +			addr, cnt, ret);
> +
> +	return ret;
> +}
> +
> +static inline int
> +m10bmc_raw_update_bits(struct intel_m10bmc *m10bmc, unsigned int addr,
> +		       unsigned int msk, unsigned int val)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(m10bmc->regmap, addr, msk, val);
> +	if (ret)
> +		dev_err(m10bmc->dev, "fail to update raw reg %x: %d\n",
> +			addr, ret);
> +
> +	return ret;
> +}
> +
>  #define m10bmc_sys_read(m10bmc, offset, val) \
>  	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
>  
> +#define m10bmc_sys_update_bits(m10bmc, offset, msk, val) \
> +	m10bmc_raw_update_bits(m10bmc, M10BMC_SYS_BASE + (offset), msk, val)
> +

There is discussion on m10bmc patch around the

#define m10bmc_sys_read.

It would be better if m10bmc_sys_update_bits was a real function.

Tom

>  #endif /* __MFD_INTEL_M10_BMC_H */

