Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818726D9E35
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Apr 2023 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDFRIv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Apr 2023 13:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDFRIu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Apr 2023 13:08:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6901A83F2;
        Thu,  6 Apr 2023 10:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07547649B3;
        Thu,  6 Apr 2023 17:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CBEC433EF;
        Thu,  6 Apr 2023 17:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680800928;
        bh=1B1sR1zgH1Xw7J4RVXwXydm6RpI/xuxwQ0JKdZa9ZfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wJTj3+bpSdYGnEZdPQ24xH1ZlnIUwErVNzn8xF0c2H/eorEakxi/FWD9BM1Ba1PoL
         hXZ/veihjgi0oxxvQQOVmZNjTEz5+K2k1QZt4SwwLTdywEnkVz/0bdXgB+hLQwbEEF
         YPbpZQFV10T6m8wAIk3VpSBqFwn66yObRxEeTqxM=
Date:   Thu, 6 Apr 2023 19:08:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yicong Yang <yangyicong@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, yangyicong@hisilicon.com,
        linuxarm@huawei.com, Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <2023040610-morbidly-supermom-e81c@gregkh>
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
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
> 
> I'd love some inputs on what the x86 PMU devices parents should be?
> CPU counters in general tend to just spin out of deep in the architecture code.
> 
> My overall favorite is an l2 cache related PMU that is spun up in
> arch/arm/kernel/irq.c init_IRQ()
> 
> I'm just not going to try and figure out why...

Why not change the api to force a parent to be passed in?  And if one
isn't, we make it a "virtual" device and throw it in the class for them?

thanks,

greg k-h
