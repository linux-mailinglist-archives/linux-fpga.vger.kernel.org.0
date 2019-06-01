Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0631AF9
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Jun 2019 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfFAJ2I (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 1 Jun 2019 05:28:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:12557 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfFAJ2I (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 1 Jun 2019 05:28:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jun 2019 02:28:07 -0700
X-ExtLoop1: 1
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jun 2019 02:28:05 -0700
Date:   Sat, 1 Jun 2019 17:11:47 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 16/16] fpga: dfl: fme: add performance reporting
 support
Message-ID: <20190601091147.GB3743@hao-dev>
References: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
 <1558934546-12171-17-git-send-email-hao.wu@intel.com>
 <20190530190305.GA2909@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190530190305.GA2909@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 30, 2019 at 12:03:05PM -0700, Greg KH wrote:
> On Mon, May 27, 2019 at 01:22:26PM +0800, Wu Hao wrote:
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
> > +#define CACHE_CTRL			0x8
> > +#define CACHE_RESET_CNTR		BIT_ULL(0)
> > +#define CACHE_FREEZE_CNTR		BIT_ULL(8)
> > +#define CACHE_CTRL_EVNT			GENMASK_ULL(19, 16)
> > +#define CACHE_EVNT_RD_HIT		0x0
> > +#define CACHE_EVNT_WR_HIT		0x1
> > +#define CACHE_EVNT_RD_MISS		0x2
> > +#define CACHE_EVNT_WR_MISS		0x3
> > +#define CACHE_EVNT_RSVD			0x4
> > +#define CACHE_EVNT_HOLD_REQ		0x5
> > +#define CACHE_EVNT_DATA_WR_PORT_CONTEN	0x6
> > +#define CACHE_EVNT_TAG_WR_PORT_CONTEN	0x7
> > +#define CACHE_EVNT_TX_REQ_STALL		0x8
> > +#define CACHE_EVNT_RX_REQ_STALL		0x9
> > +#define CACHE_EVNT_EVICTIONS		0xa
> > +#define CACHE_EVNT_MAX			CACHE_EVNT_EVICTIONS
> > +#define CACHE_CHANNEL_SEL		BIT_ULL(20)
> > +#define CACHE_CHANNEL_RD		0
> > +#define CACHE_CHANNEL_WR		1
> > +#define CACHE_CHANNEL_MAX		2
> > +#define CACHE_CNTR0			0x10
> > +#define CACHE_CNTR1			0x18
> > +#define CACHE_CNTR_EVNT_CNTR		GENMASK_ULL(47, 0)
> > +#define CACHE_CNTR_EVNT			GENMASK_ULL(63, 60)
> > +
> > +/*
> > + * Performance Counter Registers for Fabric.
> > + *
> > + * Fabric Events are listed below as FAB_EVNT_*
> > + */
> > +#define FAB_CTRL			0x20
> > +#define FAB_RESET_CNTR			BIT_ULL(0)
> > +#define FAB_FREEZE_CNTR			BIT_ULL(8)
> > +#define FAB_CTRL_EVNT			GENMASK_ULL(19, 16)
> > +#define FAB_EVNT_PCIE0_RD		0x0
> > +#define FAB_EVNT_PCIE0_WR		0x1
> > +#define FAB_EVNT_PCIE1_RD		0x2
> > +#define FAB_EVNT_PCIE1_WR		0x3
> > +#define FAB_EVNT_UPI_RD			0x4
> > +#define FAB_EVNT_UPI_WR			0x5
> > +#define FAB_EVNT_MMIO_RD		0x6
> > +#define FAB_EVNT_MMIO_WR		0x7
> > +#define FAB_EVNT_MAX			FAB_EVNT_MMIO_WR
> > +#define FAB_PORT_ID			GENMASK_ULL(21, 20)
> > +#define FAB_PORT_FILTER			BIT_ULL(23)
> > +#define FAB_PORT_FILTER_DISABLE		0
> > +#define FAB_PORT_FILTER_ENABLE		1
> > +#define FAB_CNTR			0x28
> > +#define FAB_CNTR_EVNT_CNTR		GENMASK_ULL(59, 0)
> > +#define FAB_CNTR_EVNT			GENMASK_ULL(63, 60)
> > +
> > +/*
> > + * Performance Counter Registers for Clock.
> > + *
> > + * Clock Counter can't be reset or frozen by SW.
> > + */
> > +#define CLK_CNTR			0x30
> > +
> > +/*
> > + * Performance Counter Registers for IOMMU / VT-D.
> > + *
> > + * VT-D Events are listed below as VTD_EVNT_* and VTD_SIP_EVNT_*
> > + */
> > +#define VTD_CTRL			0x38
> > +#define VTD_RESET_CNTR			BIT_ULL(0)
> > +#define VTD_FREEZE_CNTR			BIT_ULL(8)
> > +#define VTD_CTRL_EVNT			GENMASK_ULL(19, 16)
> > +#define VTD_EVNT_AFU_MEM_RD_TRANS	0x0
> > +#define VTD_EVNT_AFU_MEM_WR_TRANS	0x1
> > +#define VTD_EVNT_AFU_DEVTLB_RD_HIT	0x2
> > +#define VTD_EVNT_AFU_DEVTLB_WR_HIT	0x3
> > +#define VTD_EVNT_DEVTLB_4K_FILL		0x4
> > +#define VTD_EVNT_DEVTLB_2M_FILL		0x5
> > +#define VTD_EVNT_DEVTLB_1G_FILL		0x6
> > +#define VTD_EVNT_MAX			VTD_EVNT_DEVTLB_1G_FILL
> > +#define VTD_CNTR			0x40
> > +#define VTD_CNTR_EVNT			GENMASK_ULL(63, 60)
> > +#define VTD_CNTR_EVNT_CNTR		GENMASK_ULL(47, 0)
> > +#define VTD_SIP_CTRL			0x48
> > +#define VTD_SIP_RESET_CNTR		BIT_ULL(0)
> > +#define VTD_SIP_FREEZE_CNTR		BIT_ULL(8)
> > +#define VTD_SIP_CTRL_EVNT		GENMASK_ULL(19, 16)
> > +#define VTD_SIP_EVNT_IOTLB_4K_HIT	0x0
> > +#define VTD_SIP_EVNT_IOTLB_2M_HIT	0x1
> > +#define VTD_SIP_EVNT_IOTLB_1G_HIT	0x2
> > +#define VTD_SIP_EVNT_SLPWC_L3_HIT	0x3
> > +#define VTD_SIP_EVNT_SLPWC_L4_HIT	0x4
> > +#define VTD_SIP_EVNT_RCC_HIT		0x5
> > +#define VTD_SIP_EVNT_IOTLB_4K_MISS	0x6
> > +#define VTD_SIP_EVNT_IOTLB_2M_MISS	0x7
> > +#define VTD_SIP_EVNT_IOTLB_1G_MISS	0x8
> > +#define VTD_SIP_EVNT_SLPWC_L3_MISS	0x9
> > +#define VTD_SIP_EVNT_SLPWC_L4_MISS	0xa
> > +#define VTD_SIP_EVNT_RCC_MISS		0xb
> > +#define VTD_SIP_EVNT_MAX		VTD_SIP_EVNT_RCC_MISS
> > +#define VTD_SIP_CNTR			0X50
> > +#define VTD_SIP_CNTR_EVNT		GENMASK_ULL(63, 60)
> > +#define VTD_SIP_CNTR_EVNT_CNTR		GENMASK_ULL(47, 0)
> > +
> > +#define PERF_OBJ_ROOT_ID		(~0)
> > +
> > +#define PERF_TIMEOUT			30
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
> > +	int id;
> > +	const struct attribute_group **attr_groups;
> > +	struct dfl_feature *feature;
> > +
> > +	struct list_head node;
> > +	struct list_head children;
> > +	struct kobject kobj;
> 
> Woah, why are you using a "raw" kobject and not a 'struct device' here?
> You just broke userspace and no libraries will see your kobject's
> properties as the "chain" of struct devices is not happening anymore.
> 
> Why can this not just be a 'struct device'?

Hi Greg,

Many thanks for the review and comments.

Actually we are just trying to create sysfs hierarchy for performance
counters using these data structures.

If we use 'struct device' instead of kobject, then we have to let userspace
code to deal with device's sysfs (e.g. ignore 'uevent' below). This is the
only concern from my side now, as I know that using 'struct device'
saves code as we don't need to introduce a new perf_obj_attribute then.

dfl-fme.0/perf/
 ├── iommu
 │   ├── afu0
 │   │   ├── devtlb_1g_fill
 │   │   ├── devtlb_2m_fill
 │   │   ├── devtlb_4k_fill
 │   │   ├── devtlb_read_hit
 │   │   ├── devtlb_write_hit
 │   │   ├── read_transaction
 │   │   ├── uevent
 │   │   └── write_transaction
 │   ├── freeze
 │   ├── iotlb_1g_hit
 │   ├── iotlb_1g_miss
	 ...
     └── uevent
 ...

Do you think if we could keep it or it's better to use 'struct device'?

> 
> 
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
> > +	struct attribute attr;
> > +	ssize_t (*show)(struct perf_object *pobj, char *buf);
> > +	ssize_t (*store)(struct perf_object *pobj,
> > +			 const char *buf, size_t n);
> > +};
> > +
> > +#define to_perf_obj_attr(_attr)					\
> > +		container_of(_attr, struct perf_obj_attribute, attr)
> > +#define to_perf_obj(_kobj)					\
> > +		container_of(_kobj, struct perf_object, kobj)
> > +
> > +#define __POBJ_ATTR(_name, _mode, _show, _store) {			\
> > +	.attr = {.name = __stringify(_name),				\
> > +		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
> > +	.show   = _show,						\
> > +	.store  = _store,						\
> > +}
> > +
> > +#define PERF_OBJ_ATTR_F_RO(_name, _filename)				\
> > +struct perf_obj_attribute perf_obj_attr_##_name =			\
> > +	__POBJ_ATTR(_filename, 0444, _name##_show, NULL)
> > +
> > +#define PERF_OBJ_ATTR_F_WO(_name, _filename)				\
> > +struct perf_obj_attribute perf_obj_attr_##_name =			\
> > +	__POBJ_ATTR(_filename, 0200, NULL, _name##_store)
> > +
> > +#define PERF_OBJ_ATTR_F_RW(_name, _filename)				\
> > +struct perf_obj_attribute perf_obj_attr_##_name =			\
> > +	__POBJ_ATTR(_filename, 0644, _name##_show, _name##_store)
> > +
> > +#define PERF_OBJ_ATTR_RO(_name)						\
> > +struct perf_obj_attribute perf_obj_attr_##_name =			\
> > +	__POBJ_ATTR(_name, 0444, _name##_show, NULL)
> > +
> > +#define PERF_OBJ_ATTR_WO(_name)						\
> > +struct perf_obj_attribute perf_obj_attr_##_name =			\
> > +	__POBJ_ATTR(_name, 0200, NULL, _name##_store)
> > +
> > +#define PERF_OBJ_ATTR_RW(_name)						\
> > +struct perf_obj_attribute perf_obj_attr_##_name =			\
> > +	__POBJ_ATTR(_name, 0644, _name##_show, _name##_store)
> 
> When you have to roll your own sysfs attributes for a single driver,
> that is a HUGE hint you are doing something wrong.  No driver for an
> individual device should EVER have to do this.
> 
> Please use the driver core properly and do not route around it.

Sure. Thanks!

Hao

> 
> thanks,
> 
> greg k-h
