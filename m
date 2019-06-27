Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C1587B5
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Jun 2019 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfF0Qxi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Jun 2019 12:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfF0Qxh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 Jun 2019 12:53:37 -0400
Received: from localhost (unknown [89.205.136.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D23B420659;
        Thu, 27 Jun 2019 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561654416;
        bh=JwpZKNWregQZMeBHPkYLd36fPC6RjjJw/+IcbwZUx+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZ9ylPiRefjXq3fppyo4skAgXAW/Icr+idnmjJt1dazQndlq8uDPV0w1ittcogANv
         YYGtSFIIZsrqwCcKxDctYO1P/Q2tcG2fYoS+VK6FAFD6I45iiXWo0QgbsGnX43urjt
         IALPyHhbcDjbEbTbQEo6fdNkpAJJJvz7QlQG1N10=
Date:   Fri, 28 Jun 2019 00:53:29 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v4 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20190627165329.GB9855@kroah.com>
References: <1561612195-6081-1-git-send-email-hao.wu@intel.com>
 <1561612195-6081-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561612195-6081-3-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 27, 2019 at 01:09:55PM +0800, Wu Hao wrote:
> This patch adds support for performance reporting private feature
> for FPGA Management Engine (FME). Now it supports several different
> performance counters, including 'basic', 'cache', 'fabric', 'vtd'
> and 'vtd_sip'. It allows user to use standard linux tools to access
> these performance counters.
> 
> e.g. List all events by "perf list"
> 
>   perf list | grep fme
> 
>   fme0/cache_read_hit/                         [Kernel PMU event]
>   fme0/cache_read_miss/                        [Kernel PMU event]
>   ...
> 
>   fme0/fab_mmio_read/                          [Kernel PMU event]
>   fme0/fab_mmio_write/                         [Kernel PMU event]
>   ...
> 
>   fme0/fab_port_mmio_read,portid=?/            [Kernel PMU event]
>   fme0/fab_port_mmio_write,portid=?/           [Kernel PMU event]
>   ...
> 
>   fme0/vtd_port_devtlb_1g_fill,portid=?/       [Kernel PMU event]
>   fme0/vtd_port_devtlb_2m_fill,portid=?/       [Kernel PMU event]
>   ...
> 
>   fme0/vtd_sip_iotlb_1g_hit/                   [Kernel PMU event]
>   fme0/vtd_sip_iotlb_1g_miss/                  [Kernel PMU event]
>   ...
> 
>   fme0/clock                                   [Kernel PMU event]
>   ...
> 
> e.g. check increased counter value after run one application using
> "perf stat" command.
> 
>  perf stat -e fme0/fab_mmio_read/,fme0/fab_mmio_write/, ./test
> 
>  Performance counter stats for './test':
> 
>                  1      fme0/fab_mmio_read/
>                  2      fme0/fab_mmio_write/
> 
>        1.009496520 seconds time elapsed
> 
> Please note that fabric counters support both fab_* and fab_port_*, but
> actually they are sharing one set of performance counters in hardware.
> If user wants to monitor overall data events on fab_* then fab_port_*
> can't be supported at the same time, see example below:
> 
> perf stat -e fme0/fab_mmio_read/,fme0/fab_port_mmio_write,portid=0/
> 
>  Performance counter stats for 'system wide':
> 
>                  0      fme0/fab_mmio_read/
>    <not supported>      fme0/fab_port_mmio_write,portid=0/
> 
>        2.141064085 seconds time elapsed
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
> v3: replace scnprintf with sprintf in sysfs interfaces.
>     update sysfs doc kernel version and date.
>     fix sysfs doc issue for fabric counter.
>     refine PERF_OBJ_ATTR_* macro, doesn't count on __ATTR anymore.
>     introduce PERF_OBJ_ATTR_F_* macro, as it needs to use different
>     filenames for some of the sysfs attributes.
>     remove kobject_del when destroy kobject, kobject_put is enough.
>     do sysfs_remove_groups first when destroying perf_obj.
>     WARN_ON_ONCE in case internal parms are wrong in read_*_count().
> v4: rework this patch to use standard perf API as user interfaces.
> ---
>  drivers/fpga/Makefile       |   1 +
>  drivers/fpga/dfl-fme-main.c |   4 +
>  drivers/fpga/dfl-fme-perf.c | 871 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl-fme.h      |   2 +
>  4 files changed, 878 insertions(+)
>  create mode 100644 drivers/fpga/dfl-fme-perf.c
> 
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 4865b74..d8e21df 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_FPGA_DFL_FME_REGION)	+= dfl-fme-region.o
>  obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
>  
>  dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o dfl-fme-error.o
> +dfl-fme-objs += dfl-fme-perf.o
>  dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
>  dfl-afu-objs += dfl-afu-error.o
>  
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 9225b68..a11c112 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -639,6 +639,10 @@ static void fme_power_mgmt_uinit(struct platform_device *pdev,
>  		.ops = &fme_power_mgmt_ops,
>  	},
>  	{
> +		.id_table = fme_perf_id_table,
> +		.ops = &fme_perf_ops,
> +	},
> +	{
>  		.ops = NULL,
>  	},
>  };
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> new file mode 100644
> index 0000000..0d7768a
> --- /dev/null
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -0,0 +1,871 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA Management Engine (FME) Global Performance Reporting
> + *
> + * Copyright 2019 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Kang Luwei <luwei.kang@intel.com>
> + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *   Wu Hao <hao.wu@intel.com>
> + *   Xu Yilun <yilun.xu@intel.com>
> + *   Joseph Grecco <joe.grecco@intel.com>
> + *   Enno Luebbers <enno.luebbers@intel.com>
> + *   Tim Whisonant <tim.whisonant@intel.com>
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Mitchel, Henry <henry.mitchel@intel.com>
> + */
> +
> +#include <linux/perf_event.h>
> +#include "dfl.h"
> +#include "dfl-fme.h"
> +
> +/*
> + * Performance Counter Registers for Cache.
> + *
> + * Cache Events are listed below as CACHE_EVNT_*.
> + */
> +#define CACHE_CTRL			0x8
> +#define CACHE_RESET_CNTR		BIT_ULL(0)
> +#define CACHE_FREEZE_CNTR		BIT_ULL(8)
> +#define CACHE_CTRL_EVNT			GENMASK_ULL(19, 16)
> +#define CACHE_EVNT_RD_HIT		0x0
> +#define CACHE_EVNT_WR_HIT		0x1
> +#define CACHE_EVNT_RD_MISS		0x2
> +#define CACHE_EVNT_WR_MISS		0x3
> +#define CACHE_EVNT_RSVD			0x4
> +#define CACHE_EVNT_HOLD_REQ		0x5
> +#define CACHE_EVNT_DATA_WR_PORT_CONTEN	0x6
> +#define CACHE_EVNT_TAG_WR_PORT_CONTEN	0x7
> +#define CACHE_EVNT_TX_REQ_STALL		0x8
> +#define CACHE_EVNT_RX_REQ_STALL		0x9
> +#define CACHE_EVNT_EVICTIONS		0xa
> +#define CACHE_CHANNEL_SEL		BIT_ULL(20)
> +#define CACHE_CHANNEL_RD		0
> +#define CACHE_CHANNEL_WR		1
> +#define CACHE_CNTR0			0x10
> +#define CACHE_CNTR1			0x18
> +#define CACHE_CNTR_EVNT_CNTR		GENMASK_ULL(47, 0)
> +#define CACHE_CNTR_EVNT			GENMASK_ULL(63, 60)
> +
> +/*
> + * Performance Counter Registers for Fabric.
> + *
> + * Fabric Events are listed below as FAB_EVNT_*
> + */
> +#define FAB_CTRL			0x20
> +#define FAB_RESET_CNTR			BIT_ULL(0)
> +#define FAB_FREEZE_CNTR			BIT_ULL(8)
> +#define FAB_CTRL_EVNT			GENMASK_ULL(19, 16)
> +#define FAB_EVNT_PCIE0_RD		0x0
> +#define FAB_EVNT_PCIE0_WR		0x1
> +#define FAB_EVNT_PCIE1_RD		0x2
> +#define FAB_EVNT_PCIE1_WR		0x3
> +#define FAB_EVNT_UPI_RD			0x4
> +#define FAB_EVNT_UPI_WR			0x5
> +#define FAB_EVNT_MMIO_RD		0x6
> +#define FAB_EVNT_MMIO_WR		0x7
> +#define FAB_PORT_ID			GENMASK_ULL(21, 20)
> +#define FAB_PORT_FILTER			BIT_ULL(23)
> +#define FAB_PORT_FILTER_DISABLE		0
> +#define FAB_PORT_FILTER_ENABLE		1
> +#define FAB_CNTR			0x28
> +#define FAB_CNTR_EVNT_CNTR		GENMASK_ULL(59, 0)
> +#define FAB_CNTR_EVNT			GENMASK_ULL(63, 60)
> +
> +/*
> + * Performance Counter Registers for Clock.
> + *
> + * Clock Counter can't be reset or frozen by SW.
> + */
> +#define CLK_CNTR			0x30
> +#define BASIC_EVNT_CLK			0x0
> +
> +/*
> + * Performance Counter Registers for IOMMU / VT-D.
> + *
> + * VT-D Events are listed below as VTD_EVNT_* and VTD_SIP_EVNT_*
> + */
> +#define VTD_CTRL			0x38
> +#define VTD_RESET_CNTR			BIT_ULL(0)
> +#define VTD_FREEZE_CNTR			BIT_ULL(8)
> +#define VTD_CTRL_EVNT			GENMASK_ULL(19, 16)
> +#define VTD_EVNT_AFU_MEM_RD_TRANS	0x0
> +#define VTD_EVNT_AFU_MEM_WR_TRANS	0x1
> +#define VTD_EVNT_AFU_DEVTLB_RD_HIT	0x2
> +#define VTD_EVNT_AFU_DEVTLB_WR_HIT	0x3
> +#define VTD_EVNT_DEVTLB_4K_FILL		0x4
> +#define VTD_EVNT_DEVTLB_2M_FILL		0x5
> +#define VTD_EVNT_DEVTLB_1G_FILL		0x6
> +#define VTD_CNTR			0x40
> +#define VTD_CNTR_EVNT_CNTR		GENMASK_ULL(47, 0)
> +#define VTD_CNTR_EVNT			GENMASK_ULL(63, 60)
> +
> +#define VTD_SIP_CTRL			0x48
> +#define VTD_SIP_RESET_CNTR		BIT_ULL(0)
> +#define VTD_SIP_FREEZE_CNTR		BIT_ULL(8)
> +#define VTD_SIP_CTRL_EVNT		GENMASK_ULL(19, 16)
> +#define VTD_SIP_EVNT_IOTLB_4K_HIT	0x0
> +#define VTD_SIP_EVNT_IOTLB_2M_HIT	0x1
> +#define VTD_SIP_EVNT_IOTLB_1G_HIT	0x2
> +#define VTD_SIP_EVNT_SLPWC_L3_HIT	0x3
> +#define VTD_SIP_EVNT_SLPWC_L4_HIT	0x4
> +#define VTD_SIP_EVNT_RCC_HIT		0x5
> +#define VTD_SIP_EVNT_IOTLB_4K_MISS	0x6
> +#define VTD_SIP_EVNT_IOTLB_2M_MISS	0x7
> +#define VTD_SIP_EVNT_IOTLB_1G_MISS	0x8
> +#define VTD_SIP_EVNT_SLPWC_L3_MISS	0x9
> +#define VTD_SIP_EVNT_SLPWC_L4_MISS	0xa
> +#define VTD_SIP_EVNT_RCC_MISS		0xb
> +#define VTD_SIP_CNTR			0X50
> +#define VTD_SIP_CNTR_EVNT_CNTR		GENMASK_ULL(47, 0)
> +#define VTD_SIP_CNTR_EVNT		GENMASK_ULL(63, 60)
> +
> +#define PERF_TIMEOUT			30
> +
> +#define PERF_MAX_PORT_NUM		1
> +
> +/**
> + * struct fme_perf_priv - priv data structure for fme perf driver
> + *
> + * @dev: parent device.
> + * @ioaddr: mapped base address of mmio region.
> + * @pmu: pmu data structure for fme perf counters.
> + * @id: id of this fme performance report private feature.
> + * @fab_users: current user number on fabric counters.
> + * @fab_port_id: used to indicate current working mode of fabric counters.
> + * @fab_lock: lock to protect fabric counters working mode.
> + * @events_group: events attribute group for fme perf pmu.
> + * @attr_groups: attribute groups for fme perf pmu.
> + */
> +struct fme_perf_priv {
> +	struct device *dev;
> +	void __iomem *ioaddr;
> +	struct pmu pmu;
> +	u64 id;
> +
> +	u32 fab_users;
> +	u32 fab_port_id;
> +	spinlock_t fab_lock;
> +
> +	struct attribute_group events_group;
> +	const struct attribute_group *attr_groups[4];
> +};
> +
> +/**
> + * struct fme_perf_event_attr - fme perf event attribute
> + *
> + * @attr: device attribute of fme perf event.
> + * @event_id: id of fme perf event.
> + * @event_type: type of fme perf event.
> + * @is_port_event: indicate if this is a port based event.
> + * @data: private data for fme perf event.
> + */
> +struct fme_perf_event_attr {
> +	struct device_attribute attr;
> +	u32 event_id;
> +	u32 event_type;
> +	bool is_port_event;
> +	u64 data;
> +};
> +
> +/**
> + * struct fme_perf_event_ops - callbacks for fme perf events
> + *
> + * @event_init: callback invoked during event init.
> + * @event_destroy: callback invoked during event destroy.
> + * @read_counter: callback to read hardware counters.
> + */
> +struct fme_perf_event_ops {
> +	int (*event_init)(struct fme_perf_priv *priv, u32 event,
> +			  u32 port_id, u64 data);
> +	void (*event_destroy)(struct fme_perf_priv *priv, u32 event,
> +			      u32 port_id, u64 data);
> +	u64 (*read_counter)(struct fme_perf_priv *priv, u32 event,
> +			    u32 port_id, u64 data);
> +};
> +
> +/**
> + * struct fme_perf_event_group - fme perf groups
> + *
> + * @ev_attrs: fme perf event attributes.
> + * @num: events number in this group.
> + * @ops: same callbacks shared by all fme perf events in this group.
> + */
> +struct fme_perf_event_group {
> +	struct fme_perf_event_attr *ev_attrs;
> +	unsigned int num;
> +	struct fme_perf_event_ops *ops;
> +};
> +
> +#define to_fme_perf_priv(_pmu)	container_of(_pmu, struct fme_perf_priv, pmu)
> +
> +static cpumask_t fme_perf_cpumask = CPU_MASK_CPU0;
> +
> +static ssize_t cpumask_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	return cpumap_print_to_pagebuf(true, buf, &fme_perf_cpumask);
> +}
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *fme_perf_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group fme_perf_cpumask_group = {
> +	.attrs = fme_perf_cpumask_attrs,
> +};
> +
> +#define FME_EVENT_MASK		GENMASK_ULL(11, 0)
> +#define FME_EVTYPE_MASK		GENMASK_ULL(15, 12)
> +#define FME_EVTYPE_BASIC	0
> +#define FME_EVTYPE_CACHE	1
> +#define FME_EVTYPE_FABRIC	2
> +#define FME_EVTYPE_VTD		3
> +#define FME_EVTYPE_VTD_SIP	4
> +#define FME_EVTYPE_MAX		FME_EVTYPE_VTD_SIP
> +#define FME_PORTID_MASK		GENMASK_ULL(23, 16)
> +#define FME_PORTID_ROOT		(0xffU)
> +
> +PMU_FORMAT_ATTR(event,		"config:0-11");
> +PMU_FORMAT_ATTR(evtype,		"config:12-15");
> +PMU_FORMAT_ATTR(portid,		"config:16-23");
> +
> +static struct attribute *fme_perf_format_attrs[] = {
> +	&format_attr_event.attr,
> +	&format_attr_evtype.attr,
> +	&format_attr_portid.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group fme_perf_format_group = {
> +	.name = "format",
> +	.attrs = fme_perf_format_attrs,
> +};

No Documentation/ABI/ entries for these sysfs files?

thanks,

greg k-h
