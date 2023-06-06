Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE14E72443A
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jun 2023 15:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbjFFNUK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jun 2023 09:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbjFFNUE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jun 2023 09:20:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD88126;
        Tue,  6 Jun 2023 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bOhJdpV+N76h1R0HV0En0Yvx5H3tbVSO6kPEgHFAnxI=; b=Id0Z7UFiOxF+fvDn9K3Pf7MPru
        VGmMYzWYhTR0sLrVm5XzlG+3N8z8M4G+B8jdt55BqvGpRWHAJwesO2f7TVZQQip+ayH0Gc6pXRf2m
        Sdm0pg6BXS4GXcYpiKXqyz78x9b3fu6uJfyhPELsxvgb+uHXtg7eI1FY+iecu2lGYIDSrx7GJQKye
        a37q7ElCkHjHTfM6A19s67vVKD8i01BThzKCeXr7krxisKSMOuIS5hC2Omj4EIRomGU+1wD/sNBZL
        xDKjrxVeric6OSUW6MjK3uMK1mtDavlyBCDiGqNUQhr5sdT5JDjUdz4/nejY9k9CE84dn85nTRyFf
        duKixrNQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6WaX-0046Rl-2j;
        Tue, 06 Jun 2023 13:19:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 974F4300188;
        Tue,  6 Jun 2023 15:18:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72FED20D72195; Tue,  6 Jun 2023 15:18:59 +0200 (CEST)
Date:   Tue, 6 Jun 2023 15:18:59 +0200
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
Message-ID: <20230606131859.GC905437@hirez.programming.kicks-ass.net>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
 <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
 <20230406111607.00007be5@Huawei.com>
 <20230406124040.GD392176@hirez.programming.kicks-ass.net>
 <20230406174445.0000235c@Huawei.com>
 <20230406194938.GB405948@hirez.programming.kicks-ass.net>
 <ZH8vUKt+iCF4M70d@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH8vUKt+iCF4M70d@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 06, 2023 at 02:06:24PM +0100, Mark Rutland wrote:
> On Thu, Apr 06, 2023 at 09:49:38PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 06, 2023 at 05:44:45PM +0100, Jonathan Cameron wrote:
> > > On Thu, 6 Apr 2023 14:40:40 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > On Thu, Apr 06, 2023 at 11:16:07AM +0100, Jonathan Cameron wrote:
> > > > 
> > > > > In the long run I agree it would be good.  Short term there are more instances of
> > > > > struct pmu that don't have parents than those that do (even after this series).
> > > > > We need to figure out what to do about those before adding checks on it being
> > > > > set.  
> > > > 
> > > > Right, I don't think you've touched *any* of the x86 PMUs for example,
> > > > and getting everybody that boots an x86 kernel a warning isn't going to
> > > > go over well :-)
> > > > 
> > > 
> > > It was tempting :) "Warning: Parentless PMU: try a different architecture."
> > 
> > Haha!
> > 
> > > I'd love some inputs on what the x86 PMU devices parents should be?
> > > CPU counters in general tend to just spin out of deep in the architecture code.
> > 
> > For the 'simple' ones I suppose we can use the CPU device.
> 
> Uh, *which* CPU device? Do we have a container device for all CPUs?

drivers/base/cpu.c:per_cpu(cpu_sys_devices, cpu) for whatever the core
pmu is for that cpu ?

> > > My overall favorite is an l2 cache related PMU that is spun up in
> > > arch/arm/kernel/irq.c init_IRQ()
> 
> That's an artifact of the L2 cache controller driver getting initialized there;
> ideally we'd have a device for the L2 cache itself (which presumably should
> hang off an aggregate CPU device).

/sys/devices/system/cpu/cpuN/cache/indexM

has a struct device somewhere in
drivers/base/cacheinfo.c:ci_index_dev or somesuch.

> > Yeah, we're going to have a ton of them as well. Some of them are PCI
> > devices and have a clear parent, others, not so much :/
> 
> In a number of places the only thing we have is the PMU driver, and we don't
> have a driver (or device) for the HW block it's a part of. Largely that's
> interconnect PMUs; we could create container devices there.

Dont they have a PCI device? But yeah, some are going to be a wee bit
challenging.
