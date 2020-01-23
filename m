Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3871460B4
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Jan 2020 03:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAWC0U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Jan 2020 21:26:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:21435 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgAWC0U (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 22 Jan 2020 21:26:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 18:26:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,352,1574150400"; 
   d="scan'208";a="427615570"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jan 2020 18:26:17 -0800
Date:   Thu, 23 Jan 2020 10:05:56 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     will@kernel.org, mdf@kernel.org, mark.rutland@arm.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, atull@kernel.org,
        Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [RESEND Patch v6 2/2] fpga: dfl: fme: add performance reporting
 support
Message-ID: <20200123020556.GA9716@hao-dev>
References: <1579230628-22243-1-git-send-email-hao.wu@intel.com>
 <1579230628-22243-3-git-send-email-hao.wu@intel.com>
 <20200122141026.GA10399@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122141026.GA10399@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jan 22, 2020 at 03:10:26PM +0100, Greg KH wrote:
> On Fri, Jan 17, 2020 at 11:10:28AM +0800, Wu Hao wrote:
> > +static const struct attribute_group fme_perf_fabric_events_group = {
> > +	.name = "events",
> > +	.attrs = fme_perf_fabric_events_attrs,
> > +	.is_visible = fme_perf_fabric_events_visible,
> > +};
> > +
> 
> I don't see any Documentation/ABI/ entries for all of these new files.
> Please properly document them so we know how to review this.

Hi Greg,

Thanks a lot for the review. Actually all the sysfs entries under events
are perf monitoring events following the same format documented in 
"Documentation/ABI/testing/sysfs-bus-event_source-devices-events" and
we added some description in our fpga documentation in patch #1.

Yes, I can add something in ABI directly as well in the next version.
I pasted related descriptions below. I hope this won't block review.

Thank you very much!
Hao


From Documentation/ABI/testing/sysfs-bus-event_source-devices-events

What: /sys/bus/event_source/devices/<pmu>/events/<event>
Date: 2014/02/24
Contact:        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Description:    Per-pmu performance monitoring events specific to the running system

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

From Documentation/fpga/dfl.rst added by patch #1.

"
The "events" directory describes the configuration templates for all available
events which can be used with perf tool directly. For example, fab_mmio_read
has the configuration "event=0x06,evtype=0x02,portid=0xff", which shows this
event belongs to fabric type (0x02), the local event id is 0x06 and it is for
overall monitoring (portid=0xff).
"

> 
> thanks,
> 
> greg k-h
