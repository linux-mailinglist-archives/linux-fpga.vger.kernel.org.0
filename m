Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E28031A87
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Jun 2019 10:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFAIUr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 1 Jun 2019 04:20:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:47389 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfFAIUr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 1 Jun 2019 04:20:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jun 2019 01:20:44 -0700
X-ExtLoop1: 1
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2019 01:20:41 -0700
Date:   Sat, 1 Jun 2019 16:04:23 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 16/16] fpga: dfl: fme: add performance reporting
 support
Message-ID: <20190601080423.GA3743@hao-dev>
References: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
 <1558934546-12171-17-git-send-email-hao.wu@intel.com>
 <CANk1AXTNzzq6LM+iC05nBkh3zydtYmD6REWN2sJ1BBLjoe8zyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXTNzzq6LM+iC05nBkh3zydtYmD6REWN2sJ1BBLjoe8zyA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 30, 2019 at 01:53:23PM -0500, Alan Tull wrote:
> On Mon, May 27, 2019 at 12:39 AM Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> Just one correction that I saw below, sorry I didn't catch it last time.

Hi Alan

Thanks for the review. I will remove the code below which is not used.

Hao

> 
> >
> > This patch adds support for performance reporting private feature
> > for FPGA Management Engine (FME). Actually it supports 4 categories
> > performance counters, 'clock', 'cache', 'iommu' and 'fabric', user
> > could read the performance counter via exposed sysfs interfaces.
> > Please refer to sysfs doc for more details.
> >
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> 
> Acked-by: Alan Tull <atull@kernel.org>
> 
> > ---
> > v3: replace scnprintf with sprintf in sysfs interfaces.
> >     update sysfs doc kernel version and date.
> >     fix sysfs doc issue for fabric counter.
> >     refine PERF_OBJ_ATTR_* macro, doesn't count on __ATTR anymore.
> >     introduce PERF_OBJ_ATTR_F_* macro, as it needs to use different
> >     filenames for some of the sysfs attributes.
> >     remove kobject_del when destroy kobject, kobject_put is enough.
> >     do sysfs_remove_groups first when destroying perf_obj.
> >     WARN_ON_ONCE in case internal parms are wrong in read_*_count().
> > ---
> >  Documentation/ABI/testing/sysfs-platform-dfl-fme |  93 +++
> >  drivers/fpga/Makefile                            |   1 +
> >  drivers/fpga/dfl-fme-main.c                      |   4 +
> >  drivers/fpga/dfl-fme-perf.c                      | 962 +++++++++++++++++++++++
> >  drivers/fpga/dfl-fme.h                           |   2 +
> >  drivers/fpga/dfl.c                               |   1 +
> >  drivers/fpga/dfl.h                               |   2 +
> >  7 files changed, 1065 insertions(+)
> >  create mode 100644 drivers/fpga/dfl-fme-perf.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > index 5a8938f..63a02cb 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > @@ -119,3 +119,96 @@ Description:       Write-only. Write error code to this file to clear all errors
> >                 logged in errors, first_error and next_error. Write fails with
> >                 -EINVAL if input parsing fails or input error code doesn't
> >                 match.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/clock
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Only. Read for Accelerator Function Unit (AFU) clock
> > +               counter.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/cache/freeze
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Write. Read this file for the current status of 'cache'
> > +               category performance counters, and Write '1' or '0' to freeze
> > +               or unfreeze 'cache' performance counters.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/cache/<counter>
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Only. Read 'cache' category performance counters:
> > +               read_hit, read_miss, write_hit, write_miss, hold_request,
> > +               data_write_port_contention, tag_write_port_contention,
> > +               tx_req_stall, rx_req_stall and rx_eviction.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/iommu/freeze
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Write. Read this file for the current status of 'iommu'
> > +               category performance counters, and Write '1' or '0' to freeze
> > +               or unfreeze 'iommu' performance counters.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/iommu/<sip_counter>
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Only. Read 'iommu' category 'sip' sub category
> > +               performance counters: iotlb_4k_hit, iotlb_2m_hit,
> > +               iotlb_1g_hit, slpwc_l3_hit, slpwc_l4_hit, rcc_hit,
> > +               rcc_miss, iotlb_4k_miss, iotlb_2m_miss, iotlb_1g_miss,
> > +               slpwc_l3_miss and slpwc_l4_miss.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/iommu/afu0/<counter>
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Only. Read 'iommu' category 'afuX' sub category
> > +               performance counters: read_transaction, write_transaction,
> > +               devtlb_read_hit, devtlb_write_hit, devtlb_4k_fill,
> > +               devtlb_2m_fill and devtlb_1g_fill.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/fabric/freeze
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Write. Read this file for the current status of 'fabric'
> > +               category performance counters, and Write '1' or '0' to freeze
> > +               or unfreeze 'fabric' performance counters.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/fabric/<counter>
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Only. Read 'fabric' category performance counters:
> > +               pcie0_read, pcie0_write, pcie1_read, pcie1_write,
> > +               upi_read, upi_write, mmio_read and mmio_write.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/fabric/enable
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Write. Read this file for current status of device level
> > +               fabric counters. Write "1" to enable device level fabric
> > +               counters. Once device level fabric counters are enabled, port
> > +               level fabric counters will be disabled automatically.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/fabric/port0/<counter>
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Only. Read 'fabric' category "portX" sub category
> > +               performance counters: pcie0_read, pcie0_write, pcie1_read,
> > +               pcie1_write, upi_read, upi_write and mmio_read.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/perf/fabric/port0/enable
> > +Date:          May 2019
> > +KernelVersion:  5.3
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Write. Read this file for current status of port level
> > +               fabric counters. Write "1" to enable port level fabric counters.
> > +               Once port level fabric counters are enabled, device level fabric
> > +               counters will be disabled automatically.
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index 4865b74..d8e21df 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -40,6 +40,7 @@ obj-$(CONFIG_FPGA_DFL_FME_REGION)     += dfl-fme-region.o
> >  obj-$(CONFIG_FPGA_DFL_AFU)             += dfl-afu.o
> >
> >  dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o dfl-fme-error.o
> > +dfl-fme-objs += dfl-fme-perf.o
> >  dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
> >  dfl-afu-objs += dfl-afu-error.o
> >
> > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > index 4490cf4..4a5b25d 100644
> > --- a/drivers/fpga/dfl-fme-main.c
> > +++ b/drivers/fpga/dfl-fme-main.c
> > @@ -231,6 +231,10 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
> >                 .ops = &fme_global_err_ops,
> >         },
> >         {
> > +               .id_table = fme_perf_id_table,
> > +               .ops = &fme_perf_ops,
> > +       },
> > +       {
> >                 .ops = NULL,
> >         },
> >  };
> > diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> > new file mode 100644
> > index 0000000..6eb6c89
> > --- /dev/null
> > +++ b/drivers/fpga/dfl-fme-perf.c
> > @@ -0,0 +1,962 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for FPGA Management Engine (FME) Global Performance Reporting
> > + *
> > + * Copyright 2019 Intel Corporation, Inc.
> > + *
> > + * Authors:
> > + *   Kang Luwei <luwei.kang@intel.com>
> > + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > + *   Wu Hao <hao.wu@intel.com>
> > + *   Joseph Grecco <joe.grecco@intel.com>
> > + *   Enno Luebbers <enno.luebbers@intel.com>
> > + *   Tim Whisonant <tim.whisonant@intel.com>
> > + *   Ananda Ravuri <ananda.ravuri@intel.com>
> > + *   Mitchel, Henry <henry.mitchel@intel.com>
> > + */
> > +
> > +#include "dfl.h"
> > +#include "dfl-fme.h"
> > +
> > +/*
> > + * Performance Counter Registers for Cache.
> > + *
> > + * Cache Events are listed below as CACHE_EVNT_*.
> > + */
> > +#define CACHE_CTRL                     0x8
> > +#define CACHE_RESET_CNTR               BIT_ULL(0)
> > +#define CACHE_FREEZE_CNTR              BIT_ULL(8)
> > +#define CACHE_CTRL_EVNT                        GENMASK_ULL(19, 16)
> > +#define CACHE_EVNT_RD_HIT              0x0
> > +#define CACHE_EVNT_WR_HIT              0x1
> > +#define CACHE_EVNT_RD_MISS             0x2
> > +#define CACHE_EVNT_WR_MISS             0x3
> > +#define CACHE_EVNT_RSVD                        0x4
> > +#define CACHE_EVNT_HOLD_REQ            0x5
> > +#define CACHE_EVNT_DATA_WR_PORT_CONTEN 0x6
> > +#define CACHE_EVNT_TAG_WR_PORT_CONTEN  0x7
> > +#define CACHE_EVNT_TX_REQ_STALL                0x8
> > +#define CACHE_EVNT_RX_REQ_STALL                0x9
> > +#define CACHE_EVNT_EVICTIONS           0xa
> > +#define CACHE_EVNT_MAX                 CACHE_EVNT_EVICTIONS
> > +#define CACHE_CHANNEL_SEL              BIT_ULL(20)
> > +#define CACHE_CHANNEL_RD               0
> > +#define CACHE_CHANNEL_WR               1
> > +#define CACHE_CHANNEL_MAX              2
> > +#define CACHE_CNTR0                    0x10
> > +#define CACHE_CNTR1                    0x18
> > +#define CACHE_CNTR_EVNT_CNTR           GENMASK_ULL(47, 0)
> > +#define CACHE_CNTR_EVNT                        GENMASK_ULL(63, 60)
> > +
> > +/*
> > + * Performance Counter Registers for Fabric.
> > + *
> > + * Fabric Events are listed below as FAB_EVNT_*
> > + */
> > +#define FAB_CTRL                       0x20
> > +#define FAB_RESET_CNTR                 BIT_ULL(0)
> > +#define FAB_FREEZE_CNTR                        BIT_ULL(8)
> > +#define FAB_CTRL_EVNT                  GENMASK_ULL(19, 16)
> > +#define FAB_EVNT_PCIE0_RD              0x0
> > +#define FAB_EVNT_PCIE0_WR              0x1
> > +#define FAB_EVNT_PCIE1_RD              0x2
> > +#define FAB_EVNT_PCIE1_WR              0x3
> > +#define FAB_EVNT_UPI_RD                        0x4
> > +#define FAB_EVNT_UPI_WR                        0x5
> > +#define FAB_EVNT_MMIO_RD               0x6
> > +#define FAB_EVNT_MMIO_WR               0x7
> > +#define FAB_EVNT_MAX                   FAB_EVNT_MMIO_WR
> > +#define FAB_PORT_ID                    GENMASK_ULL(21, 20)
> > +#define FAB_PORT_FILTER                        BIT_ULL(23)
> > +#define FAB_PORT_FILTER_DISABLE                0
> > +#define FAB_PORT_FILTER_ENABLE         1
> > +#define FAB_CNTR                       0x28
> > +#define FAB_CNTR_EVNT_CNTR             GENMASK_ULL(59, 0)
> > +#define FAB_CNTR_EVNT                  GENMASK_ULL(63, 60)
> > +
> > +/*
> > + * Performance Counter Registers for Clock.
> > + *
> > + * Clock Counter can't be reset or frozen by SW.
> > + */
> > +#define CLK_CNTR                       0x30
> > +
> > +/*
> > + * Performance Counter Registers for IOMMU / VT-D.
> > + *
> > + * VT-D Events are listed below as VTD_EVNT_* and VTD_SIP_EVNT_*
> > + */
> > +#define VTD_CTRL                       0x38
> > +#define VTD_RESET_CNTR                 BIT_ULL(0)
> > +#define VTD_FREEZE_CNTR                        BIT_ULL(8)
> > +#define VTD_CTRL_EVNT                  GENMASK_ULL(19, 16)
> > +#define VTD_EVNT_AFU_MEM_RD_TRANS      0x0
> > +#define VTD_EVNT_AFU_MEM_WR_TRANS      0x1
> > +#define VTD_EVNT_AFU_DEVTLB_RD_HIT     0x2
> > +#define VTD_EVNT_AFU_DEVTLB_WR_HIT     0x3
> > +#define VTD_EVNT_DEVTLB_4K_FILL                0x4
> > +#define VTD_EVNT_DEVTLB_2M_FILL                0x5
> > +#define VTD_EVNT_DEVTLB_1G_FILL                0x6
> > +#define VTD_EVNT_MAX                   VTD_EVNT_DEVTLB_1G_FILL
> > +#define VTD_CNTR                       0x40
> > +#define VTD_CNTR_EVNT                  GENMASK_ULL(63, 60)
> > +#define VTD_CNTR_EVNT_CNTR             GENMASK_ULL(47, 0)
> > +#define VTD_SIP_CTRL                   0x48
> > +#define VTD_SIP_RESET_CNTR             BIT_ULL(0)
> > +#define VTD_SIP_FREEZE_CNTR            BIT_ULL(8)
> > +#define VTD_SIP_CTRL_EVNT              GENMASK_ULL(19, 16)
> > +#define VTD_SIP_EVNT_IOTLB_4K_HIT      0x0
> > +#define VTD_SIP_EVNT_IOTLB_2M_HIT      0x1
> > +#define VTD_SIP_EVNT_IOTLB_1G_HIT      0x2
> > +#define VTD_SIP_EVNT_SLPWC_L3_HIT      0x3
> > +#define VTD_SIP_EVNT_SLPWC_L4_HIT      0x4
> > +#define VTD_SIP_EVNT_RCC_HIT           0x5
> > +#define VTD_SIP_EVNT_IOTLB_4K_MISS     0x6
> > +#define VTD_SIP_EVNT_IOTLB_2M_MISS     0x7
> > +#define VTD_SIP_EVNT_IOTLB_1G_MISS     0x8
> > +#define VTD_SIP_EVNT_SLPWC_L3_MISS     0x9
> > +#define VTD_SIP_EVNT_SLPWC_L4_MISS     0xa
> > +#define VTD_SIP_EVNT_RCC_MISS          0xb
> > +#define VTD_SIP_EVNT_MAX               VTD_SIP_EVNT_RCC_MISS
> > +#define VTD_SIP_CNTR                   0X50
> > +#define VTD_SIP_CNTR_EVNT              GENMASK_ULL(63, 60)
> > +#define VTD_SIP_CNTR_EVNT_CNTR         GENMASK_ULL(47, 0)
> > +
> > +#define PERF_OBJ_ROOT_ID               (~0)
> > +
> > +#define PERF_TIMEOUT                   30
> > +
> > +/**
> > + * struct perf_object - object of performance counter
> > + *
> > + * @id: instance id. PERF_OBJ_ROOT_ID indicates it is a parent object which
> > + *      counts performance counters for all instances.
> > + * @attr_groups: the sysfs files are associated with this object.
> > + * @feature: pointer to related private feature.
> > + * @node: used to link itself to parent's children list.
> > + * @children: used to link its children objects together.
> > + * @kobj: generic kobject interface.
> > + *
> > + * 'node' and 'children' are used to construct parent-children hierarchy.
> > + */
> > +struct perf_object {
> > +       int id;
> > +       const struct attribute_group **attr_groups;
> > +       struct dfl_feature *feature;
> > +
> > +       struct list_head node;
> > +       struct list_head children;
> > +       struct kobject kobj;
> > +};
> > +
> > +/**
> > + * struct perf_obj_attribute - attribute of perf object
> > + *
> > + * @attr: attribute of this perf object.
> > + * @show: show callback for sysfs attribute.
> > + * @store: store callback for sysfs attribute.
> > + */
> > +struct perf_obj_attribute {
> > +       struct attribute attr;
> > +       ssize_t (*show)(struct perf_object *pobj, char *buf);
> > +       ssize_t (*store)(struct perf_object *pobj,
> > +                        const char *buf, size_t n);
> > +};
> > +
> > +#define to_perf_obj_attr(_attr)                                        \
> > +               container_of(_attr, struct perf_obj_attribute, attr)
> > +#define to_perf_obj(_kobj)                                     \
> > +               container_of(_kobj, struct perf_object, kobj)
> > +
> > +#define __POBJ_ATTR(_name, _mode, _show, _store) {                     \
> > +       .attr = {.name = __stringify(_name),                            \
> > +                .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },             \
> > +       .show   = _show,                                                \
> > +       .store  = _store,                                               \
> > +}
> > +
> > +#define PERF_OBJ_ATTR_F_RO(_name, _filename)                           \
> > +struct perf_obj_attribute perf_obj_attr_##_name =                      \
> > +       __POBJ_ATTR(_filename, 0444, _name##_show, NULL)
> > +
> > +#define PERF_OBJ_ATTR_F_WO(_name, _filename)                           \
> > +struct perf_obj_attribute perf_obj_attr_##_name =                      \
> > +       __POBJ_ATTR(_filename, 0200, NULL, _name##_store)
> 
> Please remove the macros that aren't actually used.  I think that
> includes PERF_OBJ_ATTR_F_RO, PERF_OBJ_ATTR_F_WO, PERF_OBJ_ATTR_WO, and
> PERF_OBJ_ATTR_RW.
> 
> > +
> > +#define PERF_OBJ_ATTR_F_RW(_name, _filename)                           \
> > +struct perf_obj_attribute perf_obj_attr_##_name =                      \
> > +       __POBJ_ATTR(_filename, 0644, _name##_show, _name##_store)
> > +
> > +#define PERF_OBJ_ATTR_RO(_name)                                                \
> > +struct perf_obj_attribute perf_obj_attr_##_name =                      \
> > +       __POBJ_ATTR(_name, 0444, _name##_show, NULL)
> > +
> > +#define PERF_OBJ_ATTR_WO(_name)                                                \
> > +struct perf_obj_attribute perf_obj_attr_##_name =                      \
> > +       __POBJ_ATTR(_name, 0200, NULL, _name##_store)
> > +
> > +#define PERF_OBJ_ATTR_RW(_name)                                                \
> > +struct perf_obj_attribute perf_obj_attr_##_name =                      \
> > +       __POBJ_ATTR(_name, 0644, _name##_show, _name##_store)
> > +
> > +static ssize_t perf_obj_attr_show(struct kobject *kobj,
> > +                                 struct attribute *__attr, char *buf)
> > +{
> > +       struct perf_obj_attribute *attr = to_perf_obj_attr(__attr);
> > +       struct perf_object *pobj = to_perf_obj(kobj);
> > +       ssize_t ret = -EIO;
> > +
> > +       if (attr->show)
> > +               ret = attr->show(pobj, buf);
> > +       return ret;
> > +}
> > +
> > +static ssize_t perf_obj_attr_store(struct kobject *kobj,
> > +                                  struct attribute *__attr,
> > +                                  const char *buf, size_t n)
> > +{
> > +       struct perf_obj_attribute *attr = to_perf_obj_attr(__attr);
> > +       struct perf_object *pobj = to_perf_obj(kobj);
> > +       ssize_t ret = -EIO;
> > +
> > +       if (attr->store)
> > +               ret = attr->store(pobj, buf, n);
> > +       return ret;
> > +}
> > +
> > +static const struct sysfs_ops perf_obj_sysfs_ops = {
> > +       .show = perf_obj_attr_show,
> > +       .store = perf_obj_attr_store,
> > +};
> > +
> > +static void perf_obj_release(struct kobject *kobj)
> > +{
> > +       kfree(to_perf_obj(kobj));
> > +}
> > +
> > +static struct kobj_type perf_obj_ktype = {
> > +       .sysfs_ops = &perf_obj_sysfs_ops,
> > +       .release = perf_obj_release,
> > +};
> > +
> > +static struct perf_object *
> > +create_perf_obj(struct dfl_feature *feature, struct kobject *parent, int id,
> > +               const struct attribute_group **groups, const char *name)
> > +{
> > +       struct perf_object *pobj;
> > +       int ret;
> > +
> > +       pobj = kzalloc(sizeof(*pobj), GFP_KERNEL);
> > +       if (!pobj)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       pobj->id = id;
> > +       pobj->feature = feature;
> > +       pobj->attr_groups = groups;
> > +       INIT_LIST_HEAD(&pobj->node);
> > +       INIT_LIST_HEAD(&pobj->children);
> > +
> > +       if (id != PERF_OBJ_ROOT_ID)
> > +               ret = kobject_init_and_add(&pobj->kobj, &perf_obj_ktype,
> > +                                          parent, "%s%d", name, id);
> > +       else
> > +               ret = kobject_init_and_add(&pobj->kobj, &perf_obj_ktype,
> > +                                          parent, "%s", name);
> > +       if (ret)
> > +               goto put_exit;
> > +
> > +       if (pobj->attr_groups) {
> > +               ret = sysfs_create_groups(&pobj->kobj, pobj->attr_groups);
> > +               if (ret)
> > +                       goto put_exit;
> > +       }
> > +
> > +       return pobj;
> > +
> > +put_exit:
> > +       kobject_put(&pobj->kobj);
> > +       return ERR_PTR(ret);
> > +}
> > +
> > +/*
> > + * Counter Sysfs Interface for Clock.
> > + */
> > +static ssize_t clock_show(struct perf_object *pobj, char *buf)
> > +{
> > +       void __iomem *base = pobj->feature->ioaddr;
> > +
> > +       return sprintf(buf, "0x%llx\n",
> > +                      (unsigned long long)readq(base + CLK_CNTR));
> > +}
> > +static PERF_OBJ_ATTR_RO(clock);
> > +
> > +static struct attribute *clock_attrs[] = {
> > +       &perf_obj_attr_clock.attr,
> > +       NULL,
> > +};
> > +
> > +static struct attribute_group clock_attr_group = {
> > +       .attrs = clock_attrs,
> > +};
> > +
> > +static const struct attribute_group *perf_dev_attr_groups[] = {
> > +       &clock_attr_group,
> > +       NULL,
> > +};
> > +
> > +static void destroy_perf_obj(struct perf_object *pobj)
> > +{
> > +       struct perf_object *obj, *obj_tmp;
> > +
> > +       if (pobj->attr_groups)
> > +               sysfs_remove_groups(&pobj->kobj, pobj->attr_groups);
> > +
> > +       list_for_each_entry_safe(obj, obj_tmp, &pobj->children, node)
> > +               destroy_perf_obj(obj);
> > +
> > +       list_del(&pobj->node);
> > +       kobject_put(&pobj->kobj);
> > +}
> > +
> > +static struct perf_object *create_perf_dev(struct dfl_feature *feature)
> > +{
> > +       struct platform_device *pdev = feature->pdev;
> > +
> > +       return create_perf_obj(feature, &pdev->dev.kobj, PERF_OBJ_ROOT_ID,
> > +                              perf_dev_attr_groups, "perf");
> > +}
> > +
> > +/*
> > + * Counter Sysfs Interfaces for Cache.
> > + */
> > +static ssize_t cache_freeze_show(struct perf_object *pobj, char *buf)
> > +{
> > +       void __iomem *base = pobj->feature->ioaddr;
> > +       u64 v;
> > +
> > +       v = readq(base + CACHE_CTRL);
> > +
> > +       return sprintf(buf, "%u\n",
> > +                      (unsigned int)FIELD_GET(CACHE_FREEZE_CNTR, v));
> > +}
> > +
> > +static ssize_t cache_freeze_store(struct perf_object *pobj,
> > +                                 const char *buf, size_t n)
> > +{
> > +       struct dfl_feature *feature = pobj->feature;
> > +       struct dfl_feature_platform_data *pdata;
> > +       void __iomem *base = feature->ioaddr;
> > +       bool state;
> > +       u64 v;
> > +
> > +       if (strtobool(buf, &state))
> > +               return -EINVAL;
> > +
> > +       pdata = dev_get_platdata(&feature->pdev->dev);
> > +
> > +       mutex_lock(&pdata->lock);
> > +       v = readq(base + CACHE_CTRL);
> > +       v &= ~CACHE_FREEZE_CNTR;
> > +       v |= FIELD_PREP(CACHE_FREEZE_CNTR, state ? 1 : 0);
> > +       writeq(v, base + CACHE_CTRL);
> > +       mutex_unlock(&pdata->lock);
> > +
> > +       return n;
> > +}
> > +static PERF_OBJ_ATTR_F_RW(cache_freeze, freeze);
> > +
> > +static ssize_t read_cache_counter(struct perf_object *pobj, char *buf,
> > +                                 u8 channel, u8 event)
> > +{
> > +       struct dfl_feature *feature = pobj->feature;
> > +       struct dfl_feature_platform_data *pdata;
> > +       void __iomem *base = feature->ioaddr;
> > +       u64 v, count;
> > +
> > +       WARN_ON_ONCE(event > CACHE_EVNT_MAX || channel > CACHE_CHANNEL_MAX);
> > +
> > +       pdata = dev_get_platdata(&feature->pdev->dev);
> > +
> > +       mutex_lock(&pdata->lock);
> > +       /* set channel access type and cache event code. */
> > +       v = readq(base + CACHE_CTRL);
> > +       v &= ~(CACHE_CHANNEL_SEL | CACHE_CTRL_EVNT);
> > +       v |= FIELD_PREP(CACHE_CHANNEL_SEL, channel);
> > +       v |= FIELD_PREP(CACHE_CTRL_EVNT, event);
> > +       writeq(v, base + CACHE_CTRL);
> > +
> > +       if (readq_poll_timeout(base + CACHE_CNTR0, v,
> > +                              FIELD_GET(CACHE_CNTR_EVNT, v) == event,
> > +                              1, PERF_TIMEOUT)) {
> > +               dev_err(&feature->pdev->dev, "timeout, unmatched cache event type in counter registers.\n");
> > +               mutex_unlock(&pdata->lock);
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       v = readq(base + CACHE_CNTR0);
> > +       count = FIELD_GET(CACHE_CNTR_EVNT_CNTR, v);
> > +       v = readq(base + CACHE_CNTR1);
> > +       count += FIELD_GET(CACHE_CNTR_EVNT_CNTR, v);
> > +       mutex_unlock(&pdata->lock);
> > +
> > +       return sprintf(buf, "0x%llx\n", (unsigned long long)count);
> > +}
> > +
> > +#define CACHE_SHOW(name, channel, event)                               \
> > +static ssize_t name##_show(struct perf_object *pobj, char *buf)                \
> > +{                                                                      \
> > +       return read_cache_counter(pobj, buf, channel, event);           \
> > +}                                                                      \
> > +static PERF_OBJ_ATTR_RO(name)
> > +
> > +CACHE_SHOW(read_hit, CACHE_CHANNEL_RD, CACHE_EVNT_RD_HIT);
> > +CACHE_SHOW(read_miss, CACHE_CHANNEL_RD, CACHE_EVNT_RD_MISS);
> > +CACHE_SHOW(write_hit, CACHE_CHANNEL_WR, CACHE_EVNT_WR_HIT);
> > +CACHE_SHOW(write_miss, CACHE_CHANNEL_WR, CACHE_EVNT_WR_MISS);
> > +CACHE_SHOW(hold_request, CACHE_CHANNEL_RD, CACHE_EVNT_HOLD_REQ);
> > +CACHE_SHOW(tx_req_stall, CACHE_CHANNEL_RD, CACHE_EVNT_TX_REQ_STALL);
> > +CACHE_SHOW(rx_req_stall, CACHE_CHANNEL_RD, CACHE_EVNT_RX_REQ_STALL);
> > +CACHE_SHOW(rx_eviction, CACHE_CHANNEL_RD, CACHE_EVNT_EVICTIONS);
> > +CACHE_SHOW(data_write_port_contention, CACHE_CHANNEL_WR,
> > +          CACHE_EVNT_DATA_WR_PORT_CONTEN);
> > +CACHE_SHOW(tag_write_port_contention, CACHE_CHANNEL_WR,
> > +          CACHE_EVNT_TAG_WR_PORT_CONTEN);
> > +
> > +static struct attribute *cache_attrs[] = {
> > +       &perf_obj_attr_read_hit.attr,
> > +       &perf_obj_attr_read_miss.attr,
> > +       &perf_obj_attr_write_hit.attr,
> > +       &perf_obj_attr_write_miss.attr,
> > +       &perf_obj_attr_hold_request.attr,
> > +       &perf_obj_attr_data_write_port_contention.attr,
> > +       &perf_obj_attr_tag_write_port_contention.attr,
> > +       &perf_obj_attr_tx_req_stall.attr,
> > +       &perf_obj_attr_rx_req_stall.attr,
> > +       &perf_obj_attr_rx_eviction.attr,
> > +       &perf_obj_attr_cache_freeze.attr,
> > +       NULL,
> > +};
> > +
> > +static struct attribute_group cache_attr_group = {
> > +       .attrs = cache_attrs,
> > +};
> > +
> > +static const struct attribute_group *cache_attr_groups[] = {
> > +       &cache_attr_group,
> > +       NULL,
> > +};
> > +
> > +static int create_perf_cache_obj(struct perf_object *perf_dev)
> > +{
> > +       struct perf_object *pobj;
> > +
> > +       pobj = create_perf_obj(perf_dev->feature, &perf_dev->kobj,
> > +                              PERF_OBJ_ROOT_ID, cache_attr_groups, "cache");
> > +       if (IS_ERR(pobj))
> > +               return PTR_ERR(pobj);
> > +
> > +       list_add(&pobj->node, &perf_dev->children);
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Counter Sysfs Interfaces for VT-D / IOMMU.
> > + */
> > +static ssize_t vtd_freeze_show(struct perf_object *pobj, char *buf)
> > +{
> > +       void __iomem *base = pobj->feature->ioaddr;
> > +       u64 v;
> > +
> > +       v = readq(base + VTD_CTRL);
> > +
> > +       return sprintf(buf, "%u\n",
> > +                      (unsigned int)FIELD_GET(VTD_FREEZE_CNTR, v));
> > +}
> > +
> > +static ssize_t vtd_freeze_store(struct perf_object *pobj,
> > +                               const char *buf, size_t n)
> > +{
> > +       struct dfl_feature *feature = pobj->feature;
> > +       struct dfl_feature_platform_data *pdata;
> > +       void __iomem *base = feature->ioaddr;
> > +       bool state;
> > +       u64 v;
> > +
> > +       if (strtobool(buf, &state))
> > +               return -EINVAL;
> > +
> > +       pdata = dev_get_platdata(&feature->pdev->dev);
> > +
> > +       mutex_lock(&pdata->lock);
> > +       v = readq(base + VTD_CTRL);
> > +       v &= ~VTD_FREEZE_CNTR;
> > +       v |= FIELD_PREP(VTD_FREEZE_CNTR, state ? 1 : 0);
> > +       writeq(v, base + VTD_CTRL);
> > +       mutex_unlock(&pdata->lock);
> > +
> > +       return n;
> > +}
> > +static PERF_OBJ_ATTR_F_RW(vtd_freeze, freeze);
> > +
> > +static struct attribute *iommu_top_attrs[] = {
> > +       &perf_obj_attr_vtd_freeze.attr,
> > +       NULL,
> > +};
> > +
> > +static struct attribute_group iommu_top_attr_group = {
> > +       .attrs = iommu_top_attrs,
> > +};
> > +
> > +static ssize_t read_iommu_sip_counter(struct perf_object *pobj,
> > +                                     u8 event, char *buf)
> > +{
> > +       struct dfl_feature *feature = pobj->feature;
> > +       struct dfl_feature_platform_data *pdata;
> > +       void __iomem *base = feature->ioaddr;
> > +       u64 v, count;
> > +
> > +       WARN_ON_ONCE(event > VTD_SIP_EVNT_MAX);
> > +
> > +       pdata = dev_get_platdata(&feature->pdev->dev);
> > +
> > +       mutex_lock(&pdata->lock);
> > +       v = readq(base + VTD_SIP_CTRL);
> > +       v &= ~VTD_SIP_CTRL_EVNT;
> > +       v |= FIELD_PREP(VTD_SIP_CTRL_EVNT, event);
> > +       writeq(v, base + VTD_SIP_CTRL);
> > +
> > +       if (readq_poll_timeout(base + VTD_SIP_CNTR, v,
> > +                              FIELD_GET(VTD_SIP_CNTR_EVNT, v) == event,
> > +                              1, PERF_TIMEOUT)) {
> > +               dev_err(&feature->pdev->dev, "timeout, unmatched VTd SIP event type in counter registers\n");
> > +               mutex_unlock(&pdata->lock);
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       v = readq(base + VTD_SIP_CNTR);
> > +       count = FIELD_GET(VTD_SIP_CNTR_EVNT_CNTR, v);
> > +       mutex_unlock(&pdata->lock);
> > +
> > +       return sprintf(buf, "0x%llx\n", (unsigned long long)count);
> > +}
> > +
> > +#define VTD_SIP_SHOW(name, event)                                      \
> > +static ssize_t name##_show(struct perf_object *pobj, char *buf)                \
> > +{                                                                      \
> > +       return read_iommu_sip_counter(pobj, event, buf);                \
> > +}                                                                      \
> > +static PERF_OBJ_ATTR_RO(name)
> > +
> > +VTD_SIP_SHOW(iotlb_4k_hit, VTD_SIP_EVNT_IOTLB_4K_HIT);
> > +VTD_SIP_SHOW(iotlb_2m_hit, VTD_SIP_EVNT_IOTLB_2M_HIT);
> > +VTD_SIP_SHOW(iotlb_1g_hit, VTD_SIP_EVNT_IOTLB_1G_HIT);
> > +VTD_SIP_SHOW(slpwc_l3_hit, VTD_SIP_EVNT_SLPWC_L3_HIT);
> > +VTD_SIP_SHOW(slpwc_l4_hit, VTD_SIP_EVNT_SLPWC_L4_HIT);
> > +VTD_SIP_SHOW(rcc_hit, VTD_SIP_EVNT_RCC_HIT);
> > +VTD_SIP_SHOW(iotlb_4k_miss, VTD_SIP_EVNT_IOTLB_4K_MISS);
> > +VTD_SIP_SHOW(iotlb_2m_miss, VTD_SIP_EVNT_IOTLB_2M_MISS);
> > +VTD_SIP_SHOW(iotlb_1g_miss, VTD_SIP_EVNT_IOTLB_1G_MISS);
> > +VTD_SIP_SHOW(slpwc_l3_miss, VTD_SIP_EVNT_SLPWC_L3_MISS);
> > +VTD_SIP_SHOW(slpwc_l4_miss, VTD_SIP_EVNT_SLPWC_L4_MISS);
> > +VTD_SIP_SHOW(rcc_miss, VTD_SIP_EVNT_RCC_MISS);
> > +
> > +static struct attribute *iommu_sip_attrs[] = {
> > +       &perf_obj_attr_iotlb_4k_hit.attr,
> > +       &perf_obj_attr_iotlb_2m_hit.attr,
> > +       &perf_obj_attr_iotlb_1g_hit.attr,
> > +       &perf_obj_attr_slpwc_l3_hit.attr,
> > +       &perf_obj_attr_slpwc_l4_hit.attr,
> > +       &perf_obj_attr_rcc_hit.attr,
> > +       &perf_obj_attr_iotlb_4k_miss.attr,
> > +       &perf_obj_attr_iotlb_2m_miss.attr,
> > +       &perf_obj_attr_iotlb_1g_miss.attr,
> > +       &perf_obj_attr_slpwc_l3_miss.attr,
> > +       &perf_obj_attr_slpwc_l4_miss.attr,
> > +       &perf_obj_attr_rcc_miss.attr,
> > +       NULL,
> > +};
> > +
> > +static struct attribute_group iommu_sip_attr_group = {
> > +       .attrs = iommu_sip_attrs,
> > +};
> > +
> > +static const struct attribute_group *iommu_top_attr_groups[] = {
> > +       &iommu_top_attr_group,
> > +       &iommu_sip_attr_group,
> > +       NULL,
> > +};
> > +
> > +static ssize_t read_iommu_counter(struct perf_object *pobj, u8 event, char *buf)
> > +{
> > +       struct dfl_feature *feature = pobj->feature;
> > +       struct dfl_feature_platform_data *pdata;
> > +       void __iomem *base = feature->ioaddr;
> > +       u64 v, count;
> > +
> > +       WARN_ON_ONCE(event > VTD_EVNT_MAX);
> > +
> > +       event += pobj->id;
> > +       pdata = dev_get_platdata(&feature->pdev->dev);
> > +
> > +       mutex_lock(&pdata->lock);
> > +       v = readq(base + VTD_CTRL);
> > +       v &= ~VTD_CTRL_EVNT;
> > +       v |= FIELD_PREP(VTD_CTRL_EVNT, event);
> > +       writeq(v, base + VTD_CTRL);
> > +
> > +       if (readq_poll_timeout(base + VTD_CNTR, v,
> > +                              FIELD_GET(VTD_CNTR_EVNT, v) == event, 1,
> > +                              PERF_TIMEOUT)) {
> > +               dev_err(&feature->pdev->dev, "timeout, unmatched VTd event type in counter registers\n");
> > +               mutex_unlock(&pdata->lock);
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       v = readq(base + VTD_CNTR);
> > +       count = FIELD_GET(VTD_CNTR_EVNT_CNTR, v);
> > +       mutex_unlock(&pdata->lock);
> > +
> > +       return sprintf(buf, "0x%llx\n", (unsigned long long)count);
> > +}
> > +
> > +#define VTD_SHOW(name, base_event)                                     \
> > +static ssize_t name##_show(struct perf_object *pobj, char *buf)                \
> > +{                                                                      \
> > +       return read_iommu_counter(pobj, base_event, buf);               \
> > +}                                                                      \
> > +static PERF_OBJ_ATTR_RO(name)
> > +
> > +VTD_SHOW(read_transaction, VTD_EVNT_AFU_MEM_RD_TRANS);
> > +VTD_SHOW(write_transaction, VTD_EVNT_AFU_MEM_WR_TRANS);
> > +VTD_SHOW(devtlb_read_hit, VTD_EVNT_AFU_DEVTLB_RD_HIT);
> > +VTD_SHOW(devtlb_write_hit, VTD_EVNT_AFU_DEVTLB_WR_HIT);
> > +VTD_SHOW(devtlb_4k_fill, VTD_EVNT_DEVTLB_4K_FILL);
> > +VTD_SHOW(devtlb_2m_fill, VTD_EVNT_DEVTLB_2M_FILL);
> > +VTD_SHOW(devtlb_1g_fill, VTD_EVNT_DEVTLB_1G_FILL);
> > +
> > +static struct attribute *iommu_attrs[] = {
> > +       &perf_obj_attr_read_transaction.attr,
> > +       &perf_obj_attr_write_transaction.attr,
> > +       &perf_obj_attr_devtlb_read_hit.attr,
> > +       &perf_obj_attr_devtlb_write_hit.attr,
> > +       &perf_obj_attr_devtlb_4k_fill.attr,
> > +       &perf_obj_attr_devtlb_2m_fill.attr,
> > +       &perf_obj_attr_devtlb_1g_fill.attr,
> > +       NULL,
> > +};
> > +
> > +static struct attribute_group iommu_attr_group = {
> > +       .attrs = iommu_attrs,
> > +};
> > +
> > +static const struct attribute_group *iommu_attr_groups[] = {
> > +       &iommu_attr_group,
> > +       NULL,
> > +};
> > +
> > +#define PERF_MAX_PORT_NUM      1
> > +
> > +static int create_perf_iommu_obj(struct perf_object *perf_dev)
> > +{
> > +       struct dfl_feature *feature = perf_dev->feature;
> > +       struct device *dev = &feature->pdev->dev;
> > +       struct perf_object *pobj, *obj;
> > +       void __iomem *base;
> > +       u64 v;
> > +       int i;
> > +
> > +       /* check if iommu is not supported on this device. */
> > +       base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> > +       v = readq(base + FME_HDR_CAP);
> > +       if (!FIELD_GET(FME_CAP_IOMMU_AVL, v))
> > +               return 0;
> > +
> > +       pobj = create_perf_obj(feature, &perf_dev->kobj, PERF_OBJ_ROOT_ID,
> > +                              iommu_top_attr_groups, "iommu");
> > +       if (IS_ERR(pobj))
> > +               return PTR_ERR(pobj);
> > +
> > +       list_add(&pobj->node, &perf_dev->children);
> > +
> > +       for (i = 0; i < PERF_MAX_PORT_NUM; i++) {
> > +               obj = create_perf_obj(feature, &pobj->kobj, i,
> > +                                     iommu_attr_groups, "afu");
> > +               if (IS_ERR(obj))
> > +                       return PTR_ERR(obj);
> > +
> > +               list_add(&obj->node, &pobj->children);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Counter Sysfs Interfaces for Fabric
> > + */
> > +static bool fabric_pobj_is_enabled(struct perf_object *pobj)
> > +{
> > +       struct dfl_feature *feature = pobj->feature;
> > +       void __iomem *base = feature->ioaddr;
> > +       u64 v;
> > +
> > +       v = readq(base + FAB_CTRL);
> > +
> > +       if (FIELD_GET(FAB_PORT_FILTER, v) == FAB_PORT_FILTER_DISABLE)
> > +               return pobj->id == PERF_OBJ_ROOT_ID;
> > +
> > +       return pobj->id == FIELD_GET(FAB_PORT_ID, v);
> > +}
> > +
> > +static ssize_t read_fabric_counter(struct perf_object *pobj,
> > +                                  u8 event, char *buf)
> > +{
> > +       struct dfl_feature *feature = pobj->feature;
> > +       struct dfl_feature_platform_data *pdata;
> > +       void __iomem *base = feature->ioaddr;
> > +       u64 v, count = 0;
> > +
> > +       WARN_ON_ONCE(event > FAB_EVNT_MAX);
> > +
> > +       pdata = dev_get_platdata(&feature->pdev->dev);
> > +
> > +       mutex_lock(&pdata->lock);
> > +       /* if it is disabled, force the counter to return zero. */
> > +       if (!fabric_pobj_is_enabled(pobj))
> > +               goto exit;
> > +
> > +       v = readq(base + FAB_CTRL);
> > +       v &= ~FAB_CTRL_EVNT;
> > +       v |= FIELD_PREP(FAB_CTRL_EVNT, event);
> > +       writeq(v, base + FAB_CTRL);
> > +
> > +       if (readq_poll_timeout(base + FAB_CNTR, v,
> > +                              FIELD_GET(FAB_CNTR_EVNT, v) == event,
> > +                              1, PERF_TIMEOUT)) {
> > +               dev_err(&feature->pdev->dev, "timeout, unmatched fab event type in counter registers.\n");
> > +               mutex_unlock(&pdata->lock);
> > +               return -ETIMEDOUT;
> > +       }
> > +
> > +       v = readq(base + FAB_CNTR);
> > +       count = FIELD_GET(FAB_CNTR_EVNT_CNTR, v);
> > +exit:
> > +       mutex_unlock(&pdata->lock);
> > +
> > +       return sprintf(buf, "0x%llx\n", (unsigned long long)count);
> > +}
> > +
> > +#define FAB_SHOW(name, event)                                          \
> > +static ssize_t name##_show(struct perf_object *pobj, char *buf)                \
> > +{                                                                      \
> > +       return read_fabric_counter(pobj, event, buf);                   \
> > +}                                                                      \
> > +static PERF_OBJ_ATTR_RO(name)
> > +
> > +FAB_SHOW(pcie0_read, FAB_EVNT_PCIE0_RD);
> > +FAB_SHOW(pcie0_write, FAB_EVNT_PCIE0_WR);
> > +FAB_SHOW(pcie1_read, FAB_EVNT_PCIE1_RD);
> > +FAB_SHOW(pcie1_write, FAB_EVNT_PCIE1_WR);
> > +FAB_SHOW(upi_read, FAB_EVNT_UPI_RD);
> > +FAB_SHOW(upi_write, FAB_EVNT_UPI_WR);
> > +FAB_SHOW(mmio_read, FAB_EVNT_MMIO_RD);
> > +FAB_SHOW(mmio_write, FAB_EVNT_MMIO_WR);
> > +
> > +static ssize_t fab_enable_show(struct perf_object *pobj, char *buf)
> > +{
> > +       return sprintf(buf, "%u\n",
> > +                      (unsigned int)!!fabric_pobj_is_enabled(pobj));
> > +}
> > +
> > +/*
> > + * If enable one port or all port event counter in fabric, other
> > + * fabric event counter originally enabled will be disable automatically.
> > + */
> > +static ssize_t fab_enable_store(struct perf_object *pobj,
> > +                               const char *buf, size_t n)
> > +{
> > +       struct dfl_feature *feature = pobj->feature;
> > +       struct dfl_feature_platform_data *pdata;
> > +       void __iomem *base = feature->ioaddr;
> > +       bool state;
> > +       u64 v;
> > +
> > +       if (strtobool(buf, &state) || !state)
> > +               return -EINVAL;
> > +
> > +       pdata = dev_get_platdata(&feature->pdev->dev);
> > +
> > +       /* if it is already enabled. */
> > +       if (fabric_pobj_is_enabled(pobj))
> > +               return n;
> > +
> > +       mutex_lock(&pdata->lock);
> > +       v = readq(base + FAB_CTRL);
> > +       v &= ~(FAB_PORT_FILTER | FAB_PORT_ID);
> > +
> > +       if (pobj->id == PERF_OBJ_ROOT_ID) {
> > +               v |= FIELD_PREP(FAB_PORT_FILTER, FAB_PORT_FILTER_DISABLE);
> > +       } else {
> > +               v |= FIELD_PREP(FAB_PORT_FILTER, FAB_PORT_FILTER_ENABLE);
> > +               v |= FIELD_PREP(FAB_PORT_ID, pobj->id);
> > +       }
> > +       writeq(v, base + FAB_CTRL);
> > +       mutex_unlock(&pdata->lock);
> > +
> > +       return n;
> > +}
> > +static PERF_OBJ_ATTR_F_RW(fab_enable, enable);
> > +
> > +static struct attribute *fabric_attrs[] = {
> > +       &perf_obj_attr_pcie0_read.attr,
> > +       &perf_obj_attr_pcie0_write.attr,
> > +       &perf_obj_attr_pcie1_read.attr,
> > +       &perf_obj_attr_pcie1_write.attr,
> > +       &perf_obj_attr_upi_read.attr,
> > +       &perf_obj_attr_upi_write.attr,
> > +       &perf_obj_attr_mmio_read.attr,
> > +       &perf_obj_attr_mmio_write.attr,
> > +       &perf_obj_attr_fab_enable.attr,
> > +       NULL,
> > +};
> > +
> > +static struct attribute_group fabric_attr_group = {
> > +       .attrs = fabric_attrs,
> > +};
> > +
> > +static const struct attribute_group *fabric_attr_groups[] = {
> > +       &fabric_attr_group,
> > +       NULL,
> > +};
> > +
> > +static ssize_t fab_freeze_show(struct perf_object *pobj, char *buf)
> > +{
> > +       void __iomem *base = pobj->feature->ioaddr;
> > +       u64 v;
> > +
> > +       v = readq(base + FAB_CTRL);
> > +
> > +       return sprintf(buf, "%u\n",
> > +                      (unsigned int)FIELD_GET(FAB_FREEZE_CNTR, v));
> > +}
> > +
> > +static ssize_t fab_freeze_store(struct perf_object *pobj,
> > +                               const char *buf, size_t n)
> > +{
> > +       struct dfl_feature *feature = pobj->feature;
> > +       struct dfl_feature_platform_data *pdata;
> > +       void __iomem *base = feature->ioaddr;
> > +       bool state;
> > +       u64 v;
> > +
> > +       if (strtobool(buf, &state))
> > +               return -EINVAL;
> > +
> > +       pdata = dev_get_platdata(&feature->pdev->dev);
> > +
> > +       mutex_lock(&pdata->lock);
> > +       v = readq(base + FAB_CTRL);
> > +       v &= ~FAB_FREEZE_CNTR;
> > +       v |= FIELD_PREP(FAB_FREEZE_CNTR, state ? 1 : 0);
> > +       writeq(v, base + FAB_CTRL);
> > +       mutex_unlock(&pdata->lock);
> > +
> > +       return n;
> > +}
> > +static PERF_OBJ_ATTR_F_RW(fab_freeze, freeze);
> > +
> > +static struct attribute *fabric_top_attrs[] = {
> > +       &perf_obj_attr_fab_freeze.attr,
> > +       NULL,
> > +};
> > +
> > +static struct attribute_group fabric_top_attr_group = {
> > +       .attrs = fabric_top_attrs,
> > +};
> > +
> > +static const struct attribute_group *fabric_top_attr_groups[] = {
> > +       &fabric_attr_group,
> > +       &fabric_top_attr_group,
> > +       NULL,
> > +};
> > +
> > +static int create_perf_fabric_obj(struct perf_object *perf_dev)
> > +{
> > +       struct perf_object *pobj, *obj;
> > +       int i;
> > +
> > +       pobj = create_perf_obj(perf_dev->feature, &perf_dev->kobj,
> > +                              PERF_OBJ_ROOT_ID, fabric_top_attr_groups,
> > +                              "fabric");
> > +       if (IS_ERR(pobj))
> > +               return PTR_ERR(pobj);
> > +
> > +       list_add(&pobj->node, &perf_dev->children);
> > +
> > +       for (i = 0; i < PERF_MAX_PORT_NUM; i++) {
> > +               obj = create_perf_obj(perf_dev->feature, &pobj->kobj, i,
> > +                                     fabric_attr_groups, "port");
> > +               if (IS_ERR(obj))
> > +                       return PTR_ERR(obj);
> > +
> > +               list_add(&obj->node, &pobj->children);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int fme_perf_init(struct platform_device *pdev,
> > +                        struct dfl_feature *feature)
> > +{
> > +       struct perf_object *perf_dev;
> > +       int ret;
> > +
> > +       perf_dev = create_perf_dev(feature);
> > +       if (IS_ERR(perf_dev))
> > +               return PTR_ERR(perf_dev);
> > +
> > +       ret = create_perf_fabric_obj(perf_dev);
> > +       if (ret)
> > +               goto done;
> > +
> > +       if (feature->id == FME_FEATURE_ID_GLOBAL_IPERF) {
> > +               /*
> > +                * Cache and IOMMU(VT-D) performance counters are not supported
> > +                * on discreted solutions e.g. Intel Programmable Acceleration
> > +                * Card based on PCIe.
> > +                */
> > +               ret = create_perf_cache_obj(perf_dev);
> > +               if (ret)
> > +                       goto done;
> > +
> > +               ret = create_perf_iommu_obj(perf_dev);
> > +               if (ret)
> > +                       goto done;
> > +       }
> > +
> > +       feature->priv = perf_dev;
> > +       return 0;
> > +
> > +done:
> > +       destroy_perf_obj(perf_dev);
> > +       return ret;
> > +}
> > +
> > +static void fme_perf_uinit(struct platform_device *pdev,
> > +                          struct dfl_feature *feature)
> > +{
> > +       struct perf_object *perf_dev = feature->priv;
> > +
> > +       destroy_perf_obj(perf_dev);
> > +}
> > +
> > +const struct dfl_feature_id fme_perf_id_table[] = {
> > +       {.id = FME_FEATURE_ID_GLOBAL_IPERF,},
> > +       {.id = FME_FEATURE_ID_GLOBAL_DPERF,},
> > +       {0,}
> > +};
> > +
> > +const struct dfl_feature_ops fme_perf_ops = {
> > +       .init = fme_perf_init,
> > +       .uinit = fme_perf_uinit,
> > +};
> > diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl-fme.h
> > index 5fbe3f5..dc71048 100644
> > --- a/drivers/fpga/dfl-fme.h
> > +++ b/drivers/fpga/dfl-fme.h
> > @@ -39,5 +39,7 @@ struct dfl_fme {
> >  extern const struct dfl_feature_id fme_pr_mgmt_id_table[];
> >  extern const struct dfl_feature_ops fme_global_err_ops;
> >  extern const struct dfl_feature_id fme_global_err_id_table[];
> > +extern const struct dfl_feature_ops fme_perf_ops;
> > +extern const struct dfl_feature_id fme_perf_id_table[];
> >
> >  #endif /* __DFL_FME_H */
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 1bb2b58..050b18b 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -521,6 +521,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
> >                 struct dfl_feature *feature = &pdata->features[index];
> >
> >                 /* save resource information for each feature */
> > +               feature->pdev = fdev;
> >                 feature->id = finfo->fid;
> >                 feature->resource_index = index;
> >                 feature->ioaddr = finfo->ioaddr;
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 6c32080..bf23436 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -191,6 +191,7 @@ struct dfl_feature_driver {
> >  /**
> >   * struct dfl_feature - sub feature of the feature devices
> >   *
> > + * @pdev: parent platform device.
> >   * @id: sub feature id.
> >   * @resource_index: each sub feature has one mmio resource for its registers.
> >   *                 this index is used to find its mmio resource from the
> > @@ -200,6 +201,7 @@ struct dfl_feature_driver {
> >   * @priv: priv data of this feature.
> >   */
> >  struct dfl_feature {
> > +       struct platform_device *pdev;
> >         u64 id;
> >         int resource_index;
> >         void __iomem *ioaddr;
> > --
> > 1.8.3.1
> >
