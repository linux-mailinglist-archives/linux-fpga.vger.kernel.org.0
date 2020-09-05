Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B599B25EADE
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 22:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgIEUw1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 5 Sep 2020 16:52:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44227 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728505AbgIEUwZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 5 Sep 2020 16:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599339143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IX2JXUthZOK9ILrI2szDCLF/ohGIvOY3CoU57DOlSKU=;
        b=ZUmANEce24WhyKuhc74Wy/eNnBMp33mgq7+xZeOgEx4t+VL+ILOAkW6aDeRT+bAl8cBnCy
        fRSVsMdxjHPa+GAmNolxNOQm2ytBxCQEkaIEp4T9P7+uNmk2yrwkoGXt9uIEiTX4i6fAs1
        oTeNombyGzvpUB8jjJZgOdrDq1sz3uc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-JCRjkpoXMKyO4UQ9sa1e6w-1; Sat, 05 Sep 2020 16:52:21 -0400
X-MC-Unique: JCRjkpoXMKyO4UQ9sa1e6w-1
Received: by mail-qv1-f71.google.com with SMTP id y30so5678910qvy.9
        for <linux-fpga@vger.kernel.org>; Sat, 05 Sep 2020 13:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IX2JXUthZOK9ILrI2szDCLF/ohGIvOY3CoU57DOlSKU=;
        b=PCJkFEfv4mIhTS+/JR0m47HAZYjmlj2/UFEMvq2Abcdi+QRzZ4DT23YBs4cHQ+2tQx
         LVlOMv4Omsf7dVbA3MauZgOpZnpxptASOgH4H81iLm1kbeqSuovYQKy9Zl3ifCk4KC1N
         wMZpW/EvZlq1Rbbr0X/qm6/vYlMlN/xovDAxUT7IhDG8ax7SWhg86iCOsnHGShgGZARb
         imWWJ1GeBdDFJTYGQh7+pweeYXxTsNlJPk+vs2+CHpIsyF1qFWU5NbpkE0n1P76Un8Da
         XLjm7Ewwj3YT2F8QE/ldHjJzJuWy3RYWvOjCXxYrUqxACL7zRkJtuQkl99sjifFhcBnl
         sVog==
X-Gm-Message-State: AOAM532T+N/D8IUggWnPz6unVn0K72RQ+alj1pP+L+yw4KYR+Vbd61Qh
        jzciahD/Yec9qUTrxEgN+rUlsKE+7zZfDPF+pHJ5RYpo7pDb1dQkYC062LDQvbIiul9jbWgVvNS
        JZXUWigGbeL0bdGxOJjumPA==
X-Received: by 2002:ac8:3704:: with SMTP id o4mr13711172qtb.330.1599339141119;
        Sat, 05 Sep 2020 13:52:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWt119r+a6h7uN/jiDybLwTav09PL0IKvI9o5/1oI8clZdP8FCB3iD99SalNouXUitfbQh/Q==
X-Received: by 2002:ac8:3704:: with SMTP id o4mr13711156qtb.330.1599339140863;
        Sat, 05 Sep 2020 13:52:20 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j11sm1552337qko.111.2020.09.05.13.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 13:52:20 -0700 (PDT)
Subject: Re: [PATCH v1 04/12] fpga: expose max10 canceled keys in sysfs
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-5-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ea0be0fb-210e-823d-fad0-15e7ff5c41eb@redhat.com>
Date:   Sat, 5 Sep 2020 13:52:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-5-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 4:52 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to provide a
> handler to expose the canceled code signing key (CSK) bit
> vectors. These use the standard bitmap list format
> (e.g. 1,2-6,9).
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-secure.c | 60 +++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index b824790e43aa..46cd49a08be0 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -130,14 +130,74 @@ static int get_qspi_flash_count(struct ifpga_sec_mgr *imgr)
>  	return ret ? : cnt;
>  }
>  
> +#define CSK_BIT_LEN			128U
> +#define CSK_32ARRAY_SIZE(_nbits)	DIV_ROUND_UP(_nbits, 32)
> +
> +#define SYSFS_GET_CSK_CANCEL_NBITS(_name) \
> +static int get_##_name##_csk_cancel_nbits(struct ifpga_sec_mgr *imgr) \
> +{ \
> +	return (int)CSK_BIT_LEN; \
> +}
> +
> +SYSFS_GET_CSK_CANCEL_NBITS(bmc)
> +SYSFS_GET_CSK_CANCEL_NBITS(sr)
> +SYSFS_GET_CSK_CANCEL_NBITS(pr)

> +
> +static int get_csk_vector(struct ifpga_sec_mgr *imgr, u32 addr,
> +			  unsigned long *csk_map, unsigned int nbits)
> +{
> +	unsigned int i, arr_size = CSK_32ARRAY_SIZE(nbits);

> +	struct m10bmc_sec *sec = imgr->priv;
> +	u32 *csk32;
> +	int ret;
> +
> +	csk32 = vmalloc(arr_size);
> +	if (!csk32)
> +		return -ENOMEM;
> +
> +	ret = m10bmc_raw_bulk_read(sec->m10bmc, addr, csk32, arr_size);

Is this correct ? other similar bulk read used the

regmap stride.

> +	if (ret) {
> +		dev_err(sec->dev, "%s failed to read %d\n", __func__, ret);
> +		goto vfree_exit;
> +	}
> +
> +	for (i = 0; i < arr_size; i++)
> +		csk32[i] = le32_to_cpu(csk32[i]);
> +
> +	bitmap_from_arr32(csk_map, csk32, nbits);
> +	bitmap_complement(csk_map, csk_map, nbits);
> +
> +vfree_exit:
> +	vfree(csk32);
> +	return ret;
> +}
> +
> +#define SYSFS_GET_CSK_VEC(_name, _addr) \
> +static int get_##_name##_canceled_csks(struct ifpga_sec_mgr *imgr, \
> +				       unsigned long *csk_map, \
> +				       unsigned int nbits) \
> +{ return get_csk_vector(imgr, _addr, csk_map, nbits); }
> +
> +#define CSK_VEC_OFFSET 0x34
> +
> +SYSFS_GET_CSK_VEC(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET)
> +SYSFS_GET_CSK_VEC(sr, SR_PROG_ADDR + CSK_VEC_OFFSET)
> +SYSFS_GET_CSK_VEC(pr, PR_PROG_ADDR + CSK_VEC_OFFSET)
Issues similar with earlier patches.
> +
>  static const struct ifpga_sec_mgr_ops m10bmc_iops = {
>  	.user_flash_count = get_qspi_flash_count,
>  	.bmc_root_entry_hash = get_bmc_root_entry_hash,
>  	.sr_root_entry_hash = get_sr_root_entry_hash,
>  	.pr_root_entry_hash = get_pr_root_entry_hash,
> +	.bmc_canceled_csks = get_bmc_canceled_csks,
> +	.sr_canceled_csks = get_sr_canceled_csks,
> +	.pr_canceled_csks = get_pr_canceled_csks,
>  	.bmc_reh_size = get_bmc_reh_size,
>  	.sr_reh_size = get_sr_reh_size,
>  	.pr_reh_size = get_pr_reh_size,
> +	.bmc_canceled_csk_nbits = get_bmc_csk_cancel_nbits,
> +	.sr_canceled_csk_nbits = get_sr_csk_cancel_nbits,
> +	.pr_canceled_csk_nbits = get_pr_csk_cancel_nbits

These are copies the same function, replace with a

common function.

Tom

>  };
>  
>  static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)

