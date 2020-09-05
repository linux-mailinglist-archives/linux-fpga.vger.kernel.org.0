Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17FD25EA6E
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 22:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgIEUj6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 5 Sep 2020 16:39:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728327AbgIEUj5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 5 Sep 2020 16:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599338395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kx8HzmaZpeYZYpWwlpa7IbVO/+/3Ogwe4v1RfYOzGi8=;
        b=INjEBySK9TSpKil5sFytoBsY2jYb3sweOs8lkR3tmb8whmw4rhCUCe7I1qaNDFy/o/GAR/
        mc/6hQypLj8lX8+wbWfBtq3W3HJRDDBrXPIK46hqTQvrl51+hkhEj7GN1yGBMWpBWiKZ7s
        Wid45J4Vg5lgqO73hPkm2VdGCp+u6zk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-7iZ2tt3iOhe7G_9vNeBr0w-1; Sat, 05 Sep 2020 16:39:54 -0400
X-MC-Unique: 7iZ2tt3iOhe7G_9vNeBr0w-1
Received: by mail-qt1-f198.google.com with SMTP id o13so6563182qtl.6
        for <linux-fpga@vger.kernel.org>; Sat, 05 Sep 2020 13:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Kx8HzmaZpeYZYpWwlpa7IbVO/+/3Ogwe4v1RfYOzGi8=;
        b=YJ6H+5JOwAvwGikQxPY1xW1Pgi/EJaGwyG0RXXghgj1WX+9fueZjYrdm5wKCclhmgx
         TGGKV+KFOwV94sIXvBumYxPLaECjIOw5IN7Ugf0dYOxqqfQhWk8LTjYjXHnGWOf5Hc0A
         2fvfPwWBgYfTMf6dKm5q2ax4xmJLBmf0wVcV287VSFhiBHUuNkA8txaL/69tNp60pkVz
         BAVrQ0lYnE1hIercvIMpZICWIgQLbLFMBjWJ73TxgKRxZ0OJm5fas+rSbXoREwxBk6Ad
         6SAaviIep/5qqMPTNcCy2eN9P9SynuW+OpKchROc62fhQvC6CjPQb0x0Md3ovYPf5Dgn
         Vsig==
X-Gm-Message-State: AOAM532v5hmeOTFUu11Fh8baLeCYiE2VWXTEGbbedEpJHIf+WRGcuEek
        hChMsjpEmu58frQ+vt6lhsH6+JJEvxZk72wZtU1tYtQlSWW0u/DxLfKq/hOjnjJgeLfh7uwnQlP
        ahflJrQUqKNo8D6D1+1Mh9g==
X-Received: by 2002:ac8:411b:: with SMTP id q27mr14554200qtl.255.1599338393667;
        Sat, 05 Sep 2020 13:39:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEEppV8KOTKDOVXJjHNDLaJizH+e1HUtcIP/UpF9boOGOaBHyt97v0JQjlD2oPNxl6jMi+TQ==
X-Received: by 2002:ac8:411b:: with SMTP id q27mr14554188qtl.255.1599338393436;
        Sat, 05 Sep 2020 13:39:53 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l13sm6440861qtv.82.2020.09.05.13.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 13:39:52 -0700 (PDT)
Subject: Re: [PATCH v1 03/12] fpga: expose max10 flash update counts in sysfs
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-4-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a4ee319d-9f6f-5a27-415e-b1fabd1d5465@redhat.com>
Date:   Sat, 5 Sep 2020 13:39:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-4-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/4/20 4:52 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to provide a
> handler to expose the flash update count for the FPGA user
> image.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-secure.c | 32 +++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 1f86bfb694b4..b824790e43aa 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -10,6 +10,7 @@
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  
>  struct m10bmc_sec {
> @@ -99,7 +100,38 @@ SYSFS_GET_REH(bmc, BMC_REH_ADDR)
>  SYSFS_GET_REH(sr, SR_REH_ADDR)
>  SYSFS_GET_REH(pr, PR_REH_ADDR)
>  
> +#define FLASH_COUNT_SIZE 4096
This seems too high at most it should be 64.
> +#define USER_FLASH_COUNT 0x17ffb000
Why shouldn't this be in intel-m10-bmc.h ?
> +
> +static int get_qspi_flash_count(struct ifpga_sec_mgr *imgr)

what does 'qspi' mean ?

unless there are going to be several *flash_count's consider

removing this substring.

> +{
> +	struct m10bmc_sec *sec = imgr->priv;
> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	unsigned int cnt, num_bits = FLASH_COUNT_SIZE * 8;
> +	u8 *flash_buf;
> +	int ret;
> +
> +	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
> +	if (!flash_buf)
> +		return -ENOMEM;
> +
> +	ret = m10bmc_raw_bulk_read(sec->m10bmc, USER_FLASH_COUNT, flash_buf,
> +				   FLASH_COUNT_SIZE / stride);
> +	if (ret) {
> +		dev_err(sec->dev, "%s failed to read %d\n", __func__, ret);
> +		goto exit_free;
> +	}
> +
> +	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
Simplify ret = num_bits...
> +
> +exit_free:
> +	kfree(flash_buf);
> +
> +	return ret ? : cnt;

Then simplify

return ret;

Tom

> +}
> +
>  static const struct ifpga_sec_mgr_ops m10bmc_iops = {
> +	.user_flash_count = get_qspi_flash_count,
>  	.bmc_root_entry_hash = get_bmc_root_entry_hash,
>  	.sr_root_entry_hash = get_sr_root_entry_hash,
>  	.pr_root_entry_hash = get_pr_root_entry_hash,

