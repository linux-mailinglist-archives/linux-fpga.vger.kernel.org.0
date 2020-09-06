Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2026E25EF46
	for <lists+linux-fpga@lfdr.de>; Sun,  6 Sep 2020 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgIFROX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 6 Sep 2020 13:14:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24937 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725816AbgIFROW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 6 Sep 2020 13:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599412461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sL8tCYNOkqyUsw7ohcLXGgEzt8FWnS+srIzCd4NHd2U=;
        b=Zxy75Sue1FMCGGEuT2iwLWGVIACQeb3TiqA8k6WtsO0Mf4J+mzxKdEtthLY3eTW48wfd0Q
        4nZuMn+pjYOWYzC5s5pY3g/S59EIEhDM8PVhFMi4X3UgDhn39h5i3QLrZ0SUaL2s2ElG0l
        dMDuH62jauhiRRH2/ZF/+xSgq/rrthQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-BjAzriIlP-qyZ9QBcU2ebQ-1; Sun, 06 Sep 2020 13:14:19 -0400
X-MC-Unique: BjAzriIlP-qyZ9QBcU2ebQ-1
Received: by mail-qt1-f200.google.com with SMTP id g1so7654201qtc.22
        for <linux-fpga@vger.kernel.org>; Sun, 06 Sep 2020 10:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sL8tCYNOkqyUsw7ohcLXGgEzt8FWnS+srIzCd4NHd2U=;
        b=lLmIjmBHjReAg5Vi1IF7aELnN0S5AsCwJ+T61kLbfKhT9avyatBxeNTcAWGmHHf5Fv
         uRqMXweG608lP3pSaSaCE20xiIf65quKLsn86k7SksEXG4V5opksmOBNbJ5uNpvfjCTz
         YVMSXyNGuxVSDjQWem4Cbm7yfMvU92O2xaaQ79onKky+jLOiHwm+H5F8NZk9cNetpGnD
         pdYoD032yPAJmfnNIQMCu5nYMVlUsq9/z4aL9ITYTRpaedT0MPfgBP8fNyJccsZRSZSd
         ouRHwSmFg0pMDAVIgjZdWowoX1tUof9ctFk0uAtA4MwTxfNfYHhAnOQ6bfWwN2RuAnxB
         kFaw==
X-Gm-Message-State: AOAM532f1xQ5pbv0Mw9K7hhYAMGx76rx6LtCR7qZSbjaKohqo7xn+bHc
        RmBLxa+0OdNB4q+FjjlTiswhDGGGQmNNUNC/ue5x7FkliN0WbexugqQkIAT9CBn6zaLK+I2+5Np
        WqokT2oiFZquBGLAUJCJ6hg==
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr2400993qvi.141.1599412459210;
        Sun, 06 Sep 2020 10:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynPAtXpX1bkHIofdlix+rXLhWcID8OBtEtKgGVuZAfNeH6eIAxrhUsJYQvdJUQt5Mc/iKtSg==
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr2400978qvi.141.1599412458992;
        Sun, 06 Sep 2020 10:14:18 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k22sm6589106qkk.13.2020.09.06.10.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 10:14:18 -0700 (PDT)
Subject: Re: [PATCH v1 12/12] fpga: add max10 get_hw_errinfo callback func
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-13-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b90e8435-651c-e901-8be3-b0dac6eaac22@redhat.com>
Date:   Sun, 6 Sep 2020 10:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-13-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 4:53 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to include
> a function that returns 64 bits of additional HW specific
> data for errors that require additional information.
> This callback function enables the hw_errinfo sysfs
> node in the Intel Security Manager class driver.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-secure.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 4a66c2d448eb..7fb1c805f654 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -450,6 +450,30 @@ static enum ifpga_sec_err m10bmc_sec_cancel(struct ifpga_sec_mgr *imgr)
>  	return ret ? IFPGA_SEC_ERR_RW_ERROR : IFPGA_SEC_ERR_NONE;
>  }
>  
> +static u64 m10bmc_sec_hw_errinfo(struct ifpga_sec_mgr *imgr)
> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	u32 doorbell = 0, auth_result = 0;
> +	u64 hw_errinfo = 0;

hw_errinfo should be initialized to some poison value like -1

to cover the case if either of sys_read's fail.

Tom

> +
> +	switch (imgr->err_code) {
> +	case IFPGA_SEC_ERR_HW_ERROR:
> +	case IFPGA_SEC_ERR_TIMEOUT:
> +	case IFPGA_SEC_ERR_BUSY:
> +	case IFPGA_SEC_ERR_WEAROUT:
> +		if (!m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell))
> +			hw_errinfo = (u64)doorbell << 32;
> +
> +		if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT,
> +				     &auth_result))
> +			hw_errinfo |= (u64)auth_result;
> +
> +		return hw_errinfo;
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>  	.user_flash_count = get_qspi_flash_count,
>  	.bmc_root_entry_hash = get_bmc_root_entry_hash,
> @@ -467,7 +491,8 @@ static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>  	.prepare = m10bmc_sec_prepare,
>  	.write_blk = m10bmc_sec_write_blk,
>  	.poll_complete = m10bmc_sec_poll_complete,
> -	.cancel = m10bmc_sec_cancel
> +	.cancel = m10bmc_sec_cancel,
> +	.get_hw_errinfo = m10bmc_sec_hw_errinfo
>  };
>  
>  static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)

