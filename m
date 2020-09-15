Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC3226B2F1
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Sep 2020 00:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbgIOWzq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Sep 2020 18:55:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37865 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgIOWzj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Sep 2020 18:55:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id u9so2114953plk.4;
        Tue, 15 Sep 2020 15:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W5ADVjm0/LbQf/Qyt+jAu/gmqtvdrPkWWhiITEEiY+8=;
        b=Xm5bG0Uyok9PjUTDpCKWxgMRPO57GlCx0tQMNWSI67JttnitE05NukeaKpeEOwY/2v
         /wzxPTs1AvOlB8QC2xhY/DKZU7XwGE6bCUdX35oRcAQWScXnPG+NfsThHDwcuCkd6CPv
         d+rZgiBx1ozymg61en1+GUNRl6xmvOF21HrOticmYHgOMTDykAM0rve9573HeGdTsCKB
         KIOvBQzQJXQUWgQvaBdnGqVLalo7FCL52dhf8nrEMwLW8rtFt6QGiHRa9+VMHw2pzEGA
         NzLUh6wLGQMwZJvWnS2BXFcfqVCXxRrglNoZfISqv1vYHOKfCH4pxH3f1C/WrM49muAB
         wDfw==
X-Gm-Message-State: AOAM533uivsDGj1p9iw4QCTsITCxQW3x34BqfqDWK+T6QRI6x2FsFkUj
        TMiXh+mt2xkPCWbkfuGno6k=
X-Google-Smtp-Source: ABdhPJyeYdGSLu16I8yaSf0NUdOhpgnKHLb1/pNIEmH5W2DDXYRLptzINMnjh8+YASwCSdNIIJj6Fw==
X-Received: by 2002:a17:902:aa4b:b029:d0:cbe1:e739 with SMTP id c11-20020a170902aa4bb02900d0cbe1e739mr22099198plr.20.1600210537851;
        Tue, 15 Sep 2020 15:55:37 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id j19sm15274973pfe.108.2020.09.15.15.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 15:55:37 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:55:36 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        trix@redhat.com, lgoncalv@redhat.com
Subject: Re: [PATCH v2 4/4] fpga: dfl: move dfl bus related APIs to
 include/linux/fpga/dfl.h
Message-ID: <20200915225536.GA1049672@epycbox.lan>
References: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
 <1600140473-12351-5-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600140473-12351-5-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 15, 2020 at 11:27:53AM +0800, Xu Yilun wrote:
> The patch moves dfl-bus related APIs to include/linux/fpga/dfl.h
> 
> Now the DFL device drivers could be made as independent modules and put
> in different folders according to their functionality. In order for
> scattered DFL device drivers to include dfl bus APIs, move the dfl bus
> APIs to a new header file in the public folder.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: updated the MAINTAINERS under FPGA DFL DRIVERS
>     improve the comments
>     rename the dfl-bus.h to dfl.h
> ---
>  MAINTAINERS                   |  1 +
>  drivers/fpga/dfl-n3000-nios.c |  3 +-
>  drivers/fpga/dfl.c            |  1 +
>  drivers/fpga/dfl.h            | 72 ------------------------------------
>  include/linux/fpga/dfl.h      | 86 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 89 insertions(+), 74 deletions(-)
>  create mode 100644 include/linux/fpga/dfl.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 31c5165..fa46592 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6883,6 +6883,7 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-dfl
>  F:	Documentation/fpga/dfl.rst
>  F:	drivers/fpga/dfl*
> +F:	include/linux/fpga/dfl.h
>  F:	include/uapi/linux/fpga-dfl.h
>  
>  FPGA MANAGER FRAMEWORK
> diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
> index 70b44c3..5088f8f 100644
> --- a/drivers/fpga/dfl-n3000-nios.c
> +++ b/drivers/fpga/dfl-n3000-nios.c
> @@ -11,6 +11,7 @@
>   */
>  #include <linux/bitfield.h>
>  #include <linux/errno.h>
> +#include <linux/fpga/dfl.h>
>  #include <linux/io.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/kernel.h>
> @@ -22,8 +23,6 @@
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
>  
> -#include "dfl.h"
> -
>  static char *fec_mode = "rs";
>  module_param(fec_mode, charp, 0444);
>  MODULE_PARM_DESC(fec_mode, "FEC mode of the ethernet retimer on Intel PAC N3000");
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b450870..8bf6e99 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -11,6 +11,7 @@
>   *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
>   */
>  #include <linux/fpga-dfl.h>
> +#include <linux/fpga/dfl.h>
>  #include <linux/module.h>
>  #include <linux/uaccess.h>
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index d5e050a..2b82c96 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -517,76 +517,4 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>  			       struct dfl_feature *feature,
>  			       unsigned long arg);
>  
> -/**
> - * enum dfl_id_type - define the DFL FIU types
> - */
> -enum dfl_id_type {
> -	FME_ID,
> -	PORT_ID,
> -	DFL_ID_MAX,
> -};
> -
> -/**
> - * struct dfl_device - represent an dfl device on dfl bus
> - *
> - * @dev: generic device interface.
> - * @id: id of the dfl device.
> - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> - * @mmio_res: mmio resource of this dfl device.
> - * @irqs: list of Linux IRQ numbers of this dfl device.
> - * @num_irqs: number of IRQs supported by this dfl device.
> - * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> - * @id_entry: matched id entry in dfl driver's id table.
> - */
> -struct dfl_device {
> -	struct device dev;
> -	int id;
> -	u8 type;
> -	u16 feature_id;
> -	struct resource mmio_res;
> -	int *irqs;
> -	unsigned int num_irqs;
> -	struct dfl_fpga_cdev *cdev;
> -	const struct dfl_device_id *id_entry;
> -};
> -
> -/**
> - * struct dfl_driver - represent an dfl device driver
> - *
> - * @drv: driver model structure.
> - * @id_table: pointer to table of device IDs the driver is interested in.
> - *	      { } member terminated.
> - * @probe: mandatory callback for device binding.
> - * @remove: callback for device unbinding.
> - */
> -struct dfl_driver {
> -	struct device_driver drv;
> -	const struct dfl_device_id *id_table;
> -
> -	int (*probe)(struct dfl_device *dfl_dev);
> -	void (*remove)(struct dfl_device *dfl_dev);
> -};
> -
> -#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> -#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> -
> -/*
> - * use a macro to avoid include chaining to get THIS_MODULE.
> - */
> -#define dfl_driver_register(drv) \
> -	__dfl_driver_register(drv, THIS_MODULE)
> -int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner);
> -void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> -
> -/*
> - * module_dfl_driver() - Helper macro for drivers that don't do
> - * anything special in module init/exit.  This eliminates a lot of
> - * boilerplate.  Each module may only use this macro once, and
> - * calling it replaces module_init() and module_exit().
> - */
> -#define module_dfl_driver(__dfl_driver) \
> -	module_driver(__dfl_driver, dfl_driver_register, \
> -		      dfl_driver_unregister)
> -
>  #endif /* __FPGA_DFL_H */
> diff --git a/include/linux/fpga/dfl.h b/include/linux/fpga/dfl.h
> new file mode 100644
> index 0000000..0d7806f
> --- /dev/null
> +++ b/include/linux/fpga/dfl.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for DFL driver and device API
> + *
> + * Copyright (C) 2020 Intel Corporation, Inc.
> + */
> +
> +#ifndef __LINUX_FPGA_DFL_H
> +#define __LINUX_FPGA_DFL_H
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +
> +/**
> + * enum dfl_id_type - define the DFL FIU types
> + */
> +enum dfl_id_type {
> +	FME_ID,
> +	PORT_ID,
> +	DFL_ID_MAX,
> +};
> +
> +/**
> + * struct dfl_device - represent an dfl device on dfl bus
> + *
> + * @dev: generic device interface.
> + * @id: id of the dfl device.
> + * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> + * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> + * @mmio_res: mmio resource of this dfl device.
> + * @irqs: list of Linux IRQ numbers of this dfl device.
> + * @num_irqs: number of IRQs supported by this dfl device.
> + * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> + * @id_entry: matched id entry in dfl driver's id table.
> + */
> +struct dfl_device {
> +	struct device dev;
> +	int id;
> +	u8 type;
> +	u16 feature_id;
> +	struct resource mmio_res;
> +	int *irqs;
> +	unsigned int num_irqs;
> +	struct dfl_fpga_cdev *cdev;
> +	const struct dfl_device_id *id_entry;
> +};
> +
> +/**
> + * struct dfl_driver - represent an dfl device driver
> + *
> + * @drv: driver model structure.
> + * @id_table: pointer to table of device IDs the driver is interested in.
> + *	      { } member terminated.
> + * @probe: mandatory callback for device binding.
> + * @remove: callback for device unbinding.
> + */
> +struct dfl_driver {
> +	struct device_driver drv;
> +	const struct dfl_device_id *id_table;
> +
> +	int (*probe)(struct dfl_device *dfl_dev);
> +	void (*remove)(struct dfl_device *dfl_dev);
> +};
> +
> +#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> +#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> +
> +/*
> + * use a macro to avoid include chaining to get THIS_MODULE.
> + */
> +#define dfl_driver_register(drv) \
> +	__dfl_driver_register(drv, THIS_MODULE)
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner);
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> +
> +/*
> + * module_dfl_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit().
> + */
> +#define module_dfl_driver(__dfl_driver) \
> +	module_driver(__dfl_driver, dfl_driver_register, \
> +		      dfl_driver_unregister)
> +
> +#endif /* __LINUX_FPGA_DFL_H */
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks
