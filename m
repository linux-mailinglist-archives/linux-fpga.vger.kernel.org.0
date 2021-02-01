Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426BB30A969
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Feb 2021 15:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhBAONz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 09:13:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231838AbhBAONy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 1 Feb 2021 09:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612188747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2E0S/Z5gWA3ccqYSTotfrJuoUUJBHoeOURjhC0S/Jk=;
        b=DL3NiD6n1LvSrDE7K4RrNO+ptqKpq3CV9VWoQDPnhJ/mAW4j4N4hPN434umJ5li8rCkSD1
        URPvuO618YDXh/6PvR9FVrhnMSEgSJqAo8koajSOB4zO5CrAvYmqHIGmgGghR6yL8OYDfN
        udj6EoTP4WayA1g/vAuEZnqWIDdwrKA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-yElgYHGQOHGP3WnedtzkmA-1; Mon, 01 Feb 2021 09:12:24 -0500
X-MC-Unique: yElgYHGQOHGP3WnedtzkmA-1
Received: by mail-qt1-f198.google.com with SMTP id r18so10683052qta.19
        for <linux-fpga@vger.kernel.org>; Mon, 01 Feb 2021 06:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N2E0S/Z5gWA3ccqYSTotfrJuoUUJBHoeOURjhC0S/Jk=;
        b=KskVFWM99iiOMKZUyrA7uJYwrVsCbpvBVFR561cCFc0hUbfhaqcqUTzBWkjCBBrD4f
         ZQGyAb7rQXaSn8UHUk7oEkaMNILCX4QSl8opRSeuTQxXdLxuh5NZbfwGBHkuEJYtr6Mm
         SkLv6CvDVcGqYpQEDOoPOFhJrjIlKpWz5yFxm8JocINMALkQGwpYZOYDYqeZUfgUkKop
         otlWd7FWK70kiBtyAxXQvEwl/pMc3SLNQ85kNqYsD5LfzPS80HvaOZF+/dy3N4tthCiK
         R3XVgRTI77Fifur+2NQcvbxrEY/ZS0pGWegINr5dta2dNhU3UhmAEOkcmmcGigEa12LG
         A4IA==
X-Gm-Message-State: AOAM531bc2eqJQxofdSufrTFeNISUfM47wOMWHASF7mjroeA9FLAAiZ5
        a+iZKhXqWGdPPJt1pXJKKwRk1NdDUjvcCgiJy7gXjQWotJcRDSkAek238bLJ5Vd7rCQz+esfK9A
        younahUfCqNjDZn0SUBklhw==
X-Received: by 2002:ad4:468c:: with SMTP id bq12mr15285036qvb.11.1612188744313;
        Mon, 01 Feb 2021 06:12:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWcu7QMcVQZmTNtkvnH7tBDsAShHJwxhwlpfixBQHLwHGuCEV7aJwrUjirGWN/Nl9k6PIwtA==
X-Received: by 2002:ad4:468c:: with SMTP id bq12mr15285009qvb.11.1612188744038;
        Mon, 01 Feb 2021 06:12:24 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b17sm484952qkh.57.2021.02.01.06.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 06:12:23 -0800 (PST)
Subject: Re: [PATCH v10 1/2] uio: uio_dfl: add userspace i/o driver for DFL
 bus
To:     Xu Yilun <yilun.xu@intel.com>, gregkh@linuxfoundation.org,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, hao.wu@intel.com
References: <1612157883-18616-1-git-send-email-yilun.xu@intel.com>
 <1612157883-18616-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d100069d-c953-209c-9e74-a336c644887b@redhat.com>
Date:   Mon, 1 Feb 2021 06:12:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612157883-18616-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/31/21 9:38 PM, Xu Yilun wrote:
> This patch supports the DFL drivers be written in userspace. This is
> realized by exposing the userspace I/O device interfaces.
>
> The driver now only binds the ether group feature, which has no irq. So
> the irq support is not implemented yet.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v9: switch to add a uio driver in drivers/uio
> v10: add the source file in MAINTAINERS
>      more descriptive Kconfig header
>      add detailed path for opae uio example
> ---
>  MAINTAINERS           |  1 +
>  drivers/uio/Kconfig   | 17 +++++++++++++
>  drivers/uio/Makefile  |  1 +
>  drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 85 insertions(+)
>  create mode 100644 drivers/uio/uio_dfl.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 147d1d9..4d01a21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6943,6 +6943,7 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-dfl*
>  F:	Documentation/fpga/dfl.rst
>  F:	drivers/fpga/dfl*
> +F:	drivers/uio/uio_dfl.c
>  F:	include/linux/dfl.h
>  F:	include/uapi/linux/fpga-dfl.h
>  
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81..5531f3a 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -165,4 +165,21 @@ config UIO_HV_GENERIC
>  	  to network and storage devices from userspace.
>  
>  	  If you compile this as a module, it will be called uio_hv_generic.
> +
> +config UIO_DFL
> +	tristate "Generic driver for DFL (Device Feature List) bus"
> +	depends on FPGA_DFL
> +	help
> +	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
> +	  It is useful to provide direct access to DFL devices from userspace.
> +	  A sample userspace application using this driver is available for
> +	  download in a git repository:
> +
> +	    git clone https://github.com/OPAE/opae-sdk.git
> +
> +	  It could be found at:
> +
> +	    opae-sdk/tools/libopaeuio/

Yes, it is there.  Thanks!

Reviewed-by: Tom Rix <trix@redhat.com>

> +
> +	  If you compile this as a module, it will be called uio_dfl.
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

