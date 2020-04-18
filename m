Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710FC1AE8DF
	for <lists+linux-fpga@lfdr.de>; Sat, 18 Apr 2020 02:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDRAHz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Apr 2020 20:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgDRAHz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Apr 2020 20:07:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B9CC061A0C;
        Fri, 17 Apr 2020 17:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=g7qIA0lLgeeVqD3PfI2pPtZA8QSfsmbToQePnx+kR8E=; b=R001cq9K2VwF9GpezA1XeQZCXt
        qlCdBWjL6l4sppvk1SwlVTp/sjzhp7xvcovIOdzbdesWoCa5KzrB6PiWPoAv6j9TdbI1NO2IjAo06
        Dc5ftSN6I75E71l11fJQ77CuMpmQMeGvhJD+nDGjmB3ODIyEi/MBH0LVgBUWLqt4Ez/T94EPonLcV
        Zq24+fRobNqoe1SC3QesG5gEGCTYl2/9KCSBaeyHyNZ7ek/713yix8IrYtDO/hUJgMGLqbMh2i4Z2
        WvW60r3wj/w0Mh7D0SnPyL/Ge4A5GOu5H5WW2Tir3JaDeTmUdnRp2uRcR+0eokqhmOUWuyBKC9ZKF
        i5FUlW+A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPb1P-00054S-7K; Sat, 18 Apr 2020 00:07:47 +0000
Subject: Re: [PATCH v9 1/2] Documentation: fpga: dfl: add description for
 performance reporting support
To:     Wu Hao <hao.wu@intel.com>, will@kernel.org, mdf@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com,
        trix@redhat.com, bhu@redhat.com
References: <1587102000-18262-1-git-send-email-hao.wu@intel.com>
 <1587102000-18262-2-git-send-email-hao.wu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8aa60f7e-68d4-ca41-403f-37f430ce05c1@infradead.org>
Date:   Fri, 17 Apr 2020 17:07:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587102000-18262-2-git-send-email-hao.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi--

Here are a few comments for you:

On 4/16/20 10:39 PM, Wu Hao wrote:
> From: Xu Yilun <yilun.xu@intel.com>
> 
> This patch adds description for performance reporting support for
> Device Feature List (DFL) based FPGA.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  Documentation/fpga/dfl.rst | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 094fc8a..6ccaf77 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst

> @@ -378,6 +383,85 @@ The device nodes used for ioctl() or mmap() can be referenced through::
>  	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
>  
>  
> +Performance Counters
> +====================
> +Performance reporting is one private feature implemented in FME. It could
> +supports several independent, system-wide, device counter sets in hardware to
> +monitor and count for performance events, including "basic", "cache", "fabric",
> +"vtd" and "vtd_sip" counters. Users could use standard perf tool to monitor
> +FPGA cache hit/miss rate, transaction number, interface clock counter of AFU
> +and other FPGA performance events.
> +
> +Different FPGA devices may have different counter sets, it depends on hardware

                                                     sets, depending on hardware

> +implementation. e.g. some discrete FPGA cards don't have any cache. User could

                   E.g., some

> +use "perf list" to check which perf events are supported by target hardware.
> +
> +In order to allow user to use standard perf API to access these performance
> +counters, driver creates a perf PMU, and related sysfs interfaces in
> +/sys/bus/event_source/devices/dfl_fme* to describe available perf events and
> +configuration options.
> +
> +The "format" directory describes the format of the config field of struct
> +perf_event_attr. There are 3 bitfields for config, "evtype" defines which type

                                              config: "evtype"

> +the perf event belongs to. "event" is the identity of the event within its

                  belongs to; "event" is

> +category. "portid" is introduced to decide counters set to monitor on FPGA

   category; "portid" is

> +overall data or a specific port.
> +
> +The "events" directory describes the configuration templates for all available
> +events which can be used with perf tool directly. For example, fab_mmio_read
> +has the configuration "event=0x06,evtype=0x02,portid=0xff", which shows this
> +event belongs to fabric type (0x02), the local event id is 0x06 and it is for
> +overall monitoring (portid=0xff).
> +
> +Example usage of perf::
> +
> +  $# perf list |grep dfl_fme
> +
> +  dfl_fme0/fab_mmio_read/                              [Kernel PMU event]
> +  <...>
> +  dfl_fme0/fab_port_mmio_read,portid=?/                [Kernel PMU event]
> +  <...>
> +
> +  $# perf stat -a -e dfl_fme0/fab_mmio_read/ <command>
> +  or
> +  $# perf stat -a -e dfl_fme0/event=0x06,evtype=0x02,portid=0xff/ <command>
> +  or
> +  $# perf stat -a -e dfl_fme0/config=0xff2006/ <command>
> +
> +Another example, fab_port_mmio_read monitors mmio read of a specific port. So
> +its configuration template is "event=0x06,evtype=0x01,portid=?". The portid
> +should be explicitly set.
> +
> +Its usage of perf::
> +
> +  $# perf stat -a -e dfl_fme0/fab_port_mmio_read,portid=0x0/ <command>
> +  or
> +  $# perf stat -a -e dfl_fme0/event=0x06,evtype=0x02,portid=0x0/ <command>
> +  or
> +  $# perf stat -a -e dfl_fme0/config=0x2006/ <command>
> +
> +Please note for fabric counters, overall perf events (fab_*) and port perf
> +events (fab_port_*) actually share one set of counters in hardware, so it can't
> +monitor both at the same time. If this set of counters is configured to monitor
> +overall data, then per port perf data is not supported. See below example::
> +
> +  $# perf stat -e dfl_fme0/fab_mmio_read/,dfl_fme0/fab_port_mmio_write,\
> +                                                    portid=0/ sleep 1
> +
> +  Performance counter stats for 'system wide':
> +
> +                 3      dfl_fme0/fab_mmio_read/
> +   <not supported>      dfl_fme0/fab_port_mmio_write,portid=0x0/
> +
> +       1.001750904 seconds time elapsed
> +
> +The driver also provides a "cpumask" sysfs attribute, which contains only one
> +cpu id used to access these perf events. Counting on multiple CPUs is not
   CPU

> +allowed since they are system-wide counters on FPGA device.
> +
> +The current driver does not support sampling. So "perf record" is unsupported.
> +
> +
>  Add new FIUs support
>  ====================
>  It's possible that developers made some new function blocks (FIUs) under this
> 

thanks.
-- 
~Randy

