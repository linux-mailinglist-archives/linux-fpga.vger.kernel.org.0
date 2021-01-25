Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7E304AB3
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 21:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbhAZE6Q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 23:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731457AbhAYTCa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 14:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611601244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7BOC85rb73+qqwAq+IoD7Q1q2UwHBTY7mnIQQYVBAQ=;
        b=hFmksJzb86qdq/KvclKik8pLM4OC/6awReIUkXlSanCWbDpkOkHf+sH2ab6cM6tvafEuxR
        x63f/V5aXV6LQ2FxpmfQtsJb6jIDaUdmwrJx7WFkzRaVCrDUVPhNkOwsyw1ucVUwrnxlff
        mWeI637K5zKd2etSE64EWr3hbwACgsY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166--vWDk5e5PD2_tB0JjMWwrg-1; Mon, 25 Jan 2021 14:00:42 -0500
X-MC-Unique: -vWDk5e5PD2_tB0JjMWwrg-1
Received: by mail-qt1-f198.google.com with SMTP id f5so7865130qtf.15
        for <linux-fpga@vger.kernel.org>; Mon, 25 Jan 2021 11:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=O7BOC85rb73+qqwAq+IoD7Q1q2UwHBTY7mnIQQYVBAQ=;
        b=rnLj5drNIk5oHW27HJG13aAQKNfqOn6LpanRUabnrKDwrYHrW5gBBRLEVOX9CNhrQl
         0RHx2a022OoB4pK4264a+7hoE7WaqW/DXMV/p83DtcaJqWJz5eLLMgU2NNX5LJ+orAx3
         ppJiJ6YjfQh4I0zkjPNUFxMSptcCYuQXZDAq9eT5rCgOEXmLua6do0eozPTUkvjZyW9i
         HMnuO9R6QbNYzzSpdUmRTuORF+BD5X7EINMiC0o1SMqsJcxkvqsyA2TT/mqlPL0fmjxW
         ofTU41ghJ5e/A/Arljn2jm49W4+4DCWAYVRWhHUlVdVHqfSJUX6so8lvsjRk7+mKY/+j
         A4fw==
X-Gm-Message-State: AOAM533SYel7pTd135HEUn7VgAHJxiN0AtMpxuTOsXpJY8zoTEwu1TPI
        O8I0+ErcT+B6u6+6c/NUdthpAThxsztu4ohzHqkjFHG+Tl/UvYxe35uA+nM5w3iOtrCq2rHmQp3
        FOjcPYmBxHP2PL6R0k1gDvw==
X-Received: by 2002:ac8:6c50:: with SMTP id z16mr1861817qtu.112.1611601241657;
        Mon, 25 Jan 2021 11:00:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhbVQKeiAUtKD0MhTm5WBE+l6/ubWfnVsRbL+ojSRynRNTNlU4ABWKDUOQ1kvHkNVDAnFgNw==
X-Received: by 2002:ac8:6c50:: with SMTP id z16mr1861791qtu.112.1611601241353;
        Mon, 25 Jan 2021 11:00:41 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 202sm9112533qkj.92.2021.01.25.11.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:00:40 -0800 (PST)
Subject: Re: [PATCH v9 1/2] uio: uio_dfl: add userspace i/o driver for DFL bus
To:     Xu Yilun <yilun.xu@intel.com>, gregkh@linuxfoundation.org,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, hao.wu@intel.com
References: <1611564563-9665-1-git-send-email-yilun.xu@intel.com>
 <1611564563-9665-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e9bb1ff8-f630-f1a3-985c-7e51369a733f@redhat.com>
Date:   Mon, 25 Jan 2021 11:00:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611564563-9665-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/25/21 12:49 AM, Xu Yilun wrote:
> This patch supports the DFL drivers be written in userspace. This is
> realized by exposing the userspace I/O device interfaces.
>
> The driver now only binds the ether group feature, which has no irq. So
> the irq support is not implemented yet.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v9: switch to add a uio driver in drivers/uio
> ---
>  drivers/uio/Kconfig   | 13 ++++++++++
>  drivers/uio/Makefile  |  1 +
>  drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++

You should add this to the MAINTAINERS file.

>  3 files changed, 80 insertions(+)
>  create mode 100644 drivers/uio/uio_dfl.c
>
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81..44778f8 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -165,4 +165,17 @@ config UIO_HV_GENERIC
>  	  to network and storage devices from userspace.
>  
>  	  If you compile this as a module, it will be called uio_hv_generic.
> +
> +config UIO_DFL
> +	tristate "Generic driver for DFL bus"

The term 'DFL' will be unknown to folks in drivers/uio

I think it would be better if DFL was always prefixed 'FPGA DFL'

> +	depends on FPGA_DFL
> +	help
> +	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
> +	  It is useful to provide direct access to DFL devices from userspace.
> +	  A sample userspace application using this driver is available for
> +	  download in a git repository:
> +
> +	    git clone https://github.com/OPAE/opae-sdk.git
> +
> +	  If you compile this as a module, it will be called uio_dfl.

opae-sdk is pretty large and uncovered in the Documentation/fpga/dfl.rst.

Where in opae-sdk is this example ?

If you can point me at the example, I will turn it into a selftest.

Tom

>  endif
> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> index c285dd2..f2f416a1 100644
> --- a/drivers/uio/Makefile
> +++ b/drivers/uio/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
>  obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
>  obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
>  obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
> +obj-$(CONFIG_UIO_DFL)	+= uio_dfl.o
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> new file mode 100644
> index 0000000..89c0fc7
> --- /dev/null
> +++ b/drivers/uio/uio_dfl.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic DFL driver for Userspace I/O devicess
> + *
> + * Copyright (C) 2021 Intel Corporation, Inc.
> + */
> +#include <linux/dfl.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/uio_driver.h>
> +
> +#define DRIVER_NAME "uio_dfl"
> +
> +static int uio_dfl_probe(struct dfl_device *ddev)
> +{
> +	struct resource *r = &ddev->mmio_res;
> +	struct device *dev = &ddev->dev;
> +	struct uio_info *uioinfo;
> +	struct uio_mem *uiomem;
> +	int ret;
> +
> +	uioinfo = devm_kzalloc(dev, sizeof(struct uio_info), GFP_KERNEL);
> +	if (!uioinfo)
> +		return -ENOMEM;
> +
> +	uioinfo->name = DRIVER_NAME;
> +	uioinfo->version = "0";
> +
> +	uiomem = &uioinfo->mem[0];
> +	uiomem->memtype = UIO_MEM_PHYS;
> +	uiomem->addr = r->start & PAGE_MASK;
> +	uiomem->offs = r->start & ~PAGE_MASK;
> +	uiomem->size = (uiomem->offs + resource_size(r)
> +			+ PAGE_SIZE - 1) & PAGE_MASK;
> +	uiomem->name = r->name;
> +
> +	/* Irq is yet to be supported */
> +	uioinfo->irq = UIO_IRQ_NONE;
> +
> +	ret = devm_uio_register_device(dev, uioinfo);
> +	if (ret)
> +		dev_err(dev, "unable to register uio device\n");
> +
> +	return ret;
> +}
> +
> +#define FME_FEATURE_ID_ETH_GROUP	0x10
> +
> +static const struct dfl_device_id uio_dfl_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> +
> +static struct dfl_driver uio_dfl_driver = {
> +	.drv = {
> +		.name = DRIVER_NAME,
> +	},
> +	.id_table	= uio_dfl_ids,
> +	.probe		= uio_dfl_probe,
> +};
> +module_dfl_driver(uio_dfl_driver);
> +
> +MODULE_DESCRIPTION("Generic DFL driver for Userspace I/O devices");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");

