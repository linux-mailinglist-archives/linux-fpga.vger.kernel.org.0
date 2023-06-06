Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF487244E0
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jun 2023 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbjFFNtP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jun 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjFFNtK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jun 2023 09:49:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B836171B;
        Tue,  6 Jun 2023 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BMO3vzKI3m2FfarKgPXXpyyTe374r9CnvP3CDKmIZ2w=; b=LFT4wirT6n5asLusMNX6C2gEfO
        PNq3VnIYRH/o4EX2w4oNeii1RqV6c7tp79oa5wYcg2sg4nLr4lVUbYDBAmoMRhqeUMg1WmhfVyWuC
        0bLKHtV7z5fE6UWk/D3mNGVvlRshwyPbeCwXnQsi5bXZQ1L7qmIrSwXI6qAko46LXuLePOPfpx/Cd
        Nb7LxsIRTtuTOh2rVhFe8ohZ1BR8e3h6T578KIcUpaJpMa4T3P0qLGRgMJeMv10JbzXe/WYZzXbls
        2yU2lTTg7b0SK3r6+IlcKsVZYJufCNrKpmClJBzV/E/5vQwRcUy0l+pmoaCeAswmWqKCx6NSCWeUP
        fwvBdW7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6X2p-00DCLm-Vq; Tue, 06 Jun 2023 13:48:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85DC9300129;
        Tue,  6 Jun 2023 15:48:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67A7420DC35AB; Tue,  6 Jun 2023 15:48:16 +0200 (CEST)
Date:   Tue, 6 Jun 2023 15:48:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <20230606134816.GF905437@hirez.programming.kicks-ass.net>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
 <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
 <20230406111607.00007be5@Huawei.com>
 <20230406124040.GD392176@hirez.programming.kicks-ass.net>
 <20230406174445.0000235c@Huawei.com>
 <20230406194938.GB405948@hirez.programming.kicks-ass.net>
 <ZH8vUKt+iCF4M70d@FVFF77S0Q05N.cambridge.arm.com>
 <20230606131859.GC905437@hirez.programming.kicks-ass.net>
 <ZH81DC6xKSH6Tmc7@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH81DC6xKSH6Tmc7@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 06, 2023 at 02:30:52PM +0100, Mark Rutland wrote:

> > > Uh, *which* CPU device? Do we have a container device for all CPUs?
> > 
> > drivers/base/cpu.c:per_cpu(cpu_sys_devices, cpu) for whatever the core
> > pmu is for that cpu ?
> 
> ... but the struct pmu covers several CPUs, so I don't have a single 'cpu', no?
> 
> If I have a system where cpu{0,1,2} are Cortex-A53 and cpu{3,4} are Cortex-A57,
> I have two struct pmu instances, each associated with several CPUs. When I
> probe each of those I determine a cpumask for each.

Bah :/ Clearly I overlooked the disparity there.

> > > > > My overall favorite is an l2 cache related PMU that is spun up in
> > > > > arch/arm/kernel/irq.c init_IRQ()
> > > 
> > > That's an artifact of the L2 cache controller driver getting initialized there;
> > > ideally we'd have a device for the L2 cache itself (which presumably should
> > > hang off an aggregate CPU device).
> > 
> > /sys/devices/system/cpu/cpuN/cache/indexM
> > 
> > has a struct device somewhere in
> > drivers/base/cacheinfo.c:ci_index_dev or somesuch.
> 
> I guess, but I don't think the L2 cache controller (the PL310) is actually tied
> to that today.

All it would do is make fancy links in sysfs I think, who cares ;-)

> > > > Yeah, we're going to have a ton of them as well. Some of them are PCI
> > > > devices and have a clear parent, others, not so much :/
> > > 
> > > In a number of places the only thing we have is the PMU driver, and we don't
> > > have a driver (or device) for the HW block it's a part of. Largely that's
> > > interconnect PMUs; we could create container devices there.
> > 
> > Dont they have a PCI device? But yeah, some are going to be a wee bit
> > challenging.
> 
> The system might not even have PCI, so it's arguable that they should just hang
> off an MMIO bus (which is effectively what the platofrm bus is).

You and your dodgy platforms :-)
