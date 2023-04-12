Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE66DF144
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Apr 2023 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDLJ5A (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 Apr 2023 05:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjDLJ47 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 12 Apr 2023 05:56:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6737295;
        Wed, 12 Apr 2023 02:56:57 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxJ2w0HmHz6J6wc;
        Wed, 12 Apr 2023 17:54:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Apr
 2023 10:56:53 +0100
Date:   Wed, 12 Apr 2023 10:56:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Yicong Yang <yangyicong@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yangyicong@hisilicon.com>,
        <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        "Khuong Dinh" <khuong@os.amperecomputing.com>,
        Robert Richter <rric@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Frank Li <Frank.li@nxp.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
Subject: Re: [PATCH 01/32] perf: Allow a PMU to have a parent
Message-ID: <20230412105650.000014f9@Huawei.com>
In-Reply-To: <2023040610-morbidly-supermom-e81c@gregkh>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
        <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
        <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
        <20230406111607.00007be5@Huawei.com>
        <20230406124040.GD392176@hirez.programming.kicks-ass.net>
        <20230406174445.0000235c@Huawei.com>
        <2023040610-morbidly-supermom-e81c@gregkh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 6 Apr 2023 19:08:45 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 06, 2023 at 05:44:45PM +0100, Jonathan Cameron wrote:
> > On Thu, 6 Apr 2023 14:40:40 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Thu, Apr 06, 2023 at 11:16:07AM +0100, Jonathan Cameron wrote:
> > >   
> > > > In the long run I agree it would be good.  Short term there are more instances of
> > > > struct pmu that don't have parents than those that do (even after this series).
> > > > We need to figure out what to do about those before adding checks on it being
> > > > set.    
> > > 
> > > Right, I don't think you've touched *any* of the x86 PMUs for example,
> > > and getting everybody that boots an x86 kernel a warning isn't going to
> > > go over well :-)
> > >   
> > 
> > It was tempting :) "Warning: Parentless PMU: try a different architecture."
> > 
> > I'd love some inputs on what the x86 PMU devices parents should be?
> > CPU counters in general tend to just spin out of deep in the architecture code.
> > 
> > My overall favorite is an l2 cache related PMU that is spun up in
> > arch/arm/kernel/irq.c init_IRQ()
> > 
> > I'm just not going to try and figure out why...  
> 
> Why not change the api to force a parent to be passed in?  And if one
> isn't, we make it a "virtual" device and throw it in the class for them?

Longer term I'd be fine doing that, but I'd like to identify the right parents
rather than end up sweeping it under the carpet.  Anything we either get completely
stuck on (or decide we don't care about) could indeed fall back to a virtual
device.

Jonathan


> 
> thanks,
> 
> greg k-h

