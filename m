Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DD0285216
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Oct 2020 21:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgJFTIP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 15:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbgJFTIP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Oct 2020 15:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602011292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RevYVsbERAU0vBJwORHZL9hegXbMLC0q1pXNIfp90Ns=;
        b=hSO6wKc3qVnU7iX4oJi/uIXVD/rsEvoSMqCxrXbQaLPG969VJ4qVbH1F12Z2x7DFxSbbHo
        3FOwkOpBTEqwWxlQMGvo2duTn4l5lSN1d5USm4ekD/s3qn5D9PFeeTSdlVs6uDbPWN+S4K
        Vw2i+rbfybrlWKf2QyNaoe038zycyVI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-_sCb2jW1OYynLLRRe0ISnA-1; Tue, 06 Oct 2020 15:08:11 -0400
X-MC-Unique: _sCb2jW1OYynLLRRe0ISnA-1
Received: by mail-qt1-f198.google.com with SMTP id b39so9825097qta.0
        for <linux-fpga@vger.kernel.org>; Tue, 06 Oct 2020 12:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RevYVsbERAU0vBJwORHZL9hegXbMLC0q1pXNIfp90Ns=;
        b=YhBcBp9LdUXXrsPzEZJa4hfoHZ89Q6ViJvpoVXH1Rgjjsgn4sTJ9alT+p8Vz0D34kc
         6LivuXKymM9P77wfNeZPkKhU3fANHdKjBiv5nqjLERJKeVY4Ran7XdJ5d+9rUEfg9y6i
         m6uGhbB6xr4KnrnY7+1L8r9jDIMdhtO2hr80khtRnjzJZY8hA35xWy/p8UbAapmVE+pI
         B2RwNvKoy5MR5ysbNuS2HWm8w3wHHMr/2UdRu1ou/hoJpvcz52PyPIIzdE8Crb5lJURA
         NEuvMFZVJUtBdqaoArueMcI59NtqDvLTolWAmj9o/S96SBBaJt1QraKaUPtDyloQRTVD
         SLGQ==
X-Gm-Message-State: AOAM5323A0aYUSzeQRT98pHtGbjmahpBUO3hOAZprn5N8y2u6ivyBGaA
        6fkOlM6huwntufXAuJDmyw9PEhhPXVNTaDWXGqXg83TcPoVd6UoNio1cCQZh/yLUyNXtV56Jkdh
        QKl2Dl8lFwyf2/hLyOdztzg==
X-Received: by 2002:a05:620a:2442:: with SMTP id h2mr6811435qkn.225.1602011290864;
        Tue, 06 Oct 2020 12:08:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3EXG9AL1E7NTtxZSNiYwJC1toVePHswZ6gscnLSztSyHisnn8/2AW9eOfS/qvuV9atstzmA==
X-Received: by 2002:a05:620a:2442:: with SMTP id h2mr6811400qkn.225.1602011290488;
        Tue, 06 Oct 2020 12:08:10 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s123sm3178196qkd.128.2020.10.06.12.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 12:08:09 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] fpga: m10bmc-sec: add max10 secure update
 functions
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-6-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <aca99ba5-ed85-b563-02c8-c4b21a9978fb@redhat.com>
Date:   Tue, 6 Oct 2020 12:08:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201003012412.16831-6-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/2/20 6:24 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to include
> the functions that enable secure updates of BMC images,
> FPGA images, etc.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
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
>  drivers/fpga/intel-m10-bmc-secure.c | 298 ++++++++++++++++++++++++++++
>  1 file changed, 298 insertions(+)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 5bb45499b332..a9617c5b3845 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -201,6 +201,300 @@ static int m10bmc_pr_canceled_csks(struct ifpga_sec_mgr *imgr,
>  			      csk_map, nbits);
>  }
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
> +static enum ifpga_sec_err rsu_update_init(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell, status;
> +	int ret;
> +
> +	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL,
> +				     DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
> +				     DRBL_RSU_REQUEST |
> +				     FIELD_PREP(DRBL_HOST_STATUS,
> +						HOST_STATUS_IDLE));
> +	if (ret)
> +		return IFPGA_SEC_ERR_RW_ERROR;
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
> +		return IFPGA_SEC_ERR_TIMEOUT;
> +	} else if (ret) {
> +		return IFPGA_SEC_ERR_RW_ERROR;
> +	}
> +
> +	status = rsu_stat(doorbell);
> +	if (status == RSU_STAT_WEAROUT) {
> +		dev_warn(sec->dev, "Excessive flash update count detected\n");

Device is permanently failing, dev_err or higher is more appropriate than dev_warn.

warn once to limit noisy logs.

> +		return IFPGA_SEC_ERR_WEAROUT;
> +	} else if (status == RSU_STAT_ERASE_FAIL) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_HW_ERROR;
> +	}
> +
> +	return IFPGA_SEC_ERR_NONE;
> +}
> +
> +static enum ifpga_sec_err (struct m10bmc_sec *sec)
> +{
> +	unsigned long poll_timeout;
> +	u32 doorbell, progress;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return IFPGA_SEC_ERR_RW_ERROR;
> +
> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
> +		msleep(RSU_PREP_INTERVAL_MS);
> +		if (time_after(jiffies, poll_timeout))
> +			break;
> +
> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +		if (ret)
> +			return IFPGA_SEC_ERR_RW_ERROR;
> +	}
> +
> +	progress = rsu_prog(doorbell);
> +	if (progress == RSU_PROG_PREPARE) {
> +		log_error_regs(sec, doorbell);
> +		return IFPGA_SEC_ERR_TIMEOUT;
> +	} else if (progress != RSU_PROG_READY) {
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
> +	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL,
> +				     DRBL_HOST_STATUS,
> +				     FIELD_PREP(DRBL_HOST_STATUS,
> +						HOST_STATUS_WRITE_DONE));
> +	if (ret)
> +		return IFPGA_SEC_ERR_RW_ERROR;
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

This and similar below..

switch can be converted to

if (!rsu_stat(doorbell) & (RSU_STAT_NORMAL | ... ))

  fail

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
> +
> +	ret = rsu_check_idle(sec);
> +	if (ret)

This needs to change, generally, to

if (ret != IFPGA_SEC_ERR_NONE)

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
> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	u32 doorbell;
> +	int ret;
> +
size check here.
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);

Wondering about the use of m10bmc_sys_read generally.

If secure writing depends on new mmio region why not use the raw_read ?

wondering if mixing old door bell regs with new sec regs would even work.

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
> +/*
> + * m10bmc_sec_poll_complete() is called after handing things off to
> + * the BMC firmware. Depending on the type of update, it could be
> + * 30+ minutes before the BMC firmware completes the update. The
> + * imgr->driver_unload check allows the driver to be unloaded,
> + * but the BMC firmware will continue the update and no further
> + * secure updates can be started for this device until the update
> + * is complete.
> + */
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
> +
> +	while (ret == -EAGAIN && !time_after(jiffies, poll_timeout)) {
> +		msleep(RSU_COMPLETE_INTERVAL_MS);
> +		ret = rsu_check_complete(sec, &doorbell);
> +		if (imgr->driver_unload)
> +			return IFPGA_SEC_ERR_CANCELED;

Instead of checking for complete could you check the progress ?

hate for it to fail with 90% done.

Tom

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
> +	ret = m10bmc_sys_update_bits(sec->m10bmc, M10BMC_DOORBELL,
> +				     DRBL_HOST_STATUS,
> +				     FIELD_PREP(DRBL_HOST_STATUS,
> +						HOST_STATUS_ABORT_RSU));
> +
> +	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
> +}
> +
>  static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>  	.user_flash_count = m10bmc_user_flash_count,
>  	.bmc_root_entry_hash = m10bmc_bmc_root_entry_hash,
> @@ -215,6 +509,10 @@ static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>  	.bmc_canceled_csk_nbits = m10bmc_csk_cancel_nbits,
>  	.sr_canceled_csk_nbits = m10bmc_csk_cancel_nbits,
>  	.pr_canceled_csk_nbits = m10bmc_csk_cancel_nbits,
> +	.prepare = m10bmc_sec_prepare,
> +	.write_blk = m10bmc_sec_write_blk,
> +	.poll_complete = m10bmc_sec_poll_complete,
> +	.cancel = m10bmc_sec_cancel,
>  };
>  
>  static int m10bmc_secure_probe(struct platform_device *pdev)

