Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC372447A
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jun 2023 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbjFFNbB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jun 2023 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjFFNbB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jun 2023 09:31:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03ED690;
        Tue,  6 Jun 2023 06:31:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23E552F4;
        Tue,  6 Jun 2023 06:31:45 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C73CD3F793;
        Tue,  6 Jun 2023 06:30:55 -0700 (PDT)
Date:   Tue, 6 Jun 2023 14:30:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        yangyicong@hisilicon.com, linuxarm@huawei.com,
        Dan Williams <dan.j.williams@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Robert Richter <rric@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Frank Li <Frank.li@nxp.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
Subject: Re: [PATCH 01/32] perf: Allow a PMU to have a parent
Message-ID: <ZH81DC6xKSH6Tmc7@FVFF77S0Q05N.cambridge.arm.com>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
 <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
 <20230406111607.00007be5@Huawei.com>
 <20230406124040.GD392176@hirez.programming.kicks-ass.net>
 <20230406174445.0000235c@Huawei.com>
 <20230406194938.GB405948@hirez.programming.kicks-ass.net>
 <ZH8vUKt+iCF4M70d@FVFF77S0Q05N.cambridge.arm.com>
 <20230606131859.GC905437@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606131859.GC905437@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 06, 2023 at 03:18:59PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 06, 2023 at 02:06:24PM +0100, Mark Rutland wrote:
> > On Thu, Apr 06, 2023 at 09:49:38PM +0200, Peter Zijlstra wrote:
> > > On Thu, Apr 06, 2023 at 05:44:45PM +0100, Jonathan Cameron wrote:
> > > > On Thu, 6 Apr 2023 14:40:40 +0200
> > > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > > 
> > > > > On Thu, Apr 06, 2023 at 11:16:07AM +0100, Jonathan Cameron wrote:
> > > > > 
> > > > > > In the long run I agree it would be good.  Short term there are more instances of
> > > > > > struct pmu that don't have parents than those that do (even after this series).
> > > > > > We need to figure out what to do about those before adding checks on it being
> > > > > > set.  
> > > > > 
> > > > > Right, I don't think you've touched *any* of the x86 PMUs for example,
> > > > > and getting everybody that boots an x86 kernel a warning isn't going to
> > > > > go over well :-)
> > > > > 
> > > > 
> > > > It was tempting :) "Warning: Parentless PMU: try a different architecture."
> > > 
> > > Haha!
> > > 
> > > > I'd love some inputs on what the x86 PMU devices parents should be?
> > > > CPU counters in general tend to just spin out of deep in the architecture code.
> > > 
> > > For the 'simple' ones I suppose we can use the CPU device.
> > 
> > Uh, *which* CPU device? Do we have a container device for all CPUs?
> 
> drivers/base/cpu.c:per_cpu(cpu_sys_devices, cpu) for whatever the core
> pmu is for that cpu ?

... but the struct pmu covers several CPUs, so I don't have a single 'cpu', no?

If I have a system where cpu{0,1,2} are Cortex-A53 and cpu{3,4} are Cortex-A57,
I have two struct pmu instances, each associated with several CPUs. When I
probe each of those I determine a cpumask for each.

> > > > My overall favorite is an l2 cache related PMU that is spun up in
> > > > arch/arm/kernel/irq.c init_IRQ()
> > 
> > That's an artifact of the L2 cache controller driver getting initialized there;
> > ideally we'd have a device for the L2 cache itself (which presumably should
> > hang off an aggregate CPU device).
> 
> /sys/devices/system/cpu/cpuN/cache/indexM
> 
> has a struct device somewhere in
> drivers/base/cacheinfo.c:ci_index_dev or somesuch.

I guess, but I don't think the L2 cache controller (the PL310) is actually tied
to that today.

> > > Yeah, we're going to have a ton of them as well. Some of them are PCI
> > > devices and have a clear parent, others, not so much :/
> > 
> > In a number of places the only thing we have is the PMU driver, and we don't
> > have a driver (or device) for the HW block it's a part of. Largely that's
> > interconnect PMUs; we could create container devices there.
> 
> Dont they have a PCI device? But yeah, some are going to be a wee bit
> challenging.

The system might not even have PCI, so it's arguable that they should just hang
off an MMIO bus (which is effectively what the platofrm bus is).

Thanks,
Mark.
