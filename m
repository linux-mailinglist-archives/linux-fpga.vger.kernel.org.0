Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0BAA159F5F
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2020 04:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBLC76 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Feb 2020 21:59:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:4514 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbgBLC76 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 Feb 2020 21:59:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 18:59:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="226681713"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2020 18:59:55 -0800
Date:   Wed, 12 Feb 2020 10:39:13 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, will@kernel.org, mark.rutland@arm.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v7 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20200212023913.GA5645@hao-dev>
References: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
 <1581306469-22629-3-git-send-email-hao.wu@intel.com>
 <20200210205618.GA1347752@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210205618.GA1347752@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 10, 2020 at 12:56:18PM -0800, Greg KH wrote:
> On Mon, Feb 10, 2020 at 11:47:49AM +0800, Wu Hao wrote:
> > +What:		/sys/bus/event_source/devices/fmeX/format
> > +Date:		February 2020
> > +KernelVersion:  5.7
> > +Contact:	Wu Hao <hao.wu@intel.com>
> > +Description:	Read-only. Attribute group to describe the magic bits
> > +		that go into perf_event_attr.config for a particular pmu.
> > +		(See ABI/testing/sysfs-bus-event_source-devices-format).
> > +
> > +		Each attribute under this group defines a bit range of the
> > +		perf_event_attr.config. All supported attributes are listed
> > +		below.
> > +
> > +		  event  = "config:0-11"  - event ID
> > +		  evtype = "config:12-15" - event type
> > +		  portid = "config:16-23" - event source
> > +
> > +		For example,
> > +
> > +		  fab_mmio_read = "event=0x06,evtype=0x02,portid=0xff"
> 
> Are perf sysfs files always this bad "multiple values per file"?  Or is
> that unique to this driver?  If not unique, do you have specific
> examples in the kernel that currently do this today?

Hi Greg,

Thanks a lot for the review. : )

Perf sysfs files allow this kind of output, so some perf drivers are using
the similar format for their jobs.

Examples from my machine.

 # cat /sys/bus/event_source/devices/cpu/events/cycles-ct
 event=0x3c,in_tx=1,in_tx_cp=1
 # cat /sys/bus/event_source/devices/cpu/events/el-start
 event=0xc8,umask=0x1
 # cat /sys/bus/event_source/devices/cpu/events/instructions
 event=0xc0
 # cat /sys/bus/event_source/devices/cpu/events/branch-instructions
 event=0xc4

See arch/x86/events/intel/core.c

 EVENT_ATTR_STR(cycles-ct, cycles_ct, "event=0x3c,in_tx=1,in_tx_cp=1");
 ...

And descriptions/examples from ABI/testing/sysfs-bus-event_source-devices-events

What: /sys/bus/event_source/devices/<pmu>/events/<event>
Date: 2014/02/24
Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Description:	Per-pmu performance monitoring events specific to the running system

		Each file (except for some of those with a '.' in them, '.unit'
		and '.scale') in the 'events' directory describes a single
		performance monitoring event supported by the <pmu>. The name
		of the file is the name of the event.

		File contents:

			<term>[=<value>][,<term>[=<value>]]...

		Where <term> is one of the terms listed under
		/sys/bus/event_source/devices/<pmu>/format/ and <value> is
		a number is base-16 format with a '0x' prefix (lowercase only).
		If a <term> is specified alone (without an assigned value), it
		is implied that 0x1 is assigned to that <term>.

		Examples (each of these lines would be in a seperate file):

			event=0x2abc
			event=0x423,inv,cmask=0x3
			domain=0x1,offset=0x8,starting_index=0xffff
			domain=0x1,offset=0x8,core=?

		Each of the assignments indicates a value to be assigned to a
		particular set of bits (as defined by the format file
		corresponding to the <term>) in the perf_event structure passed
		to the perf_open syscall.

		In the case of the last example, a value replacing "?" would
		need to be provided by the user selecting the particular event.
		This is referred to as "event parameterization". Event
		parameters have the format 'param=?'.

So this is not something new introduced by this patch.

> 
> 
> > +static struct attribute *fme_perf_events_attrs_empty[] = {
> > +	NULL,
> 
> Huh?
> 
> > +};
> > +
> > +static struct attribute_group fme_perf_events_group = {
> > +	.name = "events",
> > +	.attrs = fme_perf_events_attrs_empty,
> 
> You create an empty directory?  Why?  What goes in here?
> 
> very odd...

Actually events are filled into this "events" from several different groups
via pmu->attr_update[1].

	pmu->attr_update =      fme_perf_events_groups;

pmu->attr_update allows us to update "events" directories with attributes that
depend on various HW conditions. In our case, several different groups with
different is_visible functions are filled into "events" using this method.
And several existing pmu drivers (e.g. arch/x86/events/intel/cstate.c) are
using the same way (having an empty directory first and update it using
pmu->attr_update).

But I have to admit that I should add some comments there to avoid confusion,
sorry, will do that in the next version.

[1] https://lkml.org/lkml/2019/5/4/188

Thanks
Hao

> 
> greg k-h
