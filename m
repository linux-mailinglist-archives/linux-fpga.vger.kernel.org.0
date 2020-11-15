Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B348E2B353A
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 15:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgKOORL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 09:17:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbgKOORL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 15 Nov 2020 09:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605449828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/xkffaVnP2j5GFtsDZ95jd9ooHsi00279H6aPA0Cy0=;
        b=bovlxaYL3yxWQFPoY3ajNa698TWXgI39X+3YT8W6FjRvnoKUWdUdxGZ2waKLkdxJ1pUrNT
        YI4XhbVRCSQ67TrgpgHnaim/z7tQe0f37k0tNvw/WiK7hzXwzS0zQzlybzbmD+ugxvHLgK
        ZCFlvblvMktmoMP933cOnTeHe746j6c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-iWgYNI4RP_eC-94TWm-PHg-1; Sun, 15 Nov 2020 09:17:06 -0500
X-MC-Unique: iWgYNI4RP_eC-94TWm-PHg-1
Received: by mail-qt1-f200.google.com with SMTP id y5so8591672qtb.13
        for <linux-fpga@vger.kernel.org>; Sun, 15 Nov 2020 06:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=i/xkffaVnP2j5GFtsDZ95jd9ooHsi00279H6aPA0Cy0=;
        b=l6eSNPCQiO2LX3MCpvsw7cgluXymRZI9w9LraVcIrRP7rgJU2pHVwVCoS7YthwdbdG
         /AJdB+KmCd5T2E9nZro38LDml3DCP+cLNzX6IoIQWJELb1mdjzmhE/gC+rlNzPnYzVmp
         yuGKZvH/oNKH45Ffg3Xk9jARnxelMOWYAgXrfRTW2ZaneLZ8v8yelB+ok9gu0mrpFWuh
         To2mShDLchDk3c5WqnKjAYxjhdSdzULyXDU3TYQA9yg9UjxMpUi6zpP2XcIk4j+B1R+r
         loC0rGDS7nQFMjvT8qj4GuOZ7o1o7RPy4hIGfq5syWhhgPGYhptV/gzOiX1z1NxMbXEU
         cZHA==
X-Gm-Message-State: AOAM5320d1BYJzj7AF6lI5aYWaLNTf6/mdnQBPk6jgRuRWHyc9xnMV7T
        epclMOyqeLd//nxIUs8KMCRZU2Q5ZNYSbbU3Vs8V+ozc+2Lc/PPOzNOVMsJn8u3mAuoXNKCaoxp
        L4pgnj1xmNK9G32w3ZLb9Sg==
X-Received: by 2002:ac8:37f2:: with SMTP id e47mr10277753qtc.290.1605449826132;
        Sun, 15 Nov 2020 06:17:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQrD/XD3TOwrX4XwPtzX+My34Euw5n+51ponJWFm3FmkyVgLj3WufxVXlFExCb5sVigcDV7Q==
X-Received: by 2002:ac8:37f2:: with SMTP id e47mr10277735qtc.290.1605449825900;
        Sun, 15 Nov 2020 06:17:05 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m15sm11188700qtc.90.2020.11.15.06.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 06:17:05 -0800 (PST)
Subject: Re: [PATCH v5 5/6] fpga: m10bmc-sec: add max10 secure update
 functions
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201114005559.90860-1-russell.h.weight@intel.com>
 <20201114005559.90860-6-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3c531b5d-0620-5239-06a7-02a01381c436@redhat.com>
Date:   Sun, 15 Nov 2020 06:17:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201114005559.90860-6-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/13/20 4:55 PM, Russ Weight wrote:
> Extend the MAX10 BMC Secure Update driver to include
> the functions that enable secure updates of BMC images,
> FPGA images, etc.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
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
>  drivers/fpga/intel-m10-bmc-secure.c | 305 +++++++++++++++++++++++++++-
>  1 file changed, 304 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 689da5bc6461..4fa8a2256088 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -174,7 +174,310 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>  	NULL,
>  };
>  
> -static const struct fpga_sec_mgr_ops m10bmc_sops = { };
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
> +static enum fpga_sec_err rsu_check_idle(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return FPGA_SEC_ERR_RW_ERROR;
> +
> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_BUSY;
> +	}
> +
> +	return FPGA_SEC_ERR_NONE;
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
> +static enum fpga_sec_err rsu_update_init(struct m10bmc_sec *sec)
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
> +		return FPGA_SEC_ERR_RW_ERROR;
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
> +		return FPGA_SEC_ERR_TIMEOUT;
> +	} else if (ret) {
> +		return FPGA_SEC_ERR_RW_ERROR;
> +	}
> +
> +	status = rsu_stat(doorbell);
> +	if (status == RSU_STAT_WEAROUT) {
> +		dev_warn(sec->dev, "Excessive flash update count detected\n");

If wear out is going to flood logs, move this to a warn once.

Maybe make rsu_stat a function.

> +		return FPGA_SEC_ERR_WEAROUT;
> +	} else if (status == RSU_STAT_ERASE_FAIL) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return FPGA_SEC_ERR_NONE;
> +}
> +
> +static enum fpga_sec_err rsu_prog_ready(struct m10bmc_sec *sec)
> +{
> +	unsigned long poll_timeout;
> +	u32 doorbell, progress;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return FPGA_SEC_ERR_RW_ERROR;
> +
> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
> +		msleep(RSU_PREP_INTERVAL_MS);
> +		if (time_after(jiffies, poll_timeout))
> +			break;
> +
> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +		if (ret)
> +			return FPGA_SEC_ERR_RW_ERROR;
> +	}
> +
> +	progress = rsu_prog(doorbell);
> +	if (progress == RSU_PROG_PREPARE) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_TIMEOUT;
> +	} else if (progress != RSU_PROG_READY) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return FPGA_SEC_ERR_NONE;
> +}
> +
> +static enum fpga_sec_err rsu_send_data(struct m10bmc_sec *sec)
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
> +		return FPGA_SEC_ERR_RW_ERROR;
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
> +		return FPGA_SEC_ERR_TIMEOUT;
> +	} else if (ret) {
> +		return FPGA_SEC_ERR_RW_ERROR;
> +	}
> +
> +	switch (rsu_stat(doorbell)) {
> +	case RSU_STAT_NORMAL:
> +	case RSU_STAT_NIOS_OK:
> +	case RSU_STAT_USER_OK:
> +	case RSU_STAT_FACTORY_OK:
wear out is ok below but not here. why ?
> +		break;
> +	default:
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return FPGA_SEC_ERR_NONE;
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
> +static enum fpga_sec_err m10bmc_sec_prepare(struct fpga_sec_mgr *smgr)
> +{
> +	struct m10bmc_sec *sec = smgr->priv;
> +	enum fpga_sec_err ret;
> +
> +	if (smgr->remaining_size > M10BMC_STAGING_SIZE)
> +		return FPGA_SEC_ERR_INVALID_SIZE;
> +
> +	ret = rsu_check_idle(sec);
> +	if (ret != FPGA_SEC_ERR_NONE)
> +		return ret;
> +
> +	ret = rsu_update_init(sec);
> +	if (ret != FPGA_SEC_ERR_NONE)
> +		return ret;
> +
> +	return rsu_prog_ready(sec);
> +}
> +
> +static enum fpga_sec_err
> +m10bmc_sec_write_blk(struct fpga_sec_mgr *smgr, u32 offset, u32 size)
> +{
> +	struct m10bmc_sec *sec = smgr->priv;
> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret) {
> +		return FPGA_SEC_ERR_RW_ERROR;
> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	ret = regmap_bulk_write(sec->m10bmc->regmap,
> +				M10BMC_STAGING_BASE + offset,
> +				(void *)smgr->data + offset, size / stride);

Lose trailing bytes if (size % stride)

maybe change to (size + stride - 1) / stride

> +
> +	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
> +}
> +
> +/*
> + * m10bmc_sec_poll_complete() is called after handing things off to
> + * the BMC firmware. Depending on the type of update, it could be
> + * 30+ minutes before the BMC firmware completes the update. The
> + * smgr->driver_unload check allows the driver to be unloaded,
> + * but the BMC firmware will continue the update and no further
> + * secure updates can be started for this device until the update
> + * is complete.
> + */
> +static enum fpga_sec_err m10bmc_sec_poll_complete(struct fpga_sec_mgr *smgr)
> +{
> +	struct m10bmc_sec *sec = smgr->priv;
> +	unsigned long poll_timeout;
> +	enum fpga_sec_err result;
> +	u32 doorbell;
> +	int ret;
> +
> +	result = rsu_send_data(sec);
> +	if (result != FPGA_SEC_ERR_NONE)
> +		return result;
> +
> +	ret = rsu_check_complete(sec, &doorbell);

If the first iteration will never be successful, just replace call with

ret = -EAGAIN;

Tom

> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
> +
> +	while (ret == -EAGAIN && !time_after(jiffies, poll_timeout)) {
> +		msleep(RSU_COMPLETE_INTERVAL_MS);
> +		ret = rsu_check_complete(sec, &doorbell);
> +		if (smgr->driver_unload)
> +			return FPGA_SEC_ERR_CANCELED;
> +	}
> +
> +	if (ret == -EAGAIN) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_TIMEOUT;
> +	} else if (ret == -EIO) {
> +		return FPGA_SEC_ERR_RW_ERROR;
> +	} else if (ret) {
> +		log_error_regs(sec, doorbell);
> +		return FPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return FPGA_SEC_ERR_NONE;
> +}
> +
> +static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
> +{
> +	struct m10bmc_sec *sec = smgr->priv;
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return FPGA_SEC_ERR_RW_ERROR;
> +
> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
> +		return FPGA_SEC_ERR_BUSY;
> +
> +	ret = regmap_update_bits(sec->m10bmc->regmap,
> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				 DRBL_HOST_STATUS,
> +				 FIELD_PREP(DRBL_HOST_STATUS,
> +					    HOST_STATUS_ABORT_RSU));
> +
> +	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
> +}
> +
> +static const struct fpga_sec_mgr_ops m10bmc_sops = {
> +	.prepare = m10bmc_sec_prepare,
> +	.write_blk = m10bmc_sec_write_blk,
> +	.poll_complete = m10bmc_sec_poll_complete,
> +	.cancel = m10bmc_sec_cancel,
> +};
>  
>  static int m10bmc_secure_probe(struct platform_device *pdev)
>  {

