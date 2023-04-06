Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151CC6DA201
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Apr 2023 21:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbjDFTul (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Apr 2023 15:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237372AbjDFTuk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Apr 2023 15:50:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D819F;
        Thu,  6 Apr 2023 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DmGtZh90fpEw0TretC9nRQhMQvDnjMB5G00Z5+VRCJQ=; b=L08PtDFWYx1ukCT2pPv1pyufFB
        S/61aVSjNkOOM63Ny2OG1fCAj6zQtUgcmDOgAM7d/jq+jgX65UTy81ClnAelmLd3S4kGYc9kzqv/w
        xkfUcb9SJhyrS0FBk7obbDWej4fKjzqX6WD/OvBKrhMpoIqb8Cx6yaS+3MhLLswoPbfukR+FyKKXs
        jn+wrwG897iS2qDRIfcoB9rKEFxKxSH/lhbpeqGJ3TElnk0N6SbjGnywb/yqyfslxVOnQjzWZpZvD
        2GRC0D3Td2KCUPT8fYFu3xAbrYgwNBNU8rKxZCLpPm3NgBvL0QAk0N0x4zEdCWgLaQ+WGbXH8xXtk
        EZYiUzrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkVc7-00073v-2j; Thu, 06 Apr 2023 19:49:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CA09300202;
        Thu,  6 Apr 2023 21:49:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC4D32625225B; Thu,  6 Apr 2023 21:49:38 +0200 (CEST)
Date:   Thu, 6 Apr 2023 21:49:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20230406194938.GB405948@hirez.programming.kicks-ass.net>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
 <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
 <20230406111607.00007be5@Huawei.com>
 <20230406124040.GD392176@hirez.programming.kicks-ass.net>
 <20230406174445.0000235c@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406174445.0000235c@Huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 06, 2023 at 05:44:45PM +0100, Jonathan Cameron wrote:
> On Thu, 6 Apr 2023 14:40:40 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Apr 06, 2023 at 11:16:07AM +0100, Jonathan Cameron wrote:
> > 
> > > In the long run I agree it would be good.  Short term there are more instances of
> > > struct pmu that don't have parents than those that do (even after this series).
> > > We need to figure out what to do about those before adding checks on it being
> > > set.  
> > 
> > Right, I don't think you've touched *any* of the x86 PMUs for example,
> > and getting everybody that boots an x86 kernel a warning isn't going to
> > go over well :-)
> > 
> 
> It was tempting :) "Warning: Parentless PMU: try a different architecture."

Haha!

> I'd love some inputs on what the x86 PMU devices parents should be?
> CPU counters in general tend to just spin out of deep in the architecture code.

For the 'simple' ones I suppose we can use the CPU device.

> My overall favorite is an l2 cache related PMU that is spun up in
> arch/arm/kernel/irq.c init_IRQ()

Yeah, we're going to have a ton of them as well. Some of them are PCI
devices and have a clear parent, others, not so much :/
